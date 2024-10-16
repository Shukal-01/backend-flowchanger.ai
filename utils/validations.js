const zod = require("zod");

const roleNameSchema = zod
    .string()
    .regex(/^[a-zA-Z\s]+$/, "Role name can only contain alphabets and spaces");

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
    roleName: roleNameSchema.optional(),
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

module.exports = {
    roleNameSchema,
    newRoleSchema,
    updateRoleSchema,
    attendenceAutomationRuleSchema,
    attendanceModeSchema,
};
