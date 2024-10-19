const z = require("zod");

const idSchema = z.string().uuid("Invalid UUID format");

const allPermissionSchema = z.object({
  clients_permissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      view_global: z.boolean().default(false).optional(),
    })
    .optional(),
  projects_permissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      view_global: z.boolean().default(false).optional(),
    })
    .optional(),
  report_permissions: z
    .object({
      view_global: z.boolean().default(false).optional(),
      view_time_sheets: z.boolean().default(false).optional(),
    })
    .optional(),
  staff_role_permissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      view_global: z.boolean().default(false).optional(),
    })
    .optional(),
  settings_permissions: z
    .object({
      view_global: z.boolean().default(false).optional(),
      view_time_sheets: z.boolean().default(false).optional(),
    })
    .optional(),
  staff_permissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      view_global: z.boolean().default(false).optional(),
    })
    .optional(),
  task_permissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      view_global: z.boolean().default(false).optional(),
    })
    .optional(),
  sub_task_permissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      view_global: z.boolean().default(false).optional(),
    })
    .optional(),
  chat_module_permissions: z
    .object({
      grant_access: z.boolean().default(false).optional(),
    })
    .optional(),
  ai_permissions: z
    .object({
      grant_access: z.boolean().default(false).optional(),
    })
    .optional(),
});

const roleNameSchema = z
  .string()
  .regex(/^[a-zA-Z\s]+$/, "Role name can only contain alphabets and spaces");

const newRoleSchema = z.object({
  roleName: roleNameSchema.min(2, "role name is required"),
  permissions: allPermissionSchema.optional(),
});

const updateRoleSchema = z.object({
  role_name: roleNameSchema.optional(),
  permissions: allPermissionSchema.optional(),
});

const staffIds = z.array(z.string().uuid()).min(1, "staff ids are required");

const attendenceAutomationRuleSchema = z.object({
  staff_ids: staffIds,
  automation_rules: z
    .object({
      auto_absent: z.boolean().optional(),
      present_on_punch: z.boolean().optional(),
      auto_half_day: z.string().optional(),
      mandatory_half_day: z.string().optional(),
      mandatory_full_day: z.string().optional(),
    })
    .optional(),
});

const attendanceModeSchema = z.object({
  staff_ids: staffIds,
  attendence_mode: z.object({
    selfie_attendance: z.boolean().default(false),
    qr_attendance: z.boolean().default(false),
    gps_attendance: z.boolean().default(false),
    mark_attendance: z.enum(["Office", "Anywhere"]).default("Office"),
    allow_punch_in_for_mobile: z.boolean().default(false),
  }),
});

const multipleStaffBankDetailSchema = z.array(
  z.object({
    staff_id: z.string().uuid("Invalid staff ID"),
    bank_name: z.string().min(1, "Bank name is required"),
    account_number: z
      .string()
      .length(12, "Account number must be exactly 12 digits") // Assuming a fixed length based on provided data
      .regex(/^\d{12}$/, "Account number should only contain digits"),
    account_holder_name: z
      .string()
      .min(3, "Account holder name must be at least 3 characters"),
    branch_name: z
      .string()
      .min(3, "Branch name should have at least 3 characters")
      .max(60, "Branch name should have at most 60 characters"),
    ifsc_code: z
      .string()
      .regex(/^[A-Z]{4}0[A-Z0-9]{6}$/, "Invalid IFSC code")
      .length(11, "IFSC code must be exactly 11 characters"),
  })
);

const aadhaarNumberPattern = /^\d{4}-\d{4}-\d{4}$/; // Format: 1234-5678-9012
const panNumberPattern = /^[A-Z]{5}\d{4}[A-Z]$/; // Format: ABCDE1234F
const uanNumberPattern = /^\d{12}$/; // 12 digits
const drivingLicensePattern = /^[A-Z]{2}[0-9]{2}[0-9]{1,11}$/;

const staffBackgroundVerificationSchema = z.object({
  aadhaar_number: z
    .string()
    .regex(aadhaarNumberPattern, "invalid Aadhaar number format")
    .optional(),
  aadhaar_verification_status: z.string().default("Not Verified").optional(),
  aadhaar_file: z.string().optional(),
  pan_number: z
    .string()
    .regex(panNumberPattern, "invalid pan number format")
    .optional(),
  pan_verification_status: z.string().default("Not Verified").optional(),
  pan_file: z.string().optional(),
  uan_number: z
    .string()
    .regex(uanNumberPattern, "Invalid uan number format")
    .optional(),
  uan_verification_status: z.string().default("Not Verified").optional(),
  uan_file: z.string().optional(),
  driving_license_number: z
    .string()
    .regex(drivingLicensePattern, "Invalid driving license number format")
    .optional(),
  driving_license_status: z.string().default("Not Verified").optional(),
  driving_license_file: z.string().optional(),
  face_file: z.string().optional(),
  face_verification_status: z.string().default("Not Verified").optional(),
  current_address: z.string().optional(),
  permanent_address: z.string().optional(),
  address_status: z.string().default("Not Verified").optional(),
  address_file: z.string().optional(),
  staffId: z.string().optional(),
});

const clientSchema = z.object({
  company: z.string().min(1, "Company name is required"),
  vat_number: z
    .string()
    .regex(
      /^[A-Z0-9]{8,12}$/,
      "VAT number must be 8-12 characters long, containing only uppercase letters and digits"
    ),
  phone: z
    .string()
    .regex(
      /^\+?\d{7,15}$/,
      "Phone number must be 7 to 15 digits, with an optional '+' prefix"
    ),
  website: z.string(),
  groups: z.array(z.string()).min(1, "At least one group is required"),
  currency: z.array(z.string()).min(1, "At least one group is required"),
  default_language: z
    .array(z.string())
    .min(1, "At least one group is required"),
  address: z.string().min(1, "Address is required"),
  country: z.string().min(2, "Country name is required"),
  state: z.string().min(2, "State name is required"),
  city: z.string().min(1, "City name is required"),
  status: z.enum(["active", "inactive"]).default("inactive"),
  zip_code: z.string().regex(/^\d{4,10}$/, "ZIP code must be 4 to 10 digits"),
});
const staffSchema = z.object({
  name: z.string({
    required_error: "Name is required",
  }),
  job_title: z.string().optional(),
  branch: z.string().optional(),
  departmentId: z.string().optional(),
  roleId: z.string().optional(),
  mobile: z
    .string()
    .min(10, "Mobile number should be at least 10 digits")
    .optional(),
  login_otp: z.string().optional(),
  gender: z.string().optional(),
  official_email: z.string().email("Invalid email format").optional(),
  date_of_joining: z
    .string()
    .optional()
    .refine((val) => !val || !isNaN(Date.parse(val)), {
      message: "Invalid date format for date_of_joining",
    }),
  date_of_birth: z
    .string()
    .optional()
    .refine((val) => !val || !isNaN(Date.parse(val)), {
      message: "Invalid date format for date_of_birth",
    }),
  current_address: z.string().optional(),
  permanent_address: z.string().optional(),
  emergency_contact_name: z.string().optional(),
  emergency_contact_mobile: z
    .string()
    .min(10, "Emergency contact number should be at least 10 digits")
    .optional(),
  emergency_contact_relation: z.string().optional(),
  emergency_contact_address: z.string().optional(),
});

const bankDetailsSchema = z.object({
  bank_name: z.string().min(1, "Bank name is required").optional(),
  account_number: z
    .string()
    .regex(/^[0-9]+$/, "Account number must be numeric")
    .optional(),
  branch_name: z.string().min(1, "Branch name is required").optional(),
  ifsc_code: z
    .string()
    .regex(/^[A-Za-z]{4}\d{7}$/, "Invalid IFSC code")
    .optional(),
});

const leavePolicySchema = z.object({
  staffId: z.string().uuid(),
  name: z.string().min(1, "Name is required"),
  allowed_leaves: z.number().min(0).default(0),
  carry_forward_leaves: z.number().min(0).default(0),
});

const leaveBalanceSchema = z.object({
  staffId: z.string().uuid(),
  leaveTypeId: z.string().uuid(),
  balance: z.number().min(0).default(0),
  used: z.number().min(0).default(0),
});

const leaveRequestSchema = z.object({
  staffId: z.string().uuid(),
  leaveTypeId: z.string().uuid(),
  request_date: z.date().optional().default(new Date()),
  start_date: z.date(),
  end_date: z.date(),
  status: z.string().min(1, "Status is required"),
});

const createLeaveBalanceSchema = leaveBalanceSchema
  .omit({ leaveTypeId: true, staffId: true })
  .partial();

const updateLeaveBalanceSchema = leaveBalanceSchema.partial();

const createLeaveRequestSchema = leaveRequestSchema
  .omit({ staffId: true })
  .partial();

const updateLeaveRequestSchema = z.object({
  status: z.string().optional(),
});
const EarlyLeavePolicySchema = z.object({
  fineType: z
    .string()
    .refine((value) => ["HOURLY", "DAILY"].includes(value), {
      message: "Fine Type must be either 'HOURLY' or 'DAILY'.",
    })
    .optional(),
  gracePeriodMins: z
    .number()
    .int({ message: "Grace Period must be an integer." })
    .optional(),
  fineAmountMins: z
    .number()
    .int({ message: "Fine Amount must be an integer." })
    .optional(),
  waiveOffDays: z
    .number()
    .int({ message: "Waive Off Days must be an integer." })
    .optional(),
  panaltyOvertimeDetailId: z
    .string()
    .min(1, { message: "Staff ID is required." }),
});

const LateComingPolicySchema = z.object({
  fineType: z
    .string()
    .refine((value) => ["HOURLY", "DAILY"].includes(value), {
      message: "Fine Type must be either 'HOURLY' or 'DAILY'.",
    })
    .optional(),
  gracePeriodMins: z
    .number()
    .int({ message: "Grace Period must be an integer." })
    .optional(),
  fineAmountMins: z
    .number()
    .int({ message: "Fine Amount must be an integer." })
    .optional(),
  waiveOffDays: z
    .number()
    .int({ message: "Waive Off Days must be an integer." })
    .optional(),
  panaltyOvertimeDetailId: z
    .string()
    .min(1, { message: "Staff ID is required." }),
});

const OvertimePolicySchema = z.object({
  gracePeriodMins: z
    .number()
    .int({ message: "Grace Period must be an integer." })
    .optional(),
  extraHoursPay: z
    .number()
    .int({ message: "Extra Hours Pay must be an integer." })
    .optional(),
  publicHolidayPay: z
    .number()
    .int({ message: "Public Holiday Pay must be an integer." })
    .optional(),
  weekOffPay: z
    .number()
    .int({ message: "Week Off Pay must be an integer." })
    .optional(),
  panaltyOvertimeDetailId: z
    .string()
    .min(1, { message: "Staff ID is required." }),
});

const FlexibleShiftSchema = z.object({
  day: z.string().min(1, { message: "Day is required." }),
  weekOff: z.boolean().refine((val) => typeof val === "boolean", {
    message: "Week Off must be a boolean.",
  }),
  staffId: z.string().min(1, { message: "Staff ID is required." }),
});

const FixedShiftSchema = z.object({
  day: z.string().min(1, { message: "Day is required." }),
  weekOff: z.boolean().refine((val) => typeof val === "boolean", {
    message: "Week Off must be a boolean.",
  }),
  staffId: z.string().min(1, { message: "Staff ID is required." }),
});

const ShiftSchema = z.object({
  shiftName: z.string().min(1, "Shift name is required"),
  shiftStartTime: z
    .string()
    .regex(
      /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/,
      "Invalid shift start time format (HH:mm)"
    ),
  shiftEndTime: z
    .string()
    .regex(
      /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/,
      "Invalid shift end time format (HH:mm)"
    ),
  punchInTime: z
    .string()
    .regex(
      /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/,
      "Invalid punch in time format (HH:mm)"
    ),
  punchOutTime: z
    .string()
    .regex(
      /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/,
      "Invalid punch out time format (HH:mm)"
    ),
  punchInType: z
    .string()
    .refine((value) => ["ANYTIME", "ADDLIMIT"].includes(value), {
      message: "PunchIn Type must be either 'ANYTIME' or 'ADDLIMIT'.",
    })
    .optional(),
  punchOutType: z
    .string()
    .refine((value) => ["ANYTIME", "ADDLIMIT"].includes(value), {
      message: "PunchOut Type must be either 'ANYTIME' or 'ADDLIMIT'.",
    })
    .optional(),
  flexibleId: z.string().min(1, { message: "Staff ID is required." }),
  fixedId: z.string().min(1, { message: "Staff ID is required." }),
});

const PunchInSchema = z.object({
  punchInMethod: z
    .string()
    .refine((value) => ["BIOMETRIC", "QRSCAN", "PHOTOCLICK"].includes(value), {
      message:
        "PunchInType Type must be either 'BIOMETRIC', 'QRSCAN' Or 'PHOTOCLICK'.",
    })
    .optional(),
  biometricData: z.string().optional(), // Only required for biometric
  qrCodeValue: z.string().optional(), // Only required for QR scan
  photoUrl: z.string().optional(), // Required for photo click
  staffId: z.string().min(1, { message: "Staff ID is required." }),
});

const PunchOutSchema = z.object({
  punchOutMethod: z
    .string()
    .refine((value) => ["BIOMETRIC", "QRSCAN", "PHOTOCLICK"].includes(value), {
      message:
        "PunchInType Type must be either 'BIOMETRIC', 'QRSCAN' Or 'PHOTOCLICK'.",
    })
    .optional(),
  biometricData: z.string().optional(), // Only required for biometric
  qrCodeValue: z.string().optional(), // Only required for QR scan
  photoUrl: z.string().optional(), // Required for photo click
  staffId: z.string().min(1, { message: "Staff ID is required." }),
});

const PunchRecordsSchema = z.object({
  punchInId: z.string().min(1, { message: "PunchInId is required." }),
  punchOutId: z.string().min(1, { message: "PunchOutId is required." }),
  staffId: z.string().min(1, { message: 'StaffId is required.' }),
});

const TaskTypeSchema = z.object({
  taskTypeName: z.string().min(1, "Task Type name is required"),
});

const TaskStatusSchema = z.object({
  taskStatusName: z.string().min(1, "Task Status name is required"),
});

const TaskPrioritySchema = z.object({
  taskPriorityName: z.string().min(1, "Task Priority name is required"),
});

const TaskDetailSchema = z.object({
  taskName: z.string().min(1, { message: "Task name is required" }),
  taskStatusId: z.string().uuid({ message: "Invalid task status ID" }),
  taskTypeId: z.string().uuid({ message: "Invalid task type ID" }),
  taskPriorityId: z.string().uuid({ message: "Invalid task priority ID" }),
  startDate: z.string(),
  endDate: z.string(),
  dueDate: z.string().optional(),
  selectProject: z.string().min(1, { message: "Project selection is required" }),
  selectDepartment: z.string().min(1, { message: "Department selection is required" }),
  taskAssign: z.string().min(1, { message: "Task assignee is required" }),
  taskDescription: z.string().optional(),
  attachFile: z.string().optional(),
});


module.exports = {
  clientSchema,
  idSchema,
  newRoleSchema,
  updateRoleSchema,
  attendenceAutomationRuleSchema,
  attendanceModeSchema,
  multipleStaffBankDetailSchema,
  staffBackgroundVerificationSchema,
  roleNameSchema,
  bankDetailsSchema,
  staffSchema,
  leavePolicySchema,
  createLeaveBalanceSchema,
  updateLeaveBalanceSchema,
  createLeaveRequestSchema,
  updateLeaveRequestSchema,
  EarlyLeavePolicySchema,
  LateComingPolicySchema,
  OvertimePolicySchema,
  FlexibleShiftSchema,
  FixedShiftSchema,
  ShiftSchema,
  PunchInSchema,
  PunchOutSchema,
  PunchRecordsSchema,
};
