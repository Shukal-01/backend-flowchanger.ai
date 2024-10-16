const { addRole, deleteRole, fetchRole, fetchRoleWithName, updateRole } = require("../../controller/admin/role.controller.js");
const { Router } = require("express");

const roleRouter = Router();

// Create a new Role
roleRouter.post("/", addRole);

// Get all Roles
roleRouter.get("/", fetchRole);

// Update a Role
roleRouter.put("/:roleName", updateRole);

// Fetch a Role with role ID
roleRouter.get("/:roleName", fetchRoleWithName);

// Delete a Role
roleRouter.delete("/:roleName", deleteRole);

module.exports = roleRouter;
