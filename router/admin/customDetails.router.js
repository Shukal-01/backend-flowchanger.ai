const express = require('express');
const customDetailsRouter = express.Router();
const customDetailsController = require("../../controller/admin/staff/customDetails.controller");

customDetailsRouter.post('/', customDetailsController.customFieldDetails)
customDetailsRouter.get('/', customDetailsController.getAllCustomfieldDetails)
customDetailsRouter.get('/:id', customDetailsController.getCustomFieldById)
customDetailsRouter.delete('/:id', customDetailsController.deleteCustomFields)

module.exports = customDetailsRouter;