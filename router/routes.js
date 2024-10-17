const { Router } = require("express");
const rootRouter = Router();

const adminRouter = require("./admin/admin.router");
const department = require("./admin/department.router");
const staffRouter = require("./admin/staff.router");
const salaryDetailsRouter = require("./admin/salaryDetails.router");
const deductionsRouter = require("./admin/salaryDetails.router");
const customDetailsRouter = require("./admin/customDetails.router");

rootRouter.use("/admin", adminRouter);
rootRouter.use("/department", department);
rootRouter.use("/staff", staffRouter);
rootRouter.use("/salary", salaryDetailsRouter);
rootRouter.use("/salary-deduction", deductionsRouter);
rootRouter.use("/custom-details", customDetailsRouter)

module.exports = rootRouter;