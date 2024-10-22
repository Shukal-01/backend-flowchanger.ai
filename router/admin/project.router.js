const express = require('express');
const projectRouter = express.Router();
const projectController = require("../../controller/admin/project/project.controller.js");

projectRouter.post('/', projectController.addProject)
projectRouter.get('/', projectController.getProject)
projectRouter.put('/:id', projectController.updateProject)
projectRouter.delete('/:id', projectController.deleteProject)
projectRouter.get('/:id', projectController.showProject)

module.exports = projectRouter;
