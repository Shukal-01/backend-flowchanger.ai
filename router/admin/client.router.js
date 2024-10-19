const { Router } = require("express");
const { addNewClient, fetchAllClients, updateSpecificClient, fetchClientInfoSpecificID, deleteSpecificClient } = require("../../controller/admin/client/detail.controller");

const clientRouter = Router();

// create a new client
clientRouter.post("/", addNewClient);

// Get all Roles
clientRouter.get("/", fetchAllClients);

// upate a client with specific id
clientRouter.put("/:id", updateSpecificClient);

// Fetch a client with specific id
clientRouter.get("/:id", fetchClientInfoSpecificID);

// delete a client with specific id
clientRouter.delete("/:id", deleteSpecificClient);

module.exports = clientRouter;
