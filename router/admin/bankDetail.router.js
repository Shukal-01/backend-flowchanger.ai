const { Router } = require("express");
const { fetchAllStaffBankDetails, addAndUpdateBankDetailsForStaffs } = require("../../controller/admin/staff/bankDetails.controller.js");
const bankDetailRouter = Router();

bankDetailRouter.get("/", fetchAllStaffBankDetails);
bankDetailRouter.put("/", addAndUpdateBankDetailsForStaffs); 

module.exports=bankDetailRouter