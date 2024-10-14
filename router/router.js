const { Router } = require("express");
// import staffRouter from "./admin/staff.router";
// import bankDetailsRouter from "./admin/bankDetails.router";
const policyRouter = require("./penaltyOvertimeDetail/policy.router");
const penaltyOvertimeDetailRouter = require("./penaltyOvertimeDetail/penaltyOvertimeDetail.router");

const rootRouter = Router();

rootRouter.use("/policy", policyRouter);
rootRouter.use("/panaltyOvertimeDetails", penaltyOvertimeDetailRouter);
// rootRouter.use("/staff", staffRouter);
// rootRouter.use("/bank-details", bankDetailsRouter);

module.exports = rootRouter