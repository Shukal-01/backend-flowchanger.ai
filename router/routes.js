const { Router } = require("express");
const rootRouter = Router();

const adminRouter = require("./admin/admin.router");
const department = require("./admin/department.router");
const staffRouter = require("./admin/staff.router");
const bankDetailsRouter = require("./admin/bankDetails.router");
const leaveBalanceRouter = require("./admin/leaveBalance.router");
const leaveRequestRouter = require("./admin/leaveRequest.router");
const leavePolicyRouter = require("./admin/leavePolicy.router");
const salaryDetailsRouter = require("./admin/salaryDetails.router");
const deductionsRouter = require("./admin/salaryDetails.router");
const roleRouter = require("./admin/role.router.js");

rootRouter.use("/admin", adminRouter);
rootRouter.use("/department", department);
rootRouter.use("/staff", staffRouter);
rootRouter.use("/bank-details", bankDetailsRouter);
rootRouter.use("/leave-balance", leaveBalanceRouter);
rootRouter.use("/leave-request", leaveRequestRouter);
rootRouter.use("/leave-policy", leavePolicyRouter);
rootRouter.use("/role", roleRouter);
rootRouter.use("/salary", salaryDetailsRouter);
rootRouter.use("/salary", deductionsRouter);

module.exports = rootRouter;
