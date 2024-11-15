const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const ShiftSchema = require('../../utils/validations').ShiftSchema;
const { ZodError } = require('zod');
const { FixedShiftSchema, FlexibleShiftSchema, weekOffShiftSchema, MultipleFlexibleShiftSchema, MultipleFixedShiftSchema } = require('../../utils/validations');


async function getShiftById(req, res) {
    const { id } = req.params;
    try {
        const shift = await prisma.shifts.findUnique({
            where: { id },
            include: {
                FixedShifts: true,
                flexibleShift: true,
                Fine: true
            }
        });
        if (!shift) {
            return res.status(200).json({ error: "Shift not found" });
        }
        res.status(200).json(shift);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch shift" });
    }
}


async function createShift(req, res) {
    try {
        const { shiftName, shiftStartTime, shiftEndTime, punchInType, punchOutType, allowPunchInHours, allowPunchInMinutes, allowPunchOutHours, allowPunchOutMinutes } = req.body;

        const shiftResult = ShiftSchema.safeParse({
            shiftName,
            shiftStartTime,
            shiftEndTime,
            punchInType,
            punchOutType,
            allowPunchInHours,
            allowPunchInMinutes,
            allowPunchOutHours,
            allowPunchOutMinutes
        });
        const newShiftPolicy = await prisma.shifts.create({
            data: shiftResult.data,
        });
        res.status(201).json(newShiftPolicy);
    } catch (error) {
        console.log(error)
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
            res.status(500).json({ error: 'Failed to create new shift' });
        }
    }
}

async function updateShift(req, res) {
    const { id } = req.params;
    const { shiftName, shiftStartTime, shiftEndTime, punchInType, punchOutType, allowPunchInHours, allowPunchInMinutes, allowPunchOutHours, allowPunchOutMinutes } = req.body;
    try {
        const shift = await prisma.shifts.update({
            where: { id },
            data: {
                shiftName,
                shiftStartTime,
                shiftEndTime,
                punchInType,
                punchOutType,
                allowPunchInHours,
                allowPunchInMinutes,
                allowPunchOutHours,
                allowPunchOutMinutes
            },
        });
        res.status(200).json(shift);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to update shift" });
    }
}

async function updateMultipleShifts(req, res) {
    const { shifts } = req.body; // Expect an array of shifts

    try {
        const updatedShifts = await prisma.$transaction(
            shifts.map(shift =>
                prisma.shifts.update({
                    where: { id: shift.id },
                    data: {
                        shiftName: shift.shiftName,
                        shiftStartTime: shift.shiftStartTime,
                        shiftEndTime: shift.shiftEndTime,
                        allowPunchInHours: shift.allowPunchInHours,
                        allowPunchInMinutes: shift.allowPunchInMinutes,
                        punchInType: shift.punchInType,
                        punchOutType: shift.punchOutType,
                    }
                })
            )
        );
        res.status(200).json(updatedShifts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to update shifts" });
    }
}

async function getAllShift(req, res) {
    try {
        const shifts = await prisma.shifts.findMany({
            include: {
                FixedShifts: true,
                FlexibleShift: true,
                Fine: true
            }
        });
        res.status(200).json(shifts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch shifts" });
    }
}


async function getFixedShifts(req, res) {
    try {
        const fixedShifts = await prisma.fixedShift.findMany({
            include: {
                week: true, // Include related WeekOff entry
                shifts: true, // Include related Shifts entries
                staff: true, // Include related StaffDetails entry
            },
        });
        res.status(200).json(fixedShifts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch fixed shifts" });
    }
}

async function createFixedShift(req, res) {
    try {
        const { day, weekOff, staffId, shifts } = req.body;

        // Check if the staff member exists
        const staffExists = await prisma.staffDetails.findUnique({
            where: { id: staffId },
        });
        if (!staffExists) {
            return res.status(404).json({ error: 'Staff not found' });
        }
        // Parse and validate input
        const fixedShiftResult = FixedShiftSchema.parse({
            day,
            weekOff,
            staffId,
            shifts: shifts || [], // Default to an empty array if shiftId is undefined
        });

        // Initialize the `weekId` as `null`, we will populate this if `weekOff` is true
        let weekId = null;

        // Create a WeekOff entry if weekOff is true
        if (weekOff) {
            // Validate the weekOffShift data
            const weekOffShiftData = weekOffShiftSchema.parse({
                weekOne: req.body.weekOne,
                weekTwo: req.body.weekTwo,
                weekThree: req.body.weekThree,
                weekFour: req.body.weekFour,
                weekFive: req.body.weekFive,
            });

            const weekOffEntry = await prisma.weekOffShift.create({
                data: weekOffShiftData,
            });
            weekId = weekOffEntry.id;
            // console.log(weekOffEntry)
        }

        // Delete all `FlexibleShift` entries for the specified staffId
        await prisma.flexibleShift.deleteMany({
            where: { staffId }
        });

        // Create the FixedShift entry, including the newly created weekId if applicable
        const fixedShift = await prisma.fixedShift.create({
            data: {
                day: fixedShiftResult.day,
                weekOff: fixedShiftResult.weekOff,
                staffId: fixedShiftResult.staffId,
                shifts: { connect: fixedShiftResult.shifts.map(id => ({ id })) }, // Link shift IDs if provided
                // shifts: fixedShiftResult.shifts,
                weekId, // Link the WeekOff ID if created
            },
            include: {
                week: true, // Include related WeekOff entry
                shifts: true, // Include related shifts
                staff: true, // Include related staff details
            },
        });
        // console.log(fixedShift)
        res.status(201).json(fixedShift);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data', details: error.errors });
        } else {
            console.error(error);
            res.status(500).json({ error: 'Failed to create new fixedShift' });
        }
    }
}

async function updateFixedShifts(req, res) {
    try {
        // Destructure the request body
        const { day, weekOff, staffId, shifts } = req.body;

        // Parse and validate input for updating fixed shifts
        const fixedShiftResult = MultipleFixedShiftSchema.parse({
            day,
            weekOff,
            shifts: shifts || [],
            staffId: staffId // Default to empty array if no shifts are provided
        });

        // Initialize `weekId` if `weekOff` is true and create a `WeekOffShift` entry
        let weekOffShiftData = null;
        if (weekOff) {
            weekOffShiftData = weekOffShiftSchema.parse({
                weekOne: req.body.weekOne,
                weekTwo: req.body.weekTwo,
                weekThree: req.body.weekThree,
                weekFour: req.body.weekFour,
                weekFive: req.body.weekFive,
            });
        }

        // Update or create `FixedShift` entries for each staff
        const updatedFixedShifts = await Promise.all(
            staffId.map(async (id) => {
                // Delete all `FlexibleShift` entries for the current staff member
                await prisma.flexibleShift.deleteMany({
                    where: { staffId: id },
                });
                let weekId = null;

                // Create a unique WeekOffShift entry for each staff member if `weekOff` is true
                if (weekOff) {
                    const newWeekOff = await prisma.weekOffShift.create({
                        data: weekOffShiftData,
                    });
                    weekId = newWeekOff.id; // Assign the unique weekId for this staff member
                }

                // Check if a FixedShift entry already exists
                const existingFixedShift = await prisma.fixedShift.findFirst({
                    where: { staffId: id, day: fixedShiftResult.day, weekId },
                });

                if (existingFixedShift) {
                    // Update the existing entry if found
                    return await prisma.fixedShift.update({
                        where: { id: existingFixedShift.id },
                        data: {
                            day: fixedShiftResult.day,
                            weekOff: fixedShiftResult.weekOff,
                            shifts: { set: fixedShiftResult.shifts.map(shiftId => ({ id: shiftId })) },
                            weekId,
                        },
                        include: {
                            week: true,
                            shifts: true,
                            staff: true,
                        },
                    });
                } else {
                    // Create a new entry if not found
                    return await prisma.fixedShift.create({
                        data: {
                            day: fixedShiftResult.day,
                            weekOff: fixedShiftResult.weekOff,
                            staffId: id,
                            shifts: { connect: fixedShiftResult.shifts.map(shiftId => ({ id: shiftId })) },
                            weekId,
                        },
                        include: {
                            week: true,
                            shifts: true,
                            staff: true,
                        },
                    });
                }
            })
        );

        res.status(200).json({ data: updatedFixedShifts, message: "Fixed shifts updated successfully." });
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data', details: error.message });
        } else {
            console.error(error);
            res.status(500).json({ error: 'Failed to update fixed shifts', details: error.message });
        }
    }
}

async function getFlexibleShifts(req, res) {
    try {
        const flexibleShifts = await prisma.flexibleShift.findMany({
            include: {
                staff: true,
                shifts: true,
            },
        });
        res.status(200).json(flexibleShifts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch fixed shifts" });
    }
}

async function createFlexibleShift(req, res) {
    try {
        const { dateTime, weekOff, staffId, shifts } = req.body;
        // console.log(req.body)
        // Check if the staff member exists
        const staffExists = await prisma.staffDetails.findUnique({
            where: { id: staffId },
        });

        if (!staffExists) {
            return res.status(404).json({ error: 'Staff not found' });
        }
        const fexibleShiftResult = FlexibleShiftSchema.parse({
            weekOff,
            staffId,
            shifts: shifts || [],
            dateTime
        })

        // Delete all `FixedShift` entries for the specified staffId
        await prisma.fixedShift.deleteMany({
            where: { staffId }
        });

        // Create the FlexibleShift entry
        const flexibleShift = await prisma.flexibleShift.create({
            data: {
                dateTime: fexibleShiftResult.dateTime,
                weekOff: fexibleShiftResult.weekOff,
                staffId: fexibleShiftResult.staffId,
                shifts: { connect: fexibleShiftResult.shifts.map(id => ({ id })) }
            },
            include: {
                shifts: true, // Include related shifts
                staff: true, // Include related staff details
            },
        });

        res.status(201).json(flexibleShift);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
            res.status(500).json({ error: 'Failed to create new flexibleShift' });
        }
    }
}

async function updateFlexibleShift(req, res) {
    try {
        const { dateTime, weekOff, staffId, shifts } = req.body;

        // Validate the input data
        const flexibleShiftResult = MultipleFlexibleShiftSchema.safeParse({
            dateTime,
            weekOff,
            staffId,
            shifts: shifts || [],
        });

        if (!flexibleShiftResult.success) {
            return res.status(400).json({ error: 'Invalid request data', details: flexibleShiftResult.error.errors });
        }

        // Process updates for each staff member
        const updatedFlexibleShifts = await Promise.all(
            flexibleShiftResult.data.staffId.map(async (id) => {
                // Check if the staff member exists
                const staffExists = await prisma.staffDetails.findUnique({ where: { id } });
                if (!staffExists) {
                    throw new Error(`Staff with ID ${id} not found`);
                }

                // Delete existing FixedShift entries for this staff member
                await prisma.fixedShift.deleteMany({ where: { staffId: id } });

                // Check if a FlexibleShift entry already exists
                const existingFlexibleShift = await prisma.flexibleShift.findFirst({
                    where: { staffId: id, dateTime: flexibleShiftResult.data.dateTime },
                });

                if (existingFlexibleShift) {
                    // Update the existing FlexibleShift entry
                    return await prisma.flexibleShift.update({
                        where: { id: existingFlexibleShift.id },
                        data: {
                            dateTime: flexibleShiftResult.data.dateTime,
                            weekOff: flexibleShiftResult.data.weekOff,
                            shifts: { set: flexibleShiftResult.data.shifts.map(shiftId => ({ id: shiftId })) },
                        },
                        include: {
                            shifts: true,
                            staff: true,
                        },
                    });
                } else {
                    // Create a new FlexibleShift entry if none exists
                    return await prisma.flexibleShift.create({
                        data: {
                            dateTime: flexibleShiftResult.data.dateTime,
                            weekOff: flexibleShiftResult.data.weekOff,
                            staffId: id,
                            shifts: { connect: flexibleShiftResult.data.shifts.map(shiftId => ({ id: shiftId })) },
                        },
                        include: {
                            shifts: true,
                            staff: true,
                        },
                    });
                }
            })
        );

        res.status(200).json({ data: updatedFlexibleShifts, message: "Flexible shifts updated successfully." });
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data', details: error.errors });
        } else {
            console.error(error);
            res.status(500).json({ error: 'Failed to update flexible shifts', details: error.message });
        }
    }
}


module.exports = { getShiftById, createShift, updateShift, getAllShift, getFixedShifts, createFixedShift, updateFixedShifts, getFlexibleShifts, createFlexibleShift, updateFlexibleShift, updateMultipleShifts };
