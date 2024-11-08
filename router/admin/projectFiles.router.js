const express = require('express');
const projectFilesRouter = express.Router();
const projectFilesController = require("../../controller/admin/project/projectFiles.controller");
const { uploadAndSaveToCloudinary } = require("../../middleware/upload.js")

projectFilesRouter.post('/', uploadAndSaveToCloudinary, projectFilesController.addProjectFiles)
projectFilesRouter.get('/', projectFilesController.getAllProjectFiles)
projectFilesRouter.put('/:id', uploadAndSaveToCloudinary, projectFilesController.updateProjectFiles)
projectFilesRouter.delete('/:id', projectFilesController.deleteProjectFiles)

module.exports = projectFilesRouter;
