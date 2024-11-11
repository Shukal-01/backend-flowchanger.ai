const express = require("express");
const {
  createStaff,
  getAllStaff,
  getStaffById,
  updateStaff,
  deleteStaff,
  searchStaffByName,
  searchStaffByStatus,
} = require("../../controller/admin/staff/staff.controller");
const authorizationMiddleware = require("../../middleware/auth");

const staffRouter = express.Router();

staffRouter.post("/", createStaff);

staffRouter.get('/search', searchStaffByName)
staffRouter.get('/search-status', searchStaffByStatus)

staffRouter.get("/", getAllStaff);

staffRouter.get("/one", authorizationMiddleware, getStaffById);

staffRouter.put("/:id", updateStaff);

staffRouter.delete("/:id", deleteStaff);

module.exports = staffRouter;
