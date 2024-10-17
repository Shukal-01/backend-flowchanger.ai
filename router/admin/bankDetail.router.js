const { Router } = require("express");
const { fetchAllStaffBankDetails, addAndUpdateBankDetailsForStaffs } = require("../../controller/admin/bankDetails.controller.js");
const bankDetailRouter = Router();

bankDetailRouter.get("/", fetchAllStaffBankDetails);
bankDetailRouter.put("/", addAndUpdateBankDetailsForStaffs); 

module.exports=bankDetailRouter