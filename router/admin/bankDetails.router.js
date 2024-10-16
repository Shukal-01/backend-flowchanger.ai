const express = require("express");
const bankDetailsRouter = express.Router();
const bankDetailsController = require("../../controller/admin/staff/bankDetails.controller");

bankDetailsRouter.post("/:id", bankDetailsController.createBankDetails);

bankDetailsRouter.get("/", bankDetailsController.getAllBankDetails);

bankDetailsRouter.get("/:staffId", bankDetailsController.getBankDetailsByStaffId);

bankDetailsRouter.put("/:id", bankDetailsController.updateBankDetails);

bankDetailsRouter.delete("/:id", bankDetailsController.deleteBankDetails);

module.exports = bankDetailsRouter;

