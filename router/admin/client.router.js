const { Router } = require("express");
const {
  addNewClient,
  fetchAllClients,
  updateSpecificClient,
  fetchClientInfoSpecificID,
  deleteSpecificClient,
  changeStatus,
  createClient,
  searchClientByCompanyOrVatNumber,
  loginClient,
} = require("../../controller/admin/client/detail.controller");

const clientRouter = Router();

// search for a specific client By Name
clientRouter.get("/search", searchClientByCompanyOrVatNumber)
// create a new client
clientRouter.post("/", createClient);

// Get all Roles
clientRouter.get("/", fetchAllClients);

// upate a client with specific id
clientRouter.put("/:id", updateSpecificClient);

clientRouter.patch("/:id", changeStatus);

// Fetch a client with specific id
clientRouter.get("/:id", fetchClientInfoSpecificID);

// delete a client with specific id
clientRouter.delete("/:id", deleteSpecificClient);

clientRouter.post("/login", loginClient);

module.exports = clientRouter;
