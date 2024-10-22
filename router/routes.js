const { Router } = require("express");
const rootRouter = Router();

const roleRouter = require("./admin/role.router.js");
const attendanceRouter = require("./admin/attendence.router.js");
const bgVerificationRouter = require("./admin/bgVerification.router.js");
const clientRouter = require("./admin/client.router.js");
const adminRouter = require("./admin/admin.router");
const department = require("./admin/department.router");
const staffRouter = require("./admin/staff.router");
const salaryDetailsRouter = require("./admin/salaryDetails.router");
const deductionsRouter = require("./admin/deductions.router");
const customDetailsRouter = require("./admin/customDetails.router");
const policyRouter = require("./admin/policy.router");
const penaltyOvertimeDetailRouter = require("./admin/penaltyOvertimeDetail.router");
const shiftRouter = require("./admin/shift.router");
const punchRouter = require("./admin/punch.router");
const bankDetailsRouter = require("./admin/bankDetails.router.js");
const projectRouter = require("./admin/project.router");
const projectFilesRouter = require("./admin/projectFiles.router");
const leaveBalanceRouter = require("./admin/leaveBalance.router");
const leavePolicyRouter = require("./admin/leavePolicy.router");
const leaveRequestRouter = require("./admin/leaveRequest.router");
const taskRouter = require("./admin/task.router");
const discussionRouter = require("./admin/discussions.router");
const ticketRouter = require("./admin/ticketInformation.router");


rootRouter.use("/role", roleRouter);
rootRouter.use("/attendance", attendanceRouter);
rootRouter.use("/bankDetails", bankDetailsRouter);
rootRouter.use("/bg-verification", bgVerificationRouter);
rootRouter.use("/client", clientRouter);
rootRouter.use("/admin", adminRouter);
rootRouter.use("/department", department);
rootRouter.use("/staff", staffRouter);
rootRouter.use("/salary", salaryDetailsRouter);
rootRouter.use("/deduction", deductionsRouter);
rootRouter.use("/custom-details", customDetailsRouter);
rootRouter.use("/policy", policyRouter);
rootRouter.use("/penaltyOvertimeDetails", penaltyOvertimeDetailRouter);
rootRouter.use("/shift", shiftRouter);
rootRouter.use("/punch", punchRouter);
rootRouter.use("/project", projectRouter);
rootRouter.use("/project-files", projectFilesRouter);
rootRouter.use("/leave-balance", leaveBalanceRouter);
rootRouter.use("/leave-policy", leavePolicyRouter);
rootRouter.use("/leave-request", leaveRequestRouter);
rootRouter.use("/task", taskRouter);
rootRouter.use("/discussions", discussionRouter);
rootRouter.use("/ticket", ticketRouter);

module.exports = rootRouter