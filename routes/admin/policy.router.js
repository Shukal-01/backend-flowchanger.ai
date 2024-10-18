const express = require("express");
const policyRouter = express.Router();
const { createEarlyLeavePolicy, createLateComingPolicy, createOvertimePolicy, getAllEarlyLeavePolicy, getAllLateComingPolicy, getAllOvertimePolicy } = require("../../controller/admin/policy.controller");

policyRouter.post("/early-leave", createEarlyLeavePolicy);
policyRouter.post("/late-coming", createLateComingPolicy);
policyRouter.post("/overtime", createOvertimePolicy);
policyRouter.get("/getEarlyLeavePolicy", getAllEarlyLeavePolicy);
policyRouter.get("/getLateComingPolicy", getAllLateComingPolicy);
policyRouter.get("/getOvertimePolicy", getAllOvertimePolicy);

module.exports = policyRouter;