const { Router } = require("express");
const {
  fetchAllStaftAutomationAttendence,
  addAndUpdateAutomationRuleForStaffs,
} = require("../../controller/admin/staff/attendence/automationRules.controller.js");
const {
  fetchAttendenceModeForAllStaff,
  addAndUpdateAttendenceModeForStaffs,
} = require("../../controller/admin/staff/attendence/mode.controller.js");
const attendanceRouter = Router();

attendanceRouter.get("/automation", fetchAllStaftAutomationAttendence);
attendanceRouter.put("/automation", addAndUpdateAutomationRuleForStaffs);
attendanceRouter.get("/mode", fetchAttendenceModeForAllStaff);
attendanceRouter.put("/mode", addAndUpdateAttendenceModeForStaffs);

module.exports = attendanceRouter;
