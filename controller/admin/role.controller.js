const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const {
  newRoleSchema,
  updateRoleSchema,
  roleNameSchema,
} = require("../../utils/validations.js");

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
        },
      },
    });
    res.status(200).json({
      success: true,
      message: "Fetch all roles successfully",
      data: allRoles,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: "Failed to fetch all roles",
    });
  }
};

// fetch role with specific id
const fetchRoleWithName = async (req, res) => {
  const { roleName } = req.params;

  try {
    const validateroleName = roleNameSchema
      .min(2, "role name in params is required")
      .safeParse(roleName);
    // find Role of id if existing or not
    if (!validateroleName.success) {
      return res.status(400).json({
        success: false,
        message: "Invalid role name format or length provided in params",
      });
    }

    const findRole = await prisma.role.findFirst({
      where: { role_name: roleName },
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

    // if role not found
    if (!findRole) {
      return res.status(404).json({
        success: false,
        message: "Role not found.",
        data: findRole,
      });
    }
    res.status(200).json({
      success: true,
      message: "Fetch role detail of " + roleName + " successfully",
      data: findRole,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: "Failed to fetch all roles" + error.message,
    });
  }
};

// add new Role
async function addRole(req, res) {
  const { roleName, permissions } = req.body;
  try {
    const validateNewRoleData = newRoleSchema.safeParse({
      roleName,
      permissions,
    });
    if (!validateNewRoleData.success) {
      return res.status(400).json({
        success: false,
        message: "Invalid new role data provided",
      });
    }
    // find Role with name if exist or not
    const findRoleWithName = await prisma.role.findFirst({
      where: {
        role_name: roleName,
      },
    });

    // if find role with name then return false
    if (findRoleWithName) {
      return res.json({
        status: false,
        message: "Role is already created with " + roleName + " name",
      });
    }

    // if role is not exist then create new role
    const newRole = await prisma.role.create({
      data: {
        role_name: roleName, // Provide role name
        permissions: {
          create: {
            clients_permissions: {
              create: {
                view_global: permissions.client_permissions.view_global,
                create: permissions.client_permissions.create,
                edit: permissions.client_permissions.edit,
                delete: permissions.client_permissions.delete,
              },
            },

            projects_permissions: {
              create: {
                view_global: permissions.projects_permissions.view_global,
                create: permissions.projects_permissions.create,
                edit: permissions.projects_permissions.edit,
                delete: permissions.projects_permissions.delete,
              },
            },

            report_permissions: {
              create: {
                view_global: permissions.reportPermissions.view_global,
                view_time_sheets:
                  permissions.reportPermissions.view_time_sheets,
              },
            },

            staff_role_permissions: {
              create: {
                view_global: permissions.staff_role_permissions.view_global,
                create: permissions.staff_role_permissions.create,
                edit: permissions.staff_role_permissions.edit,
                delete: permissions.staff_role_permissions.delete,
              },
            },

            settings_permissions: {
              create: {
                view_global: permissions.settings_permissions.view_global,
                view_time_sheets:
                  permissions.settings_permissions.view_time_sheets,
              },
            },

            staff_permissions: {
              create: {
                view_global: permissions.staff_permissions.view_global,
                create: permissions.staff_permissions.create,
                edit: permissions.staff_permissions.edit,
                delete: permissions.staff_permissions.delete,
              },
            },

            task_permissions: {
              create: {
                view_global: permissions.task_permissions.view_global,
                create: permissions.task_permissions.create,
                edit: permissions.task_permissions.edit,
                delete: permissions.task_permissions.delete,
              },
            },

            sub_task_permissions: {
              create: {
                view_global: permissions.sub_task_permissions.view_global,
                create: permissions.sub_task_permissions.create,
                edit: permissions.sub_task_permissions.edit,
                delete: permissions.sub_task_permissions.delete,
              },
            },

            chat_module_permissions: {
              create: {
                grant_access: permissions.chat_module_permissions.grantAccess,
              },
            },

            ai_permissions: {
              create: {
                grant_access: permissions.ai_permissions.grantAccess,
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
    console.log(error);
    res.status(500).json({
      success: false,
      error: "Failed to add role" + error.message,
    });
  }
}

// updated Role for specific id
const updateRole = async (req, res) => {
  const { roleName: roleNameParmas } = req.params;
  const { roleName, permissions } = req.body;

  try {
    const validateRoleNameParams = roleNameSchema
      .min(2, "role name in params is required")
      .safeParse(roleNameParmas);
    const validateUpdatedRoleData = updateRoleSchema.safeParse({
      roleName,
      permissions,
    });
    if (!validateRoleNameParams.success || !validateUpdatedRoleData.success) {
      return res.status(400).json({
        success: false,
        error: "Invalid updated role permission and role name format provided",
      });
    }

    // find a role with specific role id
    const findRole = await prisma.role.findFirst({
      where: { role_name: roleNameParmas },
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

    // If role not found, return 404
    if (!findRole) {
      return res.status(404).json({
        success: false,
        message: "Role not found.",
      });
    }

    // update the role with provide values or already present value
    const updatedRole = await prisma.role.update({
      where: { id: findRole.id },
      data: {
        role_name: roleName,
        permissions: {
          // update a all permission like client,projects,task, etc. with the used of permission id with specific value
          update: {
            clients_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  view_global:
                    permissions?.client_permissions?.view_global ??
                    findRole.permissions.clients_permissions.view_global,
                  create:
                    permissions?.client_permissions?.create ??
                    findRole.permissions.clients_permissions.create,
                  edit:
                    permissions?.client_permissions?.edit ??
                    findRole.permissions.clients_permissions.edit,
                  delete:
                    permissions?.client_permissions?.delete ??
                    findRole.permissions.clients_permissions.delete,
                },
              },
            },
            projects_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  view_global:
                    permissions?.projectsPermissions?.view_global ??
                    findRole.permissions.projects_permissions.view_global,
                  create:
                    permissions?.projectsPermissions?.create ??
                    findRole.permissions.projects_permissions.create,
                  edit:
                    permissions?.projectsPermissions?.edit ??
                    findRole.permissions.projects_permissions.edit,
                  delete:
                    permissions?.projectsPermissions?.delete ??
                    findRole.permissions.projects_permissions.delete,
                },
              },
            },
            report_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  view_global:
                    permissions?.reportPermissions?.view_global ??
                    findRole.permissions.report_permissions.view_global,
                  view_time_sheets:
                    permissions?.reportPermissions?.view_time_sheets ??
                    findRole.permissions.report_permissions.view_time_sheets,
                },
              },
            },
            staff_role_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  view_global:
                    permissions?.staffRolePermissions?.view_global ??
                    findRole.permissions.staff_role_permissions.view_global,
                  create:
                    permissions?.staffRolePermissions?.create ??
                    findRole.permissions.staff_role_permissions.create,
                  edit:
                    permissions?.staffRolePermissions?.edit ??
                    findRole.permissions.staff_role_permissions.edit,
                  delete:
                    permissions?.staffRolePermissions?.delete ??
                    findRole.permissions.staff_role_permissions.delete,
                },
              },
            },
            settings_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  view_global:
                    permissions?.settingsPermissions?.view_global ??
                    findRole.permissions.settings_permissions.view_global,
                  view_time_sheets:
                    permissions?.settingsPermissions?.view_time_sheets ??
                    findRole.permissions.settings_permissions.view_time_sheets,
                },
              },
            },
            staff_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  view_global:
                    permissions?.staffPermissions?.view_global ??
                    findRole.permissions.staff_permissions.view_global,
                  create:
                    permissions?.staffPermissions?.create ??
                    findRole.permissions.staff_permissions.create,
                  edit:
                    permissions?.staffPermissions?.edit ??
                    findRole.permissions.staff_permissions.edit,
                  delete:
                    permissions?.staffPermissions?.delete ??
                    findRole.permissions.staff_permissions.delete,
                },
              },
            },
            task_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  view_global:
                    permissions?.taskPermissions?.view_global ??
                    findRole.permissions.task_permissions.view_global,
                  create:
                    permissions?.taskPermissions?.create ??
                    findRole.permissions.task_permissions.create,
                  edit:
                    permissions?.taskPermissions?.edit ??
                    findRole.permissions.task_permissions.edit,
                  delete:
                    permissions?.taskPermissions?.delete ??
                    findRole.permissions.task_permissions.delete,
                },
              },
            },
            sub_task_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  view_global:
                    permissions?.subTaskPermissions?.view_global ??
                    findRole.permissions.sub_task_permissions.view_global,
                  create:
                    permissions?.subTaskPermissions?.create ??
                    findRole.permissions.sub_task_permissions.create,
                  edit:
                    permissions?.subTaskPermissions?.edit ??
                    findRole.permissions.sub_task_permissions.edit,
                  delete:
                    permissions?.subTaskPermissions?.delete ??
                    findRole.permissions.sub_task_permissions.delete,
                },
              },
            },
            chat_module_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  grant_access:
                    permissions?.chatModulePermissions?.grant_access ??
                    findRole.permissions.chat_module_permissions.grant_access,
                },
              },
            },
            ai_permissions: {
              update: {
                where: { permissionsId: findRole.permissions.id },
                data: {
                  grant_access:
                    permissions?.aiPermissions?.grantAccess ??
                    findRole.permissions.ai_permissions.grant_access,
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
    // Handle any errors
    if (error.code === "P2002") {
      // Unique constraint violation
      res.status(409).json({
        success: false,
        error: roleName + " role already exists.",
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
  const { roleName: roleNameParams } = req.params;
  const validateRoleNameParams = roleNameSchema
    .min(2, "role name in params is required")
    .safeParse(roleNameParams);
  if (!validateRoleNameParams.success) {
    return res.status(400).json({
      success: false,
      error: "Invalid role name format or length provided in params",
    });
  }
  try {
    const findRole = await prisma.role.findFirst({
      where: { role_name: roleNameParams },
    });

    if (!findRole) {
      return res.status(404).json({
        success: false,
        message: "Role not found.",
      });
    }
    await prisma.role.delete({ where: { id: findRole.id } });
    res.status(200).json({
      success: true,
      message: "Delete role successfully",
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: "Failed to delete role",
    });
  }
};

module.exports = {
  fetchRole,
  fetchRoleWithName,
  addRole,
  updateRole,
  deleteRole,
};
