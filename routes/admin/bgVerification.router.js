const { Router } = require("express");
const {
  fetchAllStaffBgVerification,
  updateStaffBgVerifcation,
} = require("../../controller/admin/staff/bgVerification.controller.js");
const upload = require("../../middleware/upload.js");

const bgVerificationRouter = Router();
bgVerificationRouter.get("/:id/verfiy", fetchAllStaffBgVerification);
bgVerificationRouter.put(
  "/:id/verfiy/:verificationType",
  upload.single("file"),
  updateStaffBgVerifcation
);

module.exports = bgVerificationRouter;
