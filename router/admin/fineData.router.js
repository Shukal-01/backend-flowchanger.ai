const { Router } = require("express");
const { addFineData } = require("../../controller/admin/staff/fineData.controller.js");

const staffAttendanceRouter = Router();

staffAttendanceRouter.post("/", addFineData);

module.exports = staffAttendanceRouter;
