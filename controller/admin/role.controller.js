const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { newRoleSchema, updateRoleSchema, roleNameSchema, roleIdSchema } = require("../../utils/validations.js");

// fetch all roles 
const fetchRole = async (req, res) => {
    try {
        const allRoles = await prisma.role.findMany({
            include: {
                permissions: {
                    // show all permission data
                    include: {
                        clients_permissions: true,
                        projects_permissions: true,
                        report_permissions: true,
                        staff_role_permissions: true,
                        settings_permissions: true,
                        staff_permissions: true,
                        task_permissions: true,
                        sub_task_permissions: true,
                        chat_module_permissions: true,
                        ai_permissions: true,
                    },
                }
            }
        });
        res.status(200).json({
            success: true,
            message: "Fetch all roles successfully",
            data: allRoles
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            error: "Failed to fetch all roles"
        });
    }
}

// fetch role with specific id
const fetchRoleWithId = async (req, res) => {
    const { id } = req.params;

    try {

        const validateRoleId = roleIdSchema.min(2, "role id is required").safeParse(id);
        // find Role of id if existing or not
        if (!validateRoleId.success) {
            return res.status(400).json({
                success: false,
                message: "Invalid role id format or length provided",
            });
        }

        const findRole = await prisma.role.findFirst({
            where: { id: id },
            include: {
                permissions: {
                    include: {
                        clients_permissions: true,
                        projects_permissions: true,
                        report_permissions: true,
                        staff_role_permissions: true,
                        settings_permissions: true,
                        staff_permissions: true,
                        task_permissions: true,
                        sub_task_permissions: true,
                        chat_module_permissions: true,
                        ai_permissions: true,
                    },
                }
            }
        });

        // if role not found
        if (!findRole) {
            return res.status(404).json({
                success: false,
                message: "Role not found.",
                data: findRole
            });
        }
        res.status(200).json({
            success: true,
            message: "Fetch role detail of id:" + id + " successfully",
            data: findRole
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            error: "Failed to fetch all roles" + error.message
        });
    }
}

// add new Role 
async function addRole(req, res) {
    const { role_name, permissions } = req.body;
    try {
        const validateNewRoleData = newRoleSchema.safeParse({ role_name, permissions });
        if (!validateNewRoleData.success) {
            return res.status(400).json({
                success: false,
                message: "Invalid new role data provided",
            })
        }
        // find Role with name if exist or not 
        const findRoleWithName = await prisma.Role.findFirst({
            where: {
                role_name: role_name,
            }
        })

        // if find role with name then return false
        if (findRoleWithName) {
            return res.json({
                status: false,
                message: "Role is already created with " + role_name + " name"
            })
        }

        // if role is not exist then create new role
        const newRole = await prisma.Role.create({
            data: {
                role_name: role_name, // Provide role name
                permissions: {
                    create: {
                        // Provide client-related permissions
                        clients_permissions: {
                            create: {
                                view_global: permissions?.clients_permissions?.view_global || false,
                                create: permissions?.clients_permissions?.create || false,
                                edit: permissions?.clients_permissions?.edit || false,
                                delete: permissions?.clients_permissions?.delete || false,
                            },
                        },

                        // Provide project-related permissions
                        projects_permissions: {
                            create: {
                                view_global: permissions?.projects_permissions?.view_global || false,
                                create: permissions?.projects_permissions?.create || false,
                                edit: permissions?.projects_permissions?.edit || false,
                                delete: permissions?.projects_permissions?.delete || false,
                            },
                        },

                        // Provide report-related permissions
                        report_permissions: {
                            create: {
                                view_global: permissions?.report_permissions?.view_global || false,
                                view_time_sheets: permissions?.report_permissions?.view_time_sheets || false,
                            },
                        },

                        // Provide staff role-related permissions
                        staff_role_permissions: {
                            create: {
                                view_global: permissions?.staff_role_permissions?.view_global || false,
                                create: permissions?.staff_role_permissions?.create || false,
                                edit: permissions?.staff_role_permissions?.edit || false,
                                delete: permissions?.staff_role_permissions?.delete || false,
                            },
                        },

                        // Provide settings-related permissions
                        settings_permissions: {
                            create: {
                                view_global: permissions?.settings_permissions?.view_global || false,
                                view_time_sheets: permissions?.settings_permissions?.view_time_sheets || false,
                            },
                        },

                        // Provide staff-related permissions
                        staff_permissions: {
                            create: {
                                view_global: permissions?.staff_permissions?.view_global || false,
                                create: permissions?.staff_permissions?.create || false,
                                edit: permissions?.staff_permissions?.edit || false,
                                delete: permissions?.staff_permissions?.delete || false,
                            },
                        },

                        // Provide task-related permissions
                        task_permissions: {
                            create: {
                                view_global: permissions?.task_permissions?.view_global || false,
                                create: permissions?.task_permissions?.create || false,
                                edit: permissions?.task_permissions?.edit || false,
                                delete: permissions?.task_permissions?.delete || false,
                            },
                        },

                        // Provide sub-task-related permissions
                        sub_task_permissions: {
                            create: {
                                view_global: permissions?.sub_task_permissions?.view_global || false,
                                create: permissions?.sub_task_permissions?.create || false,
                                edit: permissions?.sub_task_permissions?.edit || false,
                                delete: permissions?.sub_task_permissions?.delete || false,
                            },
                        },

                        // Provide chat module-related permissions
                        chat_module_permissions: {
                            create: {
                                grant_access: permissions?.chat_module_permissions?.grant_access || false,
                            },
                        },

                        // Provide AI-related permissions
                        ai_permissions: {
                            create: {
                                grant_access: permissions?.ai_permissions?.grant_access || false,
                            },
                        },
                    },
                },
            },
            include: {
                permissions: {
                    include: {
                        clients_permissions: true,
                        projects_permissions: true,
                        report_permissions: true,
                        staff_role_permissions: true,
                        settings_permissions: true,
                        staff_permissions: true,
                        task_permissions: true,
                        sub_task_permissions: true,
                        chat_module_permissions: true,
                        ai_permissions: true,
                    },
                },
            },
        });
        res.status(200).json({
            success: true,
            message: "New role add successfully",
            data: newRole,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            error: "Failed to add role" + error.message
        });
    }
}

// updated Role for specific id
const updateRole = async (req, res) => {
    const { id } = req.params;
    const { roleName: role_name, permissions } = req.body;


    try {
        const validateUpdatedRoleData = updateRoleSchema.safeParse({
            role_name,
            permissions
        });
        const validateRoleId = roleIdSchema.min(2, "role id is required").safeParse(id);
        if (!validateRoleId.success || !validateUpdatedRoleData.success) {
            return res.status(400).json({
                success: false,
                error: "Invalid updated role permission and id format provided",
            });
        }

        // find a role with specific role id 
        const findRole = await prisma.Role.findFirst({
            where: { id: id },
            include: {
                permissions: {
                    include: {
                        clients_permissions: true,
                        projects_permissions: true,
                        report_permissions: true,
                        staff_role_permissions: true,
                        settings_permissions: true,
                        staff_permissions: true,
                        task_permissions: true,
                        sub_task_permissions: true,
                        chat_module_permissions: true,
                        ai_permissions: true,
                    },
                }
            }
        });

        // If role not found, return 404
        if (!findRole) {
            return res.status(404).json({
                success: false,
                message: "Role not found.",
            });
        }

        // update the role with provide values or already present value
        const updatedRole = await prisma.role.update({
            where: { id },
            data: {
                role_name: role_name,
                permissions: {
                    // Update all permissions (clients, projects, tasks, etc.) using the permission ID with specific values
                    update: {
                        clients_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    view_global: permissions?.clients_permissions?.view_global ?? findRole.permissions.clients_permissions.view_global,
                                    create: permissions?.clients_permissions?.create ?? findRole.permissions.clients_permissions.create,
                                    edit: permissions?.clients_permissions?.edit ?? findRole.permissions.clients_permissions.edit,
                                    delete: permissions?.clients_permissions?.delete ?? findRole.permissions.clients_permissions.delete,
                                },
                            },
                        },
                        projects_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    view_global: permissions?.projects_permissions?.view_global ?? findRole.permissions.projects_permissions.view_global,
                                    create: permissions?.projects_permissions?.create ?? findRole.permissions.projects_permissions.create,
                                    edit: permissions?.projects_permissions?.edit ?? findRole.permissions.projects_permissions.edit,
                                    delete: permissions?.projects_permissions?.delete ?? findRole.permissions.projects_permissions.delete,
                                },
                            },
                        },
                        report_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    view_global: permissions?.report_permissions?.view_global ?? findRole.permissions.report_permissions.view_global,
                                    view_time_sheets: permissions?.report_permissions?.view_time_sheets ?? findRole.permissions.report_permissions.view_time_sheets,
                                },
                            },
                        },
                        staff_role_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    view_global: permissions?.staff_role_permissions?.view_global ?? findRole.permissions.staff_role_permissions.view_global,
                                    create: permissions?.staff_role_permissions?.create ?? findRole.permissions.staff_role_permissions.create,
                                    edit: permissions?.staff_role_permissions?.edit ?? findRole.permissions.staff_role_permissions.edit,
                                    delete: permissions?.staff_role_permissions?.delete ?? findRole.permissions.staff_role_permissions.delete,
                                },
                            },
                        },
                        settings_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    view_global: permissions?.settings_permissions?.view_global ?? findRole.permissions.settings_permissions.view_global,
                                    view_time_sheets: permissions?.settings_permissions?.view_time_sheets ?? findRole.permissions.settings_permissions.view_time_sheets,
                                },
                            },
                        },
                        staff_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    view_global: permissions?.staff_permissions?.view_global ?? findRole.permissions.staff_permissions.view_global,
                                    create: permissions?.staff_permissions?.create ?? findRole.permissions.staff_permissions.create,
                                    edit: permissions?.staff_permissions?.edit ?? findRole.permissions.staff_permissions.edit,
                                    delete: permissions?.staff_permissions?.delete ?? findRole.permissions.staff_permissions.delete,
                                },
                            },
                        },
                        task_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    view_global: permissions?.task_permissions?.view_global ?? findRole.permissions.task_permissions.view_global,
                                    create: permissions?.task_permissions?.create ?? findRole.permissions.task_permissions.create,
                                    edit: permissions?.task_permissions?.edit ?? findRole.permissions.task_permissions.edit,
                                    delete: permissions?.task_permissions?.delete ?? findRole.permissions.task_permissions.delete,
                                },
                            },
                        },
                        sub_task_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    view_global: permissions?.sub_task_permissions?.view_global ?? findRole.permissions.sub_task_permissions.view_global,
                                    create: permissions?.sub_task_permissions?.create ?? findRole.permissions.sub_task_permissions.create,
                                    edit: permissions?.sub_task_permissions?.edit ?? findRole.permissions.sub_task_permissions.edit,
                                    delete: permissions?.sub_task_permissions?.delete ?? findRole.permissions.sub_task_permissions.delete,
                                },
                            },
                        },
                        chat_module_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    grant_access: permissions?.chat_module_permissions?.grant_access ?? findRole.permissions.chat_module_permissions.grant_access,
                                },
                            },
                        },
                        ai_permissions: {
                            update: {
                                where: { permissionsId: findRole.permissions.id },
                                data: {
                                    grant_access: permissions?.ai_permissions?.grant_access ?? findRole.permissions.ai_permissions.grant_access,
                                },
                            },
                        },
                    },
                },
            },

            // show all related data table
            include: {
                permissions: {
                    include: {
                        clients_permissions: true,
                        projects_permissions: true,
                        report_permissions: true,
                        staff_role_permissions: true,
                        settings_permissions: true,
                        staff_permissions: true,
                        task_permissions: true,
                        sub_task_permissions: true,
                        chat_module_permissions: true,
                        ai_permissions: true,
                    },
                },
            },
        });

        // Send a success response with updated role data
        res.status(200).json({
            success: true,
            message: "Role updated successfully",
            data: updatedRole,
        });
    } catch (error) {
        console.log(error);
        // Handle any errors
        if (error.code === 'P2002') { // Unique constraint violation
            res.status(409).json({
                success: false,
                error: "Role id:" + id + " already exists.",
            });
        } else {
            // Handle any other errors
            res.status(500).json({
                success: false,
                error: "Failed to update role: " + error.message,
            });
        }
    }
};

// delete specific roleId's role
const deleteRole = async (req, res) => {
    const { id } = req.params;
    const validateRoleId = roleIdSchema.safeParse(id);
    if (!validateRoleId.success) {
        return res.status(400).json({
            success: false,
            error: "Invalid role name format or length provided in params",
        });
    }
    try {
        const findRole = await prisma.role.findFirst({
            where: { id: id },
        });

        if (!findRole) {
            return res.status(404).json({
                success: false,
                message: "Role not found.",
            });
        }
        await prisma.role.delete({ where: { id: id } });
        res.status(200).json({
            success: true,
            message: "Delete role successfully"
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            error: "Failed to delete role"
        });
    }
}

module.exports = {
    fetchRole,
    fetchRoleWithId,
    addRole,
    updateRole,
    deleteRole
};