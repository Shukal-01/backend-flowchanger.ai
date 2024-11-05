const express = require('express');
const deductionsRouter = express.Router();
const deductionsController = require("../../controller/admin/salaryDetails.controller");



// deduction
deductionsRouter.post('/create', deductionsController.deductions)
deductionsRouter.put('/update', deductionsController.updateDeductions)


module.exports = deductionsRouter;