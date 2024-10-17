const { Router } = require("express");
const roleRouter = require("./admin/role.router.js");
const attendenceRouter = require("./admin/attendence.router.js");
const bankDetailRouter = require("./admin/bankDetail.router.js");
const staffRouter = require("./admin/bgVerification.router.js");
const rootRouter = Router();

// used role Router
rootRouter.use("/role", roleRouter);
rootRouter.use("/attendence", attendenceRouter);
rootRouter.use("/bankDetails", bankDetailRouter);
rootRouter.use("/staff/",staffRouter)

module.exports = rootRouter;
