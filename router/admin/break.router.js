const express = require("express");
const breakRouter = express.Router();
const { uploadAndSaveToCloudinary } = require("../../middleware/multer.middleware.js")
const { createStartBreak, createEndBreak, getAllStartBreaks, getStartBreakByStaffId, getAllEndBreaks, getEndBreakByStaffId } = require("../../controller/admin/break.controller.js");
const authorizationMiddleware = require("../../middleware/auth.js");

breakRouter.post("/start", uploadAndSaveToCloudinary("photoUrl"), authorizationMiddleware, createStartBreak);
breakRouter.get("/start", getAllStartBreaks);
breakRouter.post("/end", uploadAndSaveToCloudinary("photoUrl"), authorizationMiddleware, createEndBreak);
breakRouter.get("/end", getAllEndBreaks);
breakRouter.get("/start/:id", getStartBreakByStaffId);
breakRouter.get("/end/:id", getEndBreakByStaffId);

// breakRouter.get("/breakRecord/:staffId", getBreakRecordByStaffId);

module.exports = breakRouter;
