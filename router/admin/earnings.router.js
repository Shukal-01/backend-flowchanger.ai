const express = require('express');
const earningsController = express.Router();
const earningsDataController = require("../../controller/admin/salaryDetails.controller");

// earningsController.post('/', earningsDataController.EarningsData)
// earningsController.get('/all', earningsDataController.getAllEarningsData)
earningsController.post('/create', earningsDataController.createEarningHead)
earningsController.put('/update', earningsDataController.updateEarningHead)

module.exports = earningsController;