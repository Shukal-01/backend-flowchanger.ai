const { Router } = require("express");
const { addFineData, updateMultipleFineData } = require("../../controller/admin/staff/attendence/fine.controller.js");

const staffAttendanceRouter = Router();

staffAttendanceRouter.post("/create", addFineData);
staffAttendanceRouter.put("/", updateMultipleFineData)

module.exports = staffAttendanceRouter;
