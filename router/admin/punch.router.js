const express = require("express");
const punchRouter = express.Router();
const upload = require("../../middleware/multer.middleware.js")
const { createPunchIn, getPunchIn, createPunchOut, getPunchOut, createPunchRecords, getPunchRecords } = require("../../controller/admin/punch.controller");

punchRouter.post("/createPunchIn", upload.single('photoUrl'), createPunchIn);
punchRouter.get("/getPunchIn", getPunchIn);
punchRouter.post("/createPunchOut", upload.single('photoUrl'), createPunchOut);
punchRouter.get("/getPunchOut", getPunchOut);
punchRouter.post("/createPunchRecords", createPunchRecords);
punchRouter.get("/getPunchRecords", getPunchRecords);

module.exports = punchRouter;