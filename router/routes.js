const { Router } = require("express");
const rootRouter = Router();

const adminRouter = require("./admin/admin.router");
const department = require("./admin/department.router");
const staffRouter = require("./admin/staff.router");
const salaryDetailsRouter = require("./admin/salaryDetails.router");
const deductionsRouter = require("./admin/deductions.router");
const customDetailsRouter = require("./admin/customDetails.router");
const projectRouter = require("./admin/project.router");
const clientRouter = require("./admin/client.router");
const projectFilesRouter = require("./admin/projectFiles.router");
const discussionRouter = require("./admin/discussions.router");
const ticketRouter = require("./admin/ticketInformation.router");

rootRouter.use("/admin", adminRouter);
rootRouter.use("/department", department);
rootRouter.use("/staff", staffRouter);
rootRouter.use("/salary", salaryDetailsRouter);
rootRouter.use("/deduction", deductionsRouter);
rootRouter.use("/custom-details", customDetailsRouter);
rootRouter.use("/project", projectRouter);
rootRouter.use("/client", clientRouter);
rootRouter.use("/project-files", projectFilesRouter);
rootRouter.use("/discussions", discussionRouter);
rootRouter.use("/ticket", ticketRouter);

module.exports = rootRouter;