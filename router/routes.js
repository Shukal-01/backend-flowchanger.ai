const { Router } = require("express");
const roleRouter = require("./admin/role.router.js");
const attendenceRouter = require("./admin/attendence.router.js");
const rootRouter = Router();

// used role Router
rootRouter.use("/role", roleRouter);
rootRouter.use("/attendence", attendenceRouter);

module.exports = rootRouter;
