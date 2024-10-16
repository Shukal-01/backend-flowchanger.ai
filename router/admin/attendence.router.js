const { Router } = require("express");
const { fetchAllStaftAutomationAttendence, addAndUpdateAutomationRuleForStaffs } = require("../../controller/admin/attendence/automationRules.controller.js");
const { fetchAttendenceModeForAllStaff, addAndUpdateAttendenceModeForStaffs } = require("../../controller/admin/attendence/mode.controller.js");
const attendenceRouter = Router();

attendenceRouter.get("/automation", fetchAllStaftAutomationAttendence);
attendenceRouter.put("/automation", addAndUpdateAutomationRuleForStaffs);
attendenceRouter.get("/mode", fetchAttendenceModeForAllStaff);
attendenceRouter.put("/mode", addAndUpdateAttendenceModeForStaffs);

module.exports = attendenceRouter;
