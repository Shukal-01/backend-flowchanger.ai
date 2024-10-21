const express = require("express");
const salaryController = express.Router();
const salaryDetailsController = require("../../controller/admin/salaryDetails.controller");

// salary
// salaryController.post("/", salaryDetailsController.addOrUpdateSalaryDetails);
// salaryController.get("/", salaryDetailsController.getAllSalaryData);
// salaryController.put("/:id", salaryDetailsController.updateSalaryData);
// salaryController.delete("/:id", salaryDetailsController.deleteSalaryRecord);
// salaryController.get("/:id", salaryDetailsController.getSalaryDetailsById);

// deduction
salaryController.post("/", salaryDetailsController.deductions);
salaryController.get("/", salaryDetailsController.getAllDeductions);
salaryController.get("/:id", salaryDetailsController.getDeductionsById);
salaryController.put("/:id", salaryDetailsController.updateDeductions);
salaryController.delete("/:id", salaryDetailsController.deleteDeductions);

module.exports = salaryController;