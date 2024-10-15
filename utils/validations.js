const zod = require("zod");

const roleNameSchema = zod.string().regex(/^[a-zA-Z\s]+$/, "Role name can only contain alphabets and spaces");

const allPermissionSchema = zod.object({
    clientsPermission: zod.object({
        create: zod.boolean().default(false).optional(),
        edit: zod.boolean().default(false).optional(),
        delete: zod.boolean().default(false).optional(),
        viewGlobal: zod.boolean().default(false).optional(),
    }).optional(),
    projectsPermissions: zod.object({
        create: zod.boolean().default(false).optional(),
        edit: zod.boolean().default(false).optional(),
        delete: zod.boolean().default(false).optional(),
        viewGlobal: zod.boolean().default(false).optional(),
    }).optional(),
    reportPermissions: zod.object({
        viewGlobal: zod.boolean().default(false).optional(),
        viewTimesheets: zod.boolean().default(false).optional(),
    }).optional(),
    staffRolePermission: zod.object({
        create: zod.boolean().default(false).optional(),
        edit: zod.boolean().default(false).optional(),
        delete: zod.boolean().default(false).optional(),
        viewGlobal: zod.boolean().default(false).optional(),
    }).optional(),
    settingsPermissions: zod.object({
        viewGlobal: zod.boolean().default(false).optional(),
        viewTimesheets: zod.boolean().default(false).optional(),
    }).optional(),
    staffPermissions: zod.object({
        create: zod.boolean().default(false).optional(),
        edit: zod.boolean().default(false).optional(),
        delete: zod.boolean().default(false).optional(),
        viewGlobal: zod.boolean().default(false).optional(),
    }).optional(),
    taskPermissions: zod.object({
        create: zod.boolean().default(false).optional(),
        edit: zod.boolean().default(false).optional(),
        delete: zod.boolean().default(false).optional(),
        viewGlobal: zod.boolean().default(false).optional(),
    }).optional(),
    subTaskPermissions: zod.object({
        create: zod.boolean().default(false).optional(),
        edit: zod.boolean().default(false).optional(),
        delete: zod.boolean().default(false).optional(),
        viewGlobal: zod.boolean().default(false).optional(),
    }).optional(),
    chatModulePermissions: zod.object({
        grantAccess: zod.boolean().default(false).optional(),
    }).optional(),
    aiPermissions: zod.object({
        grantAccess: zod.boolean().default(false).optional(),
    }).optional(),
})

const newRoleSchema = zod.object({
    roleName: roleNameSchema.min(2, "role name is required"),
    permissions: allPermissionSchema.optional()
})
const updateRoleSchema = zod.object({
    roleName: roleNameSchema.optional(),
    permissions: allPermissionSchema.optional()
})

module.exports = {
    roleNameSchema,
    newRoleSchema,
    updateRoleSchema
}