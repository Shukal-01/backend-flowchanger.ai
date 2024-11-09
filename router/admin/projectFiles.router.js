const express = require('express');
const projectFilesRouter = express.Router();
const projectFilesController = require("../../controller/admin/project/projectFiles.controller");
const { uploadAndSaveToCloudinary } = require("../../middleware/multer.middleware.js");

projectFilesRouter.post('/', uploadAndSaveToCloudinary("file_name"), projectFilesController.addProjectFiles)
projectFilesRouter.get('/', projectFilesController.getAllProjectFiles)
projectFilesRouter.put('/:id', uploadAndSaveToCloudinary("file_name"), projectFilesController.updateProjectFiles)
projectFilesRouter.delete('/:id', projectFilesController.deleteProjectFiles)

module.exports = projectFilesRouter;
