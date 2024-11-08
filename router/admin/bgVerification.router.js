const { Router } = require("express");
const {
  fetchAllStaffBgVerification,
  updateStaffBgVerifcation,
} = require("../../controller/admin/staff/bgVerification.controller.js");
const { uploadAndSaveToCloudinary } = require("../../middleware/upload.js");

const bgVerificationRouter = Router();
bgVerificationRouter.get("/:id/verify", fetchAllStaffBgVerification);
bgVerificationRouter.put(
  "/:id/verify/:verificationType",
  uploadAndSaveToCloudinary,
  updateStaffBgVerifcation
);

module.exports = bgVerificationRouter;
