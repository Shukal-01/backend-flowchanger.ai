const { z } = require("zod");

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

const roleNameSchema = z
  .string()
  .regex(/^[a-zA-Z\s]+$/, "Role name can only contain alphabets and spaces");

const allPermissionSchema = z.object({
  clientsPermission: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      viewGlobal: z.boolean().default(false).optional(),
    })
    .optional(),
  projectsPermissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      viewGlobal: z.boolean().default(false).optional(),
    })
    .optional(),
  reportPermissions: z
    .object({
      viewGlobal: z.boolean().default(false).optional(),
      viewTimesheets: z.boolean().default(false).optional(),
    })
    .optional(),
  staffRolePermission: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      viewGlobal: z.boolean().default(false).optional(),
    })
    .optional(),
  settingsPermissions: z
    .object({
      viewGlobal: z.boolean().default(false).optional(),
      viewTimesheets: z.boolean().default(false).optional(),
    })
    .optional(),
  staffPermissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      viewGlobal: z.boolean().default(false).optional(),
    })
    .optional(),
  taskPermissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      viewGlobal: z.boolean().default(false).optional(),
    })
    .optional(),
  subTaskPermissions: z
    .object({
      create: z.boolean().default(false).optional(),
      edit: z.boolean().default(false).optional(),
      delete: z.boolean().default(false).optional(),
      viewGlobal: z.boolean().default(false).optional(),
    })
    .optional(),
  chatModulePermissions: z
    .object({
      grantAccess: z.boolean().default(false).optional(),
    })
    .optional(),
  aiPermissions: z
    .object({
      grantAccess: z.boolean().default(false).optional(),
    })
    .optional(),
});

const newRoleSchema = z.object({
  roleName: roleNameSchema.min(2, "role name is required"),
  permissions: allPermissionSchema.optional(),
});
const updateRoleSchema = z.object({
  roleName: roleNameSchema.optional(),
  permissions: allPermissionSchema.optional(),
});

module.exports = {
  roleNameSchema,
  newRoleSchema,
  updateRoleSchema,
  bankDetailsSchema,
  staffSchema,
  leavePolicySchema,
  createLeaveBalanceSchema,
  updateLeaveBalanceSchema,
  createLeaveRequestSchema,
  updateLeaveRequestSchema,
};
