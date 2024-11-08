const express = require('express');
const projectRouter = express.Router();
const projectController = require("../../controller/admin/project/project.controller.js");

projectRouter.post('/create', projectController.addProject)
projectRouter.get('/', projectController.getProject)
projectRouter.put('/:id', projectController.updateProject)
projectRouter.delete('/:id', projectController.deleteProject)
projectRouter.get('/:id', projectController.showProject)
projectRouter.get('/search-projectByName', projectController.SearchingProjectsByName)

module.exports = projectRouter;