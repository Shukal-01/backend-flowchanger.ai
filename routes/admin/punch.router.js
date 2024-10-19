const express = require("express");
const punchRouter = express.Router();
const { upload } = require("../../middleware/multer.middleware.js")
const { createPunchIn, getPunchIn, createPunchOut, getPunchOut, getPunchRecords, getPunchRecordById } = require("../../controller/admin/punch.controller.js");

punchRouter.post("/createPunchIn", upload.single('photoUrl'), createPunchIn);
punchRouter.get("/getPunchIn", getPunchIn);
punchRouter.post("/createPunchOut", upload.single('photoUrl'), createPunchOut);
punchRouter.get("/getPunchOut", getPunchOut);
punchRouter.get("/getPunchRecords", getPunchRecords);
punchRouter.get("/getPunchRecordById/:id", getPunchRecordById);

module.exports = punchRouter;