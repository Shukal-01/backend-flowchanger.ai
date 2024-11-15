const { Router } = require("express");
const { addFineData } = require("../../controller/admin/staff/attendence/fine.controller.js");

const staffAttendanceRouter = Router();

staffAttendanceRouter.post("/create", addFineData);

module.exports = staffAttendanceRouter;
