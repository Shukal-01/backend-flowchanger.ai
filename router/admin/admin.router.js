const express = require("express");
const adminRouter = express.Router();
const authenticateUser = require("../../middleware/auth");
const {
  adminSignup,
  verifyOTP,
  adminLogin,
  updateAdmin,
  getAllAdmins,
} = require("../../controller/admin/admin.controller");

adminRouter.post("/", adminSignup);
adminRouter.put("/verify-otp", verifyOTP);
adminRouter.post("/login", adminLogin);
adminRouter.put("/update", updateAdmin);
adminRouter.get("/", getAllAdmins);

module.exports = adminRouter;
