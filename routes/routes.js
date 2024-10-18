const { Router } = require("express");
const policyRouter = require("./admin/policy.router");
const penaltyOvertimeDetailRouter = require("./admin/penaltyOvertimeDetail.router");
const shiftRouter = require("./admin/shift.router");
const punchRouter = require("./admin/punch.router");
const taskRouter = require("./admin/task.router");

const rootRoutes = Router();

rootRoutes.use("/policy", policyRouter);
rootRoutes.use("/panaltyOvertimeDetails", penaltyOvertimeDetailRouter);
rootRoutes.use("/shift", shiftRouter);
rootRoutes.use("/punch", punchRouter);
rootRoutes.use("/task", taskRouter);

module.exports = rootRoutes