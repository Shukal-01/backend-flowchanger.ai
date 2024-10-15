const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const EarlyLeavePolicySchema = require('../../utils/validations').EarlyLeavePolicySchema;
const { ZodError } = require('zod');
const LateComingPolicySchema = require('../../utils/validations').LateComingPolicySchema;
const OvertimePolicySchema = require('../../utils/validations').OvertimePolicySchema;

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

        
        const earlyLeavePolicyResult = EarlyLeavePolicySchema.safeParse({
            fineType,
            gracePeriodMins,
            fineAmountMins,
            waiveOffDays,
        });

        if (!earlyLeavePolicyResult.success) {
            return res.status(400).json({ error: earlyLeavePolicyResult.error.format() });
        }


        const newEarlyLeavePolicy = await prisma.earlyLeavePolicy.create({
            data: earlyLeavePolicyResult.data,
        });

        res.status(201).json(newEarlyLeavePolicy);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
            res.status(500).json({ error: 'Failed to create Early Leave Policy' });
        }
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


        const lateComingPolicyResult = LateComingPolicySchema.safeParse({
            fineType,
            gracePeriodMins,
            fineAmountMins,
            waiveOffDays,
        });        
        
        
        if (!lateComingPolicyResult.success) {
            return res.status(400).json({ error: lateComingPolicyResult.error.format() });
        }

        
        const newLateComingPolicy = await prisma.lateComingPolicy.create({
            data: lateComingPolicyResult.data,
        });

        res.status(201).json(newLateComingPolicy);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
            res.status(500).json({ error: 'Failed to create Late Coming Policy' });
        }
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

        
        const overtimePolicyResult = OvertimePolicySchema.safeParse({
            gracePeriodMins,
            extraHoursPay,
            publicHolidayPay,
            weekOffPay,
        });        
        
        
        if (!overtimePolicyResult.success) {
            return res.status(400).json({ error: overtimePolicyResult.error.format() });
        }

        // Use the valid data from overtimePolicyResult.data
        const newOvertimePolicy = await prisma.overtimePolicy.create({
            data: overtimePolicyResult.data,
        });

        res.status(201).json(newOvertimePolicy);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
            res.status(500).json({ error: 'Failed to create Overtime Policy' });
        }
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