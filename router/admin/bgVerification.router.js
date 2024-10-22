const { Router } = require("express");
const {
  fetchAllStaffBgVerification,
  updateStaffBgVerifcation,
} = require("../../controller/admin/staff/bgVerification.controller.js");
const upload = require("../../middleware/upload.js");

const bgVerificationRouter = Router();
bgVerificationRouter.get("/:id/verify", fetchAllStaffBgVerification);
bgVerificationRouter.put(
  "/:id/verify/:verificationType",
  upload.single("file"),
  updateStaffBgVerifcation
);

module.exports = bgVerificationRouter;
