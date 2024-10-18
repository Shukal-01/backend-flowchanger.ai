const { Router } = require("express");
const { addNewClient, fetchAllClients, updateSpecificClient, fetchClientInfoSpecificID, deleteSpecificClient } = require("../../controller/admin/client/detail.controller");

const clientRouter = Router();

// Create a new Role
clientRouter.post("/", addNewClient);

// Get all Roles
clientRouter.get("/", fetchAllClients);

// Update a Role
clientRouter.put("/:id", updateSpecificClient);

// Fetch a Role with role ID
clientRouter.get("/:id", fetchClientInfoSpecificID);
clientRouter.delete("/:id", deleteSpecificClient);

module.exports = clientRouter;
