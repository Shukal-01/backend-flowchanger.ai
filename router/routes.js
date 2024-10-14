const { Router } = require("express");
const roleRouter = require("./admin/role.router.js");
const rootRouter = Router();

// used role Router
rootRouter.use("/role", roleRouter);

module.exports = rootRouter;
