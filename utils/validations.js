const zod = require("zod");


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
    day: zod.string().min(1, { message: "Day is required." }),
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
    }),
    punchOutType: zod.string().refine((value) => ["ANYTIME", "ADDLIMIT"].includes(value), {
        message: "PunchOut Type must be either 'ANYTIME' or 'ADDLIMIT'.",
    }),
    flexibleId: zod.string().min(1, { message: "Staff ID is required." }),
    fixedId: zod.string().min(1, { message: "Staff ID is required." })
});


const PunchInSchema = zod.object({
    punchInMethod: zod.string().refine((value) => ["BIOMETRIC", "QRSCAN", "PHOTOCLICK"].includes(value), {
        message: "PunchInType Type must be either 'BIOMETRIC', 'QRSCAN' Or 'PHOTOCLICK'.",
    }).optional(),
    biometricData: zod.string().optional(), // Only required for biometric
    qrCodeValue: zod.string().optional(),   // Only required for QR scan
    photoUrl: zod.string().optional(),       // Required for photo click
    staffId: zod.string().min(1, { message: "Staff ID is required." }),
});

const PunchOutSchema = zod.object({
    punchOutMethod: zod.string().refine((value) => ["BIOMETRIC", "QRSCAN", "PHOTOCLICK"].includes(value), {
        message: "PunchInType Type must be either 'BIOMETRIC', 'QRSCAN' Or 'PHOTOCLICK'.",
    }),
    biometricData: zod.string().optional(), // Only required for biometric
    qrCodeValue: zod.string().optional(),   // Only required for QR scan
    photoUrl: zod.string().optional(),       // Required for photo click
    staffId: zod.string().min(1, { message: "Staff ID is required." }),
});

const PunchRecordsSchema = zod.object({
    punchInId: zod.string().min(1, { message: 'PunchInId is required.' }),
    punchOutId: zod.string().min(1, { message: 'PunchOutId is required.' }),
    staffId: zod.string().min(1, { message: 'StaffId is required.' }),
});

const TaskTypeSchema = zod.object({
    taskTypeName: zod.string().min(1, "Task Type name is required"),
});

const TaskStatusSchema = zod.object({
    taskStatusName: zod.string().min(1, "Task Status name is required"),
});

const TaskPrioritySchema = zod.object({
    taskPriorityName: zod.string().min(1, "Task Priority name is required"),
});

const TaskDetailSchema = zod.object({
    taskName: zod.string().min(1, { message: "Task name is required" }),
    taskStatusId: zod.string().uuid({ message: "Invalid task status ID" }),
    taskTypeId: zod.string().uuid({ message: "Invalid task type ID" }),
    taskPriorityId: zod.string().uuid({ message: "Invalid task priority ID" }),
    startDate: zod.string(),
    endDate: zod.string(),
    dueDate: zod.string().optional(),
    selectProject: zod.string().min(1, { message: "Project selection is required" }),
    selectDepartment: zod.string().min(1, { message: "Department selection is required" }),
    taskAssign: zod.string().min(1, { message: "Task assignee is required" }),
    taskDescription: zod.string().optional(),
    attachFile: zod.string().optional(),
});

module.exports = {
    EarlyLeavePolicySchema,
    LateComingPolicySchema,
    OvertimePolicySchema,
    FlexibleShiftSchema,
    FixedShiftSchema,
    ShiftSchema,
    PunchInSchema,
    PunchOutSchema,
    PunchRecordsSchema,
    TaskTypeSchema,
    TaskStatusSchema,
    TaskPrioritySchema,
    TaskDetailSchema
};