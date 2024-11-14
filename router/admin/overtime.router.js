const { Router } = require("express");
const { addOvertimeData } = require("../../controller/admin/staff/overtime.controller.js");

const overtimeRouter = Router();

overtimeRouter.post("/create", addOvertimeData);

module.exports = overtimeRouter;
