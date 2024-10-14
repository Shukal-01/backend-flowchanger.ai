import { Router} from "express"

const router = Router();

import department from './department.router.js';

router.use('/department', department);

export default router;
const express = require("express");
const staffRouter = require("./admin/staff.router");
const bankDetailsRouter = require("./admin/bankDetails.router");

const rootRouter = express.Router();

rootRouter.use("/staff", staffRouter);
rootRouter.use("/bank-details", bankDetailsRouter);

module.exports = rootRouter;
