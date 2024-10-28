const express = require("express");
const policyRouter = express.Router();
const { createEarlyLeavePolicy, createLateComingPolicy, createOvertimePolicy, getAllEarlyLeavePolicy, getAllLateComingPolicy, getAllOvertimePolicy } = require("../../controller/admin/policy.controller");

policyRouter.post("/early", createEarlyLeavePolicy);
policyRouter.post("/late", createLateComingPolicy);
policyRouter.post("/overtime", createOvertimePolicy);
policyRouter.get("/early", getAllEarlyLeavePolicy);
policyRouter.get("/late", getAllLateComingPolicy);
policyRouter.get("/overtime", getAllOvertimePolicy);

module.exports = policyRouter;
