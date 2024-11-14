const z = require("zod");

const idSchema = z.string().uuid("Invalid UUID format");

const pastEmploymentSchema = z.object({
  id: z.string().optional(), // UUID is generated, so it can be optional
  company_name: z.string().min(1, "Company name is required."),
  designation: z.string().optional(),
  joining_date: z.preprocess((val) => (val ? new Date(val) : new Date()), z.date()),
  leaving_date: z.preprocess((val) => (val ? new Date(val) : new Date()), z.date()),
  currency: z.string().optional(),
  salary: z.number().optional(),
  company_gst: z.string().optional(),
  staffId: z.string().optional(), // UUID format is optional if not linked initially
  createdAt: z.preprocess((val) => (val ? new Date(val) : new Date()), z.date()).optional(),
  updatedAt: z.preprocess((val) => (val ? new Date(val) : new Date()), z.date()).optional()
});


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
    id: z.string().uuid("Invalid ID"),
    staffId: z.string().uuid("Invalid staff ID"),
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
const voterIdPattern = /^[A-Z]{3}[0-9]{7}$/;

const staffBackgroundVerificationSchema = z.object({
  aadhaar_number: z
    .string()
    .regex(aadhaarNumberPattern, "invalid Aadhaar number format")
    .optional(),
  aadhaar_verification_status: z.string().default("Not Verified").optional(),
  aadhaar_file: z.string().optional().nullable(),
  voter_id_number: z
    .string()
    .regex(voterIdPattern, "invalid voter id number format")
    .optional(),
  voter_id_verification_status: z.string().default("Not Verified").optional(),
  voter_id_file: z.string().optional().nullable(),
  pan_number: z
    .string()
    .regex(panNumberPattern, "invalid pan number format")
    .optional(),
  pan_verification_status: z.string().default("Not Verified").optional(),
  pan_file: z.string().optional().nullable(),
  uan_number: z
    .string()
    .regex(uanNumberPattern, "Invalid uan number format")
    .optional(),
  uan_verification_status: z.string().default("Not Verified").optional(),
  uan_file: z.string().optional().nullable(),
  driving_license_number: z
    .string()
    .regex(drivingLicensePattern, "Invalid driving license number format")
    .optional(),
  driving_license_status: z.string().default("Not Verified").optional(),
  driving_license_file: z.string().optional().nullable(),
  face_file: z.string().optional().nullable(),
  face_verification_status: z.string().default("Not Verified").optional(),
  current_address: z.string().optional(),
  permanent_address: z.string().optional(),
  address_status: z.string().default("Not Verified").optional(),
  address_file: z.string().optional().nullable(),
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
  status: z.boolean().default(false),
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
  request_date: z.coerce.date().optional().default(new Date()),
  start_date: z.coerce.date(),
  end_date: z.coerce.date(),
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
  staffId: z
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
  staffId: z
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
  staffId: z
    .string()
    .min(1, { message: "Staff ID is required." }),
});

const FlexibleShiftSchema = z.object({
  dateTime: z.string().min(1, { message: "Day is required." }),
  weekOff: z.boolean().default(false), // Set default value to false
  staffId: z.string().optional(),
  shiftId: z.string().optional(),
});

const FixedShiftSchema = z.object({
  day: z.string().min(1, { message: "Day is required." }),
  weekOff: z.boolean().default(false), // Set default value to false
  staffId: z.string().optional(),
  shiftId: z.string().optional(),
});

const ShiftSchema = z.object({
  shiftName: z.string().min(1, "Shift name is required"),
  shiftStartTime: z
    .string(),
  shiftEndTime: z
    .string(),
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
  allowPunchInHours: z.number().optional(),
  allowPunchInMinutes: z.number().optional(),
  allowPunchOutHours: z.number().optional(),
  allowPunchOutMinutes: z.number().optional(),
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
  location: z.string().min(1, { message: "Location is required." }),
  fine: z.string().optional(),
  // staffId: z.string().min(1, { message: "Staff ID is required." }),
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
  location: z.string().min(1, { message: "Location is required." }),
  overtime: z.string().optional(),
  // staffId: z.string().min(1, { message: "Staff ID is required." }),
});

const PunchRecordsSchema = z.object({
  punchInId: z.string().min(1, { message: "PunchInId is required." }),
  punchOutId: z.string().min(1, { message: "PunchOutId is required." }),
  staffId: z.string().min(1, { message: 'StaffId is required.' }),
});

// const TaskTypeSchema = z.object({
//   taskTypeName: z.string().min(1, "Task Type name is required"),
// });

const StartBreakSchema = z.object({
  breakMethod: z
    .string()
    .refine((value) => ["BIOMETRIC", "QRSCAN", "PHOTOCLICK"].includes(value), {
      message:
        "Break Method Type must be either 'BIOMETRIC', 'QRSCAN' Or 'PHOTOCLICK'.",
    })
    .optional(),
  biometricData: z.string().optional(), // Only required for biometric
  qrCodeValue: z.string().optional(), // Only required for QR scan
  photoUrl: z.string().optional(), // Required for photo click
  location: z.string().min(1, { message: "Location is required." }),
  staffId: z.string().min(1, { message: "Staff ID is required." }),
});

const EndBreakSchema = z.object({
  breakMethod: z
    .string()
    .refine((value) => ["BIOMETRIC", "QRSCAN", "PHOTOCLICK"].includes(value), {
      message:
        "Break Method Type must be either 'BIOMETRIC', 'QRSCAN' Or 'PHOTOCLICK'.",
    })
    .optional(),
  biometricData: z.string().optional(), // Only required for biometric
  qrCodeValue: z.string().optional(), // Only required for QR scan
  photoUrl: z.string().optional(), // Required for photo click
  location: z.string().min(1, { message: "Location is required." }),
  staffId: z.string().min(1, { message: "Staff ID is required." }),
});

const TaskStatusSchema = z.object({
  taskStatusName: z.string().min(1, "Task Status name is required"),
  statusColor: z.string().optional(),
  statusOrder: z.number().min(1, "Status Order is required"),
  isHiddenId: z.array(z.string()),  // Define as an array of numbers
  canBeChangedId: z.array(z.string()).default([]).optional()
});

const TaskPrioritySchema = z.object({
  taskPriorityName: z.string().min(1, "Task Priority name is required"),
});

const TaskDetailSchema = z.object({
  taskName: z.string().min(1, { message: "Task name is required" }),
  taskStatusId: z.string().uuid({ message: "Invalid task status ID" }),
  // taskTypeId: z.string().uuid({ message: "Invalid task type ID" }),
  taskPriorityId: z.string().uuid({ message: "Invalid task priority ID" }),
  startDate: z.string(),
  endDate: z.string().optional(),
  dueDate: z.string().optional(),
  selectProjectId: z.array(z.string()).min(1, { message: "Project selection is required" }),
  selectDepartmentId: z.array(z.string()).min(1, { message: "Department selection is required" }),
  taskAssign: z.array(z.string()).min(1, { message: "Task assignee is required" }),
  taskDescription: z.string().optional(),
  taskTag: z.string().optional(),
  attachFile: z.string().optional(),
});

const ticketInformationSchema = z.object({
  name: z.string({
    required_error: "Name is required",
  }),
  contact: z
    .string()
    .min(10, "Mobile number should be at least 10 digits")
    .optional(),

  email: z.string().email("Invalid email format").optional(),
});

// Admin Register 



const adminSchema = z.object({
  first_name: z
    .string()
    .min(1, "First Name is required"),

  last_name: z
    .string()
    .min(1, "Last Name is required"),

  mobile: z
    .string()
    .length(10, "Mobile number must be exactly 10 digits")
    .regex(/^\d+$/, "Mobile number must contain only digits")
    .optional(),

  email: z
    .string()
    .email("Invalid email format")
    .optional(),
});

const projectStatusSchema = z.object({
  project_name: z.string().min(1, "Project Name is required"),
  project_color: z.string().min(1, "Project Color is required"),
  project_order: z.string().min(1, "Project Order is required"),
  default_filter: z.boolean().optional(), // Optional field
  can_changed: z.array(z.string()).default([]).optional(),
});

const projectSchema = z.object({
  id: z.string().uuid().optional(),
  project_name: z.string().min(1, " project name is required"),
  customerId: z.string().min(1, "client is required"),
  billing_type: z.string().min(1, "billing type is required"),
  status: z.string().min(1, "status isrequired"),
  total_rate: z.number().positive("Total rate must be a positive number").min(1, "total rate is required"),
  estimated_hours: z.number().positive("Estimated hours must be a positive number").min(1, "estimated hours is required"),
  start_date: z.string().min(1, "start date is required"),
  deadline: z.string().min(1, " deadline is required"),
  tags: z.array(z.string().min(1, " tag is required")),
  description: z.string().min(1, " description is required"),
  send_mail: z.boolean().default(false),
  staffId: z.array(z.string()).min(1, "Select at least one option for Staff"),
});

// project Priority Schema
const projectPrioritySchema = z.object({
  priority_name: z.string().min(1, "Priority Name is required"),
  priority_color: z.string().min(1, "Priority Color is required"),
  priority_order: z.string().min(1, "Priority Order is required"),
  default_filter: z.boolean().optional(),
  is_hidden: z.array(z.string()).min(1, "Select at least one option for Is Hidden"),
  can_changed: z.array(z.string()).default([]).optional(),
})

const salaryDetailsSchema = z.object({
  effective_date: z.coerce.date().refine((date) => !isNaN(date.getTime()), {
    message: "Effective date is required",
  }),
  salary_type: z
    .string()
    .optional()
    .refine((type) => type === null || type.trim() !== "", {
      message: "Salary type is a required field",
    }),
  ctc_amount: z.number().optional(),
  employer_pf: z.number().optional(),
  employer_esi: z.number().optional(),
  employer_lwf: z.number().optional(),
  employee_pf: z.number().optional(),
  employee_esi: z.number().optional(),
  professional_tax: z.number().optional(),
  employee_lwf: z.number().optional(),
  tds: z.number().optional(),
  staffId: z.string().uuid(),
});

// Deductions Schema
const deductionsEarningsSchema = z.object({
  staffId: z.string().uuid("Invalid Staff ID format").optional(),
  heads: z.string().min(1, "Head Name is required").optional(),
  amount: z.number().optional(),
  calculation: z.string().min(1, "Calculation is required").optional(),
});

const workEntrySchema = z.object({
  work_name: z.string().min(1, "Work Name is required"),
  units: z.string().min(1, "Units is required"),
  description: z.string().min(1, "Description is required"),
  location: z.string().optional(),
  attachments: z.string().optional(),
  staffDetailsId: z.string().uuid("Staff ID is required"),
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
  TaskStatusSchema,
  TaskPrioritySchema,
  TaskDetailSchema,
  ticketInformationSchema,
  adminSchema,
  EndBreakSchema,
  StartBreakSchema,
  projectStatusSchema,
  projectPrioritySchema,
  salaryDetailsSchema,
  deductionsEarningsSchema,
  projectSchema,
  pastEmploymentSchema,
  workEntrySchema
};

