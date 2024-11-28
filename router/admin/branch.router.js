const { Router } = require("express");
const { createBranch, getAllBranch, deleteBranch, updateBranch } = require("../../controller/admin/branch.controller");

const branchRouter = Router();

branchRouter.get("/", getAllBranch);
branchRouter.post("/", createBranch);
branchRouter.delete("/:id", deleteBranch);
branchRouter.put("/:id", updateBranch);

module.exports = branchRouter;