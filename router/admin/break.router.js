const express = require("express");
const breakRouter = express.Router();
const { upload } = require("../../middleware/multer.middleware.js")
const { createStartBreak, createEndBreak, getAllStartBreaks, getStartBreakByStaffId, getAllEndBreaks, getEndBreakByStaffId } = require("../../controller/admin/break.controller.js");

breakRouter.post("/start", upload.single('photoUrl'), createStartBreak);
breakRouter.get("/start", getAllStartBreaks);
breakRouter.post("/end", upload.single('photoUrl'), createEndBreak);
breakRouter.get("/end", getAllEndBreaks);
breakRouter.get("/start/:id", getStartBreakByStaffId);
breakRouter.get("/end/:id", getEndBreakByStaffId);

module.exports = breakRouter;
