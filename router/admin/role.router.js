const { addRole, fetchRole, updateRole, fetchRoleWithId, deleteRole } = require("../../controller/admin/role.controller.js");
const { Router } = require("express");

const roleRouter = Router();

// Create a new Role
roleRouter.post("/", addRole);

// Get all Roles
roleRouter.get("/", fetchRole);

// Update a Role
roleRouter.put("/:id", updateRole);

// Fetch a Role with role ID
roleRouter.get("/:id", fetchRoleWithId);
roleRouter.delete("/:id", deleteRole);

module.exports = roleRouter;
