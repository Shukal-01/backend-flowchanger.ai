const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const projectStatusRouter = express.Router();
const projectStatusController = require("../../controller/admin/project/projectStatus.controller.js");

projectStatusRouter.post('/project-status', projectStatusController.projectStatus);
projectStatusRouter.get('/project-status/:id?', projectStatusController.getProjectStatus);
projectStatusRouter.put('/project-status/:id', projectStatusController.updateProjectStatus);

module.exports = projectStatusRouter;