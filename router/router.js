const { Router } = require("express");
const policyRouter = require("./admin/policy.router");
const penaltyOvertimeDetailRouter = require("./admin/penaltyOvertimeDetail.router");
const shiftRouter = require("./admin/shiftRouter");
const punchRouter = require("./admin/punch.router");

const rootRouter = Router();

rootRouter.use("/policy", policyRouter);
rootRouter.use("/panaltyOvertimeDetails", penaltyOvertimeDetailRouter);
rootRouter.use("/shift", shiftRouter);
rootRouter.use("/punch", punchRouter);

module.exports = rootRouter