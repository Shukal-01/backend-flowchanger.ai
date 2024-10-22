const express = require('express');
const deductionsRouter = express.Router();
const deductionsController = require("../../controller/admin/salaryDetails.controller");



// deduction
deductionsRouter.post('/', deductionsController.deductions)
deductionsRouter.get('/', deductionsController.getAllDeductions)
deductionsRouter.get('/:id', deductionsController.getDeductionsById)
deductionsRouter.put('/:id', deductionsController.updateDeductions)
deductionsRouter.delete('/:id', deductionsController.deleteDeductions)


module.exports = deductionsRouter;