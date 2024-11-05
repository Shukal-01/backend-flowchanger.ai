const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const projectPriorityRouter = express.Router();
const projectPriorityController = require("../../controller/admin/project/projectPriority.controller.js");

projectPriorityRouter.post('/', projectPriorityController.createProjectPriority);
projectPriorityRouter.get('/:id?', projectPriorityController.getProjectPriority);
projectPriorityRouter.put('/:id', projectPriorityController.updateProjectPriority);

module.exports = projectPriorityRouter;