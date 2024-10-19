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
const deductionsRouter = require("./admin/salaryDetails.router");
const customDetailsRouter = require("./admin/customDetails.router");
const policyRouter = require("./admin/policy.router");
const penaltyOvertimeDetailRouter = require("./admin/penaltyOvertimeDetail.router");
const shiftRouter = require("./admin/shift.router");
const punchRouter = require("./admin/punch.router");
const bankDetailsRouter = require("./admin/bankDetails.router.js");

rootRouter.use("/role", roleRouter);
rootRouter.use("/attendance", attendanceRouter);
rootRouter.use("/bankDetails", bankDetailsRouter);
rootRouter.use("/bg-verification", bgVerificationRouter);
rootRouter.use("/client", clientRouter);
rootRouter.use("/admin", adminRouter);
rootRouter.use("/department", department);
rootRouter.use("/staff", staffRouter);
rootRouter.use("/salary", salaryDetailsRouter);
rootRouter.use("/salary-deduction", deductionsRouter);
rootRouter.use("/custom-details", customDetailsRouter);
rootRouter.use("/policy", policyRouter);
rootRouter.use("/penaltyOvertimeDetails", penaltyOvertimeDetailRouter);
rootRouter.use("/shift", shiftRouter);
rootRouter.use("/punch", punchRouter);

module.exports = rootRouter