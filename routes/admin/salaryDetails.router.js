const express = require("express");
const salaryController = express.Router();
const salaryDetailsController = require("../../controller/admin/salaryDetails.controller");

// salary
salaryController.post("/salary", salaryDetailsController.addSalaryDetails);
salaryController.get("/salary", salaryDetailsController.getAllSalaryData);
salaryController.put("/salary/:id", salaryDetailsController.updateSalaryData);
salaryController.delete(
  "/salary/:id",
  salaryDetailsController.deleteSalaryRecord
);
salaryController.get(
  "/salary/:id",
  salaryDetailsController.getSalaryDetailsById
);

// deduction
// salaryController.post('/deductions', salaryDetailsController.deductions)
// salaryController.get('/deductions', salaryDetailsController.getAllDeductions)
// salaryController.get('/deductions/:id', salaryDetailsController.getDeductionsById)
// salaryController.put('/deductions/:id', salaryDetailsController.updateDeductions)
// salaryController.delete('/deductions/:id', salaryDetailsController.deleteDeductions)

module.exports = salaryController;
