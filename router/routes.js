const express = require("express");
const staffRouter = require("./admin/staff.router");

const rootRouter = express.Router();

rootRouter.use("/staff", staffRouter);

module.exports = rootRouter;
