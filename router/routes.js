const express = require("express");
const staffRouter = require("./admin/staff.router");
const bankDetailsRouter = require("./admin/bankDetails.router");

const rootRouter = express.Router();

rootRouter.use("/staff", staffRouter);
rootRouter.use("/bank-details", bankDetailsRouter);

module.exports = rootRouter;
