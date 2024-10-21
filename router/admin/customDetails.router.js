<<<<<<< HEAD:router/admin/customDetails.router.js
const express = require('express');
const customDetailsRouter = express.Router();
const customDetailsController = require("../../controller/admin/staff/customDetails.controller");

customDetailsRouter.post('/', customDetailsController.customFieldDetails)
customDetailsRouter.get('/', customDetailsController.getAllCustomfieldDetails)
customDetailsRouter.get('/:id', customDetailsController.getCustomFieldById)
customDetailsRouter.delete('/:id', customDetailsController.deleteCustomFields)

module.exports = customDetailsRouter;
=======
const express = require("express");
const customDetailsRouter = express.Router();
const customDetailsController = require("../../controller/admin/staff/customDetails.controller");

customDetailsRouter.post("/", customDetailsController.customFieldDetails);
customDetailsRouter.get("/", customDetailsController.getAllCustomFields);
customDetailsRouter.get("/:id", customDetailsController.getCustomFieldById);
customDetailsRouter.delete("/:id", customDetailsController.deleteCustomFields);
customDetailsRouter.put("/:id", customDetailsController.updateCustomFields);

module.exports = customDetailsRouter;
>>>>>>> 2a6ebb8629ac2da4206638ea938b9f79a28bf21d:routes/admin/customDetails.router.js
