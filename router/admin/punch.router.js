const express = require("express");
const punchRouter = express.Router();
<<<<<<< HEAD
const { upload } = require("../../middleware/multer.middleware.js");
const {
  createPunchIn,
  getPunchIn,
  createPunchOut,
  getPunchOut,
  getPunchRecords,
  getPunchRecordById,
} = require("../../controller/admin/punch.controller.js");

punchRouter.post("/createPunchIn", upload.single("photoUrl"), createPunchIn);
punchRouter.get("/getPunchIn", getPunchIn);
punchRouter.post("/createPunchOut", upload.single("photoUrl"), createPunchOut);
punchRouter.get("/getPunchOut", getPunchOut);
punchRouter.get("/getPunchRecords", getPunchRecords);
punchRouter.get("/getPunchRecordById/:id", getPunchRecordById);
=======
const { upload } = require("../../middleware/multer.middleware.js")
const { createPunchIn, getAllPunchIn, createPunchOut, getAllPunchOut, getPunchRecords, getPunchRecordById } = require("../../controller/admin/punch.controller.js");

punchRouter.post("/in", upload.single('photoUrl'), createPunchIn);
punchRouter.get("/in", getAllPunchIn);
punchRouter.post("/out", upload.single('photoUrl'), createPunchOut);
punchRouter.get("/out", getAllPunchOut);
punchRouter.get("/records", getPunchRecords);
punchRouter.get("/records/:id", getPunchRecordById);
>>>>>>> e3c229b06bb64aa3097d6e4ef74b0956acb2f28e

module.exports = punchRouter;
