
const express = require('express');
const { createStaff, getAllStaff, getStaffById, updateStaff, deleteStaff } = require('../../controller/admin/staff/staff.controller');

const staffRouter = express.Router();

staffRouter.post("/create", createStaff);

staffRouter.get("/", getAllStaff);

staffRouter.get("/:id", getStaffById);

staffRouter.put("/:id", updateStaff);

staffRouter.delete("/:id", deleteStaff);

module.exports = staffRouter;