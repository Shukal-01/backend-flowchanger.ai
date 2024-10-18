const zod = require("zod");

const roleNameSchema = zod
    .string()
    .regex(/^[a-zA-Z\s]+$/, "Role name can only contain alphabets and spaces");
const idSchema = zod
    .string()
    .uuid("Role name can only contain alphabets and spaces");

const allPermissionSchema = zod.object({
    clients_permission: zod
        .object({
            create: zod.boolean().default(false).optional(),
            edit: zod.boolean().default(false).optional(),
            delete: zod.boolean().default(false).optional(),
            view_global: zod.boolean().default(false).optional(),
        })
        .optional(),
    projects_permissions: zod
        .object({
            create: zod.boolean().default(false).optional(),
            edit: zod.boolean().default(false).optional(),
            delete: zod.boolean().default(false).optional(),
            view_global: zod.boolean().default(false).optional(),
        })
        .optional(),
    report_permissions: zod
        .object({
            view_global: zod.boolean().default(false).optional(),
            view_time_sheets: zod.boolean().default(false).optional(),
        })
        .optional(),
    staff_role_permission: zod
        .object({
            create: zod.boolean().default(false).optional(),
            edit: zod.boolean().default(false).optional(),
            delete: zod.boolean().default(false).optional(),
            view_global: zod.boolean().default(false).optional(),
        })
        .optional(),
    settings_permissions: zod
        .object({
            view_global: zod.boolean().default(false).optional(),
            view_time_sheets: zod.boolean().default(false).optional(),
        })
        .optional(),
    staff_permissions: zod
        .object({
            create: zod.boolean().default(false).optional(),
            edit: zod.boolean().default(false).optional(),
            delete: zod.boolean().default(false).optional(),
            view_global: zod.boolean().default(false).optional(),
        })
        .optional(),
    task_permissions: zod
        .object({
            create: zod.boolean().default(false).optional(),
            edit: zod.boolean().default(false).optional(),
            delete: zod.boolean().default(false).optional(),
            view_global: zod.boolean().default(false).optional(),
        })
        .optional(),
    sub_task_permissions: zod
        .object({
            create: zod.boolean().default(false).optional(),
            edit: zod.boolean().default(false).optional(),
            delete: zod.boolean().default(false).optional(),
            view_global: zod.boolean().default(false).optional(),
        })
        .optional(),
    chat_module_permissions: zod
        .object({
            grant_access: zod.boolean().default(false).optional(),
        })
        .optional(),
    ai_permissions: zod
        .object({
            grant_access: zod.boolean().default(false).optional(),
        })
        .optional(),
});

const newRoleSchema = zod.object({
    role_name: roleNameSchema.min(2, "role name is required"),
    permissions: allPermissionSchema.optional(),
});

const updateRoleSchema = zod.object({
    role_name: roleNameSchema.optional(),
    permissions: allPermissionSchema.optional(),
});

const staffIds = zod
    .array(zod.string().uuid())
    .min(1, "staff ids are required");

const attendenceAutomationRuleSchema = zod.object({
    staff_ids: staffIds,
    automation_rules: zod
        .object({
            auto_absent: zod.boolean().optional(),
            present_on_punch: zod.boolean().optional(),
            auto_half_day: zod.string().optional(),
            mandatory_half_day: zod.string().optional(),
            mandatory_full_day: zod.string().optional(),
        })
        .optional(),
});

const attendanceModeSchema = zod.object({
    staff_ids: staffIds,
    attendence_mode: zod.object({
        selfie_attendance: zod.boolean().default(false),
        qr_attendance: zod.boolean().default(false),
        gps_attendance: zod.boolean().default(false),
        mark_attendance: zod.enum(["Office", "Anywhere"]).default("Office"),
        allow_punch_in_for_mobile: zod.boolean().default(false),
    }),
});

const multipleStaffBankDetailSchema = zod.array(zod.object({
    staff_id: zod.string().uuid("Invalid staff ID"),
    bank_name: zod.string().min(1, "Bank name is required"),
    account_number: zod.string()
        .length(12, "Account number must be exactly 12 digits") // Assuming a fixed length based on provided data
        .regex(/^\d{12}$/, "Account number should only contain digits"),
    account_holder_name: zod.string().min(3, "Account holder name must be at least 3 characters"),
    branch_name: zod.string().min(3, "Branch name should have at least 3 characters").max(60, "Branch name should have at most 60 characters"),
    ifsc_code: zod.string()
        .regex(/^[A-Z]{4}0[A-Z0-9]{6}$/, "Invalid IFSC code")
        .length(11, "IFSC code must be exactly 11 characters"),
}));

const aadhaarNumberPattern = /^\d{4}-\d{4}-\d{4}$/; // Format: 1234-5678-9012
const panNumberPattern = /^[A-Z]{5}\d{4}[A-Z]$/; // Format: ABCDE1234F
const uanNumberPattern = /^\d{12}$/; // 12 digits
const drivingLicensePattern = /^[A-Z]{2}[0-9]{2}[0-9]{1,11}$/;

const staffBackgroundVerificationSchema = zod.object({
    aadhaar_number: zod.string().regex(aadhaarNumberPattern, "invalid Aadhaar number format").optional(),
    aadhaar_verification_status: zod.string().default("Not Verified").optional(),
    aadhaar_file: zod.string().optional(),
    pan_number: zod.string().regex(panNumberPattern, "invalid pan number format").optional(),
    pan_verification_status: zod.string().default("Not Verified").optional(),
    pan_file: zod.string().optional(),
    uan_number: zod.string().regex(uanNumberPattern, "Invalid uan number format").optional(),
    uan_verification_status: zod.string().default("Not Verified").optional(),
    uan_file: zod.string().optional(),
    driving_license_number: zod.string().regex(drivingLicensePattern, "Invalid driving license number format").optional(),
    driving_license_status: zod.string().default("Not Verified").optional(),
    driving_license_file: zod.string().optional(),
    face_file: zod.string().optional(),
    face_verification_status: zod.string().default("Not Verified").optional(),
    current_address: zod.string().optional(),
    permanent_address: zod.string().optional(),
    address_status: zod.string().default("Not Verified").optional(),
    address_file: zod.string().optional(),
    staffId: zod.string().optional(),
});

const clientSchema = zod.object({
    company: zod.string().min(1, "Company name is required"),
    vat_number: zod
        .string()
        .regex(/^[A-Z0-9]{8,12}$/, "VAT number must be 8-12 characters long, containing only uppercase letters and digits"),
    phone: zod
        .string()
        .regex(/^\+?\d{7,15}$/, "Phone number must be 7 to 15 digits, with an optional '+' prefix"),
    website: zod
        .string(),
    groups: zod.array(zod.string()).min(1, "At least one group is required"),
    currency: zod.array(zod.string()).min(1, "At least one group is required"),
    default_language: zod.array(zod.string()).min(1, "At least one group is required"),
    address: zod.string().min(1, "Address is required"),
    country: zod.string().min(2, "Country name is required"),
    state: zod.string().min(2, "State name is required"),
    city: zod.string().min(1, "City name is required"),
    status: zod.enum(["active", "inactive"]).default("inactive"),
    zip_code: zod
        .string()
        .regex(/^\d{4,10}$/, "ZIP code must be 4 to 10 digits"),
});


module.exports = {
    clientSchema,
    idSchema,
    roleNameSchema,
    newRoleSchema,
    updateRoleSchema,
    attendenceAutomationRuleSchema,
    attendanceModeSchema,
    multipleStaffBankDetailSchema,
    staffBackgroundVerificationSchema,
};
