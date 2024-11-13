const express = require('express');
const deductionsRouter = express.Router();
const deductionsController = require("../../controller/admin/salaryDetails.controller");



// deduction
deductionsController.get('/all', deductionsController.getAllDeductions)
deductionsController.get('/:id', deductionsController.getDeductionById)
deductionsRouter.post('/create', deductionsController.deductions)
deductionsRouter.put('/update', deductionsController.updateDeductions)


module.exports = deductionsRouter;