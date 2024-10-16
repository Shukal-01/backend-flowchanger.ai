const express = require("express");
const leavePolicyRouter = express.Router();
const leavePolicyController = require("../../controller/admin/staff/leavePolicy.controller");

leavePolicyRouter.post("/:id", leavePolicyController.createLeavePolicy);

leavePolicyRouter.get(
  "/:staffId",
  leavePolicyController.getLeavePoliciesByStaff
);

leavePolicyRouter.put("/:id", leavePolicyController.updateLeavePolicy);

leavePolicyRouter.delete("/:id", leavePolicyController.deleteLeavePolicy);

module.exports = leavePolicyRouter;
