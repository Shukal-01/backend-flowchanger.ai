const express = require("express");
const breakRouter = express.Router();
const { uploadAndSaveToCloudinary } = require("../../middleware/multer.middleware.js")
const { createStartBreak, createEndBreak, getAllStartBreaks, getStartBreakByStaffId, getAllEndBreaks, getEndBreakByStaffId } = require("../../controller/admin/break.controller.js");

breakRouter.post("/start", uploadAndSaveToCloudinary, createStartBreak);
breakRouter.get("/start", getAllStartBreaks);
breakRouter.post("/end", uploadAndSaveToCloudinary, createEndBreak);
breakRouter.get("/end", getAllEndBreaks);
breakRouter.get("/start/:id", getStartBreakByStaffId);
breakRouter.get("/end/:id", getEndBreakByStaffId);

module.exports = breakRouter;
