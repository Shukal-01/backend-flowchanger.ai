const express = require("express");
const punchRouter = express.Router();
const { uploadAndSaveToCloudinary } = require("../../middleware/multer.middleware.js");
const {
  createPunchIn,
  getAllPunchIn,
  createPunchOut,
  getAllPunchOut,
  getPunchRecords,
  getPunchRecordById,
} = require("../../controller/admin/punch.controller.js");

punchRouter.post("/in", uploadAndSaveToCloudinary, createPunchIn);
punchRouter.get("/in", getAllPunchIn);
punchRouter.post("/out", uploadAndSaveToCloudinary, createPunchOut);
punchRouter.get("/out", getAllPunchOut);
punchRouter.get("/records", getPunchRecords);
punchRouter.get("/records/:id", getPunchRecordById);

module.exports = punchRouter;
