const express = require('express');
const projectFilesRouter = express.Router();
const projectFilesController = require("../../controller/admin/project/projectFiles.controller");
const upload = require("../../middleware/upload.js")

projectFilesRouter.post('/', upload.single("file"), projectFilesController.addProjectFiles)
projectFilesRouter.get('/', projectFilesController.getAllProjectFiles)
projectFilesRouter.put('/:id', upload.single("file"), projectFilesController.updateProjectFiles)
projectFilesRouter.delete('/:id', projectFilesController.deleteProjectFiles)

module.exports = projectFilesRouter;
