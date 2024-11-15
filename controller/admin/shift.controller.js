const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const ShiftSchema = require('../../utils/validations').ShiftSchema;
const { ZodError } = require('zod');
const { FixedShiftSchema, FlexibleShiftSchema, weekOffShiftSchema } = require('../../utils/validations');


async function getShiftById(req, res) {
    const { id } = req.params;
    try {
        const shift = await prisma.shifts.findUnique({
            where: { id },
            include: {
                fixedShifts: true,
                flexibleShifts: true,
                weekOffShifts: true,
                Fine: true
            }
        });
        if (!shift) {
            return res.status(404).json({ error: "Shift not found" });
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

async function getAllShift(req, res) {
    try {
        const shifts = await prisma.shifts.findMany({
            include: {
                FixedShift: true,
                FlexibleShift: true,
                WeekOffShift: true,
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
            console.log(weekOffEntry)
        }


        // Create the FixedShift entry, including the newly created weekId if applicable
        const fixedShift = await prisma.fixedShift.create({
            data: {
                day: fixedShiftResult.day,
                weekOff: fixedShiftResult.weekOff,
                staffId: fixedShiftResult.staffId,
                // shifts: { connect: fixedShiftResult.shifts.map(id => ({ id })) }, // Link shift IDs if provided
                shifts: fixedShiftResult.shifts,
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


async function getFlexibleShifts(req, res) {
    try {
        const flexibleShifts = await prisma.flexibleShift.findMany();
        res.status(200).json(flexibleShifts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch fixed shifts" });
    }
}

async function createFlexibleShift(req, res) {
    try {
        const { dateTime, weekOff, staffId, shifts } = req.body;

        // Check if the staff member exists
        const staffExists = await prisma.staff.findUnique({
            where: { id: staffId },
        });

        if (!staffExists) {
            return res.status(404).json({ error: 'Staff not found' });
        }
        const fexibleShiftResult = FlexibleShiftSchema.safeParse({
            weekOff,
            staffId,
            shifts,
            dateTime
        })

        const flexibleShift = await prisma.flexibleShift.create({

            data: {
                dateTime: FlexibleShiftSchema.dateTime,
                weekOff: FlexibleShiftSchema.weekOff,
                staffId: FlexibleShiftSchema.staffId,
                // shifts: { connect: FlexibleShiftSchema.shifts.map(id => ({ id })) }, // Link shift IDs if provided
                shifts: FlexibleShiftSchema.shifts,
            },
            include: {
                // shifts: true, // Include related shifts
                staff: true, // Include related staff details
            },
        }
        );

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


module.exports = { getShiftById, createShift, updateShift, getAllShift, getFixedShifts, createFixedShift, getFlexibleShifts, createFlexibleShift, updateMultipleShifts };
