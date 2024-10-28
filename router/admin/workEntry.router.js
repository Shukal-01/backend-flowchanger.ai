const express = require("express");
const workController = require("../../controller/admin/staff/workEntry.controller");
const upload = require("../../middleware/upload");
const workRouter = express.Router();

// Route to send OTP to mobile number
workRouter.post("/", upload.single("attachments"), workController.addWorkEntry);
workRouter.get("/:id", workController.getAllWorkEntry);
workRouter.put(
  "/:id",
  upload.single("attachments"),
  workController.updateWorkEntry
);
workRouter.delete("/:id", workController.deleteWorkEntry);
workRouter.get("/:id", workController.getWorkEntryById);

module.exports = workRouter;
