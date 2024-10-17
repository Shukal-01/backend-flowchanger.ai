const express = require("express");
const punchRouter = express.Router();
const upload = require("../../middleware/multer.middleware.js")
const { createPunchIn } = require("../../controller/admin/punch.controller");

punchRouter.post("/create", upload.single('photoUrl'), createPunchIn);

module.exports = punchRouter;