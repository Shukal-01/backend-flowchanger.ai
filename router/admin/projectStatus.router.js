const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const projectStatusRouter = express.Router();
const projectStatusController = require("../../controller/admin/project/projectStatus.controller.js");

projectStatusRouter.post('/', projectStatusController.projectStatus);
projectStatusRouter.get('/search-status', projectStatusController.searchProjectStatusByName);
projectStatusRouter.get('/:id?', projectStatusController.getProjectStatus);
projectStatusRouter.put('/:id', projectStatusController.updateProjectStatus);

module.exports = projectStatusRouter;