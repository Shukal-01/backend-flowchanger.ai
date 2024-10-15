const zod = require("zod");

const EarlyLeavePolicySchema = zod.object({
    fineType: zod.string().refine((value) => ["HOURLY", "DAILY"]).optional(),
    gracePeriodMins: zod.number().int().optional(),
    fineAmountMins: zod.number().int().optional(),
    waiveOffDays: zod.number().int().optional(),
});

const LateComingPolicySchema = zod.object({
    fineType: zod.string().refine((value) => ["HOURLY", "DAILY"]).optional(),
    gracePeriodMins: zod.number().int().optional(),
    fineAmountMins: zod.number().int().optional(),
    waiveOffDays: zod.number().int().optional(),
});

const OvertimePolicySchema = zod.object({
    gracePeriodMins: zod.number().int().optional(),
    extraHoursPay: zod.number().int().optional(),
    publicHolidayPay: zod.number().int().optional(),
    weekOffPay: zod.number().int().optional(),
});

module.exports = {
    EarlyLeavePolicySchema,
    LateComingPolicySchema,
    OvertimePolicySchema,
};