const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const ShiftSchema = require('../../utils/validations').ShiftSchema;
const { ZodError } = require('zod');
const { FixedShiftSchema, FlexibleShiftSchema } = require('../../utils/validations');


async function getShiftById(req, res) {
    const { id } = req.params;
    try {
        const shift = await prisma.shifts.findUnique({ where: { id } });
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
        const { shiftName, shiftStartTime, shiftEndTime, punchInTime, punchOutTime, punchInType, punchOutType, flexibleId, fixedId } = req.body;    
        
        const shiftResult = ShiftSchema.safeParse({
            shiftName,
            shiftStartTime,
            shiftEndTime,
            punchInTime,
            punchOutTime,
            punchInType,    
            punchOutType,
            flexibleId,
            fixedId
        });
        const newShiftPolicy = await prisma.shifts.create({
            data: shiftResult.data,
        });
        res.status(201).json(newShiftPolicy);
    } catch (error) {
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
    const { shiftName, shiftStartTime, shiftEndTime, punchInTime, punchOutTime, punchInType, punchOutType } = req.body;
    try {
        const shift = await prisma.shifts.update({
            where: { id },
            data: {
                shiftName,
                shiftStartTime,
                shiftEndTime,
                punchInTime,
                punchOutTime,
                punchInType,    
                punchOutType,
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
        const shifts = await prisma.shifts.findMany();
        res.status(200).json(shifts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch shifts" });
    }
}


async function getFixedShifts(req, res) {
    try {
        const fixedShifts = await prisma.fixedShift.findMany();
        res.status(200).json(fixedShifts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch fixed shifts" });
    }
}

async function createFixedShift(req, res) {
    try {
        const { day, weekOff, staffId } = req.body;
        // Check if the staff member exists
        const staffExists = await prisma.staff.findUnique({
            where: { id: staffId },
        });
        if (!staffExists) {
            return res.status(404).json({ error: 'Staff not found' });
        }
        const fixedShiftResult = FixedShiftSchema.parse({
            day,
            weekOff,
            staffId
        })


        const fixedShift = await prisma.fixedShift.create({
            data: fixedShiftResult
        });
        res.status(201).json(fixedShift);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
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
        const { day, weekOff, staffId } = req.body;

        // Check if the staff member exists
        const staffExists = await prisma.staff.findUnique({
            where: { id: staffId },
        });

        if (!staffExists) {
            return res.status(404).json({ error: 'Staff not found' });
        }
        const fexibleShiftResult = FlexibleShiftSchema.parse({
            day,
            weekOff,
            staffId
        })


        const flexibleShift = await prisma.flexibleShift.create({
            data: fexibleShiftResult
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
                        punchInTime: shift.punchInTime,
                        punchOutTime: shift.punchOutTime,
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
