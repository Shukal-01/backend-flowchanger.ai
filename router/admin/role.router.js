const {
  addRole,
  deleteRole,
  fetchRole,
  fetchRoleWithId,   // Added this line
  updateRole,
  searchRoleByName,
} = require("../../controller/admin/role.controller.js");

const { Router } = require("express");

const roleRouter = Router();

// Create a new Role
roleRouter.post("/", addRole);

// search role by name 
roleRouter.get('/search', searchRoleByName)

// Get all Roles
roleRouter.get("/", fetchRole);

// Update a Role
roleRouter.put("/:id", updateRole);

// Fetch a Role with role ID
roleRouter.get("/:id", fetchRoleWithId);

// Delete a Role
roleRouter.delete("/:id", deleteRole);

module.exports = roleRouter;

