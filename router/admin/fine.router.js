const { Router } = require("express");
const { addFineData } = require("../../controller/admin/staff/fine.controller.js");

const staffAttendanceRouter = Router();

staffAttendanceRouter.post("/create", addFineData);

module.exports = staffAttendanceRouter;
