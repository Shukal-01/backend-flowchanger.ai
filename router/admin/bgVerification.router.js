const { Router } = require("express");
const { fetchAllStaffBgVerification, updateStaffBgVerifcation } = require("../../controller/admin/staff/bgVerification.controller.js");
const upload = require("../../middleware/upload.js");

const staffRouter = Router();
staffRouter.get("/:id/verfiy", fetchAllStaffBgVerification);
staffRouter.put("/:id/verfiy/:verificationType", upload.single("file"), updateStaffBgVerifcation);

module.exports = staffRouter;