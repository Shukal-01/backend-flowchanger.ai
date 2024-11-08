const express = require("express");
const workController = require("../../controller/admin/staff/workEntry.controller");
const { uploadAndSaveToCloudinary } = require("../../middleware/upload.js");
const authorizationMiddleware = require("../../middleware/auth");
const workRouter = express.Router();

// Route to send OTP to mobile number
workRouter.post("/", uploadAndSaveToCloudinary, authorizationMiddleware, workController.addWorkEntry);
workRouter.get("/", workController.getAllWorkEntry);
workRouter.put(
  "/:id",
  uploadAndSaveToCloudinary,
  workController.updateWorkEntry
);
workRouter.delete("/:id", workController.deleteWorkEntry);
workRouter.get("/:id", workController.getWorkEntryById);

module.exports = workRouter;
