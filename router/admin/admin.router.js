const express = require("express");
const adminRouter = express.Router();
const authenticateUser = require("../../middleware/auth");
const adminController = require("../../controller/admin/registerLogin.controller");

adminRouter.post("/", adminController.adminSignup);
adminRouter.put("/verify-otp", adminController.verifyOTP);
adminRouter.post("/login", adminController.adminLogin);

module.exports = adminRouter;
