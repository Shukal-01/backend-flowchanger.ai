const express = require("express");

// const router = Router();
const adminSignup = require('./admin/registerLogin.router')
const department = require('./admin/department.router');
const staffRouter = require("./admin/staff.router");
const bankDetailsRouter = require("./admin/bankDetails.router");
const salaryDetailsRouter = require("./admin/salaryDetails.router");
const deductionsRouter = require("./admin/salaryDetails.router");

const rootRouter = express.Router();

rootRouter.use('/admin', adminSignup)
rootRouter.use('/department', department);
rootRouter.use("/staff", staffRouter);
rootRouter.use("/bank-details", bankDetailsRouter);
rootRouter.use("/salary", salaryDetailsRouter);
rootRouter.use("/salary", deductionsRouter);

module.exports = rootRouter;