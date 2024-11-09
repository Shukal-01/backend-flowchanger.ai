const express = require("express");
const punchRouter = express.Router();
const { uploadAndSaveToCloudinary, upload } = require("../../middleware/multer.middleware.js");
const {
  createPunchIn,
  getAllPunchIn,
  createPunchOut,
  getAllPunchOut,
  getPunchRecords,
  getPunchRecordById,
} = require("../../controller/admin/punch.controller.js");
const authorizationMiddleware = require("../../middleware/auth.js");

punchRouter.post("/in", uploadAndSaveToCloudinary, authorizationMiddleware, upload().single("photoUrl"), createPunchIn);
punchRouter.get("/in", getAllPunchIn);
punchRouter.post("/out", uploadAndSaveToCloudinary, authorizationMiddleware, upload().single("photoUrl"), createPunchOut);
punchRouter.get("/out", getAllPunchOut);
punchRouter.get("/records", getPunchRecords);
punchRouter.get("/records/:id", getPunchRecordById);

module.exports = punchRouter;
