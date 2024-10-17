const zod = require("zod");
// const penaltyOvertimeDetailRouter = require("../router/admin/penaltyOvertimeDetail.router");


const EarlyLeavePolicySchema = zod.object({
    fineType: zod.string().refine((value) => ["HOURLY", "DAILY"].includes(value), {
        message: "Fine Type must be either 'HOURLY' or 'DAILY'.",
    }).optional(),
    gracePeriodMins: zod.number().int({ message: "Grace Period must be an integer." }).optional(),
    fineAmountMins: zod.number().int({ message: "Fine Amount must be an integer." }).optional(),
    waiveOffDays: zod.number().int({ message: "Waive Off Days must be an integer." }).optional(),
    panaltyOvertimeDetailId: zod.string().min(1, { message: "Staff ID is required." }),
});

const LateComingPolicySchema = zod.object({
    fineType: zod.string().refine((value) => ["HOURLY", "DAILY"].includes(value), {
        message: "Fine Type must be either 'HOURLY' or 'DAILY'.",
    }).optional(),
    gracePeriodMins: zod.number().int({ message: "Grace Period must be an integer." }).optional(),
    fineAmountMins: zod.number().int({ message: "Fine Amount must be an integer." }).optional(),
    waiveOffDays: zod.number().int({ message: "Waive Off Days must be an integer." }).optional(),
    panaltyOvertimeDetailId: zod.string().min(1, { message: "Staff ID is required." }),
});

const OvertimePolicySchema = zod.object({
    gracePeriodMins: zod.number().int({ message: "Grace Period must be an integer." }).optional(),
    extraHoursPay: zod.number().int({ message: "Extra Hours Pay must be an integer." }).optional(),
    publicHolidayPay: zod.number().int({ message: "Public Holiday Pay must be an integer." }).optional(),
    weekOffPay: zod.number().int({ message: "Week Off Pay must be an integer." }).optional(),
    panaltyOvertimeDetailId: zod.string().min(1, { message: "Staff ID is required." }),
});

const FlexibleShiftSchema = zod.object({
    day: zod.string().min(1, { message: "Day is required." }),
    weekOff: zod.boolean().refine(val => typeof val === 'boolean', {
        message: "Week Off must be a boolean.",
    }),
    staffId: zod.string().min(1, { message: "Staff ID is required." }),
});

const FixedShiftSchema = zod.object({
    day: zod.string().min(1,{ message: "Day is required." }),
    weekOff: zod.boolean().refine(val => typeof val === 'boolean', {
        message: "Week Off must be a boolean.",
    }),
    staffId: zod.string().min(1, { message: "Staff ID is required." }),
});


const ShiftSchema = zod.object({
    shiftName: zod.string().min(1, "Shift name is required"),
    shiftStartTime: zod.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/, "Invalid shift start time format (HH:mm)"),
    shiftEndTime: zod.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/, "Invalid shift end time format (HH:mm)"),
    punchInTime: zod.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/, "Invalid punch in time format (HH:mm)"),
    punchOutTime: zod.string().regex(/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/, "Invalid punch out time format (HH:mm)"),
    punchInType: zod.string().refine((value) => ["ANYTIME", "ADDLIMIT"].includes(value), {
        message: "PunchIn Type must be either 'ANYTIME' or 'ADDLIMIT'.",
    }).optional(),
    punchOutType: zod.string().refine((value) => ["ANYTIME", "ADDLIMIT"].includes(value), {
        message: "PunchOut Type must be either 'ANYTIME' or 'ADDLIMIT'.",
    }).optional(),
    flexibleId: zod.string().min(1, { message: "Staff ID is required." }),
    fixedId: zod.string().min(1, { message: "Staff ID is required." })
});


const PunchInSchema = zod.object({
    punchInMethod: zod.string().refine((value) => ["BIOMETRIC", "QRSCAN", "PHOTOCLICK"].includes(value), {
        message: "PunchInType Type must be either 'BIOMETRIC', 'QRSCAN' Or 'PHOTOCLICK'.",
    }).optional(),
    punchInTime: zod.string().optional(),
    punchOutTime: zod.string().optional(),
    biometricData: zod.string().optional(), // Only required for biometric
    qrCodeValue: zod.string().optional(),   // Only required for QR scan
    photoUrl: zod.string().optional(),       // Required for photo click
    staffId: zod.string().min(1, { message: "Staff ID is required." }),
});

module.exports = {
    EarlyLeavePolicySchema,
    LateComingPolicySchema,
    OvertimePolicySchema,
    FlexibleShiftSchema,
    FixedShiftSchema,
    ShiftSchema,
    PunchInSchema
};