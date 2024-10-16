const express = require("express");
const leaveBalanceRouter = express.Router();
const {
  getAllLeaveBalances,
  getLeaveBalanceById,
  createLeaveBalance,
  updateLeaveBalance,
  deleteLeaveBalance,
} = require("../../controller/admin/staff/leaveBalance.controller");

leaveBalanceRouter.get("/", getAllLeaveBalances);
leaveBalanceRouter.get("/:id", getLeaveBalanceById);
leaveBalanceRouter.post("/:id", createLeaveBalance);
leaveBalanceRouter.put("/:id", updateLeaveBalance);
leaveBalanceRouter.delete("/:id", deleteLeaveBalance);

module.exports = leaveBalanceRouter;
