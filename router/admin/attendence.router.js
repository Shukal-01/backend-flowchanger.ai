const { Router } = require("express");
const {
  fetchAllStaftAutomationAttendence,
  addAndUpdateAutomationRuleForStaffs,
} = require("../../controller/admin/staff/attendence/automationRules.controller.js");
const {
  fetchAttendenceModeForAllStaff,
  addAndUpdateAttendenceModeForStaffs,
} = require("../../controller/admin/staff/attendence/mode.controller.js");

const {
  allStaffAttendanceByDate,
  updatePunchRecordStatus,
  getSingleStaffAttendance,
} = require("../../controller/admin/staff/attendence/attendance.controller.js");



const attendanceRouter = Router();

attendanceRouter.get("/automation", fetchAllStaftAutomationAttendence);
attendanceRouter.put("/automation", addAndUpdateAutomationRuleForStaffs);
attendanceRouter.get("/mode", fetchAttendenceModeForAllStaff);
attendanceRouter.put("/mode", addAndUpdateAttendenceModeForStaffs);

// attendance overview routes here :-

attendanceRouter.patch("/status/:id", updatePunchRecordStatus);
// attendance records

attendanceRouter.get("/summary", allStaffAttendanceByDate);

// single staff attendance records
attendanceRouter.get('/single/:id', getSingleStaffAttendance);


module.exports = attendanceRouter;
