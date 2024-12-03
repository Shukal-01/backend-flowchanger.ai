const express = require("express");
const breakRouter = express.Router();
const {
  uploadAndSaveToCloudinary,
} = require("../../middleware/multer.middleware.js");
const {
  createStartBreak,
  createEndBreak,
  getAllStartBreaks,
  getStartBreakByStaffId,
  getAllEndBreaks,
  getEndBreakByStaffId,
  getBreakRecordByStaffId,
  getBreakRecordByDate,
} = require("../../controller/admin/break.controller.js");
const authorizationMiddleware = require("../../middleware/auth.js");

breakRouter.post(
  "/start",
  uploadAndSaveToCloudinary("photoUrl"),
  authorizationMiddleware,
  createStartBreak
);
breakRouter.get("/start", getAllStartBreaks);
breakRouter.post(
  "/end",
  uploadAndSaveToCloudinary("photoUrl"),
  authorizationMiddleware,
  createEndBreak
);
breakRouter.get(
  "/record/single",
  authorizationMiddleware,
  getBreakRecordByDate
);

breakRouter.get("/breakRecord/:staffId", getBreakRecordByStaffId);
breakRouter.get("/end", getAllEndBreaks);
breakRouter.get("/start/:id", getStartBreakByStaffId);
breakRouter.get("/end/:id", getEndBreakByStaffId);

module.exports = breakRouter;
