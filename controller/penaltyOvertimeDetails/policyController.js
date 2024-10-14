const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function getAllEarlyLeavePolicy(req, res) {
    try {
        const policies = await prisma.earlyLeavePolicy.findMany();
        res.status(200).json(policies);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to get policies" });
    }
}

async function createEarlyLeavePolicy(req, res) {
    try {
        const { fineType, gracePeriodMins, fineAmountMins, waiveOffDays } = req.body;

        const newEarlyLeavePolicy = await prisma.earlyLeavePolicy.create({
            data: {
                fineType,
                gracePeriodMins,
                fineAmountMins,
                waiveOffDays,
            },
        });

        res.status(201).json(newEarlyLeavePolicy);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to create Early Leave Policy" });
    }
}

async function getAllLateComingPolicy(req, res) {
    try {
        const policies = await prisma.lateComingPolicy.findMany();
        res.status(200).json(policies);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to get policies" });
    }
}
async function createLateComingPolicy(req, res) {
    try {
        const { fineType, gracePeriodMins, fineAmountMins, waiveOffDays } = req.body;

        const newLateComingPolicy = await prisma.lateComingPolicy.create({
            data: {
                fineType,
                gracePeriodMins,
                fineAmountMins,
                waiveOffDays,
            },
        });

        res.status(201).json(newLateComingPolicy);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to create Late Coming Policy" });
    }
}

async function getAllOvertimePolicy(req, res) {
    try {
        const policies = await prisma.overtimePolicy.findMany();
        res.status(200).json(policies);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to get policies" });
    }
}
async function createOvertimePolicy(req, res) {
    try {
        const { gracePeriodMins, extraHoursPay, publicHolidayPay, weekOffPay } = req.body;

        const newOvertimePolicy = await prisma.overtimePolicy.create({
            data: {
                gracePeriodMins,
                extraHoursPay,
                publicHolidayPay,
                weekOffPay,
            },
        });

        res.status(201).json(newOvertimePolicy);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to create Overtime Policy" });
    }
}

module.exports = {
    createEarlyLeavePolicy,
    createLateComingPolicy,
    createOvertimePolicy,
    getAllEarlyLeavePolicy,
    getAllLateComingPolicy,
    getAllOvertimePolicy
}