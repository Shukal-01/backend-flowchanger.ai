const express = require("express");
const taskRouter = express.Router();
const { uploadFile } = require("../../middleware/multer.middleware.js")
const { createTaskStatus, getAllTaskStatus, createTaskPriority, getAllTaskPriority, createTaskDetail, getAllTaskDetail, deleteTaskDetail, updateTaskDetail, getTaskDetailById, updateTaskStatus, updateTaskPriority } = require("../../controller/admin/task.controller");

// taskRouter.post("/createTaskType", createTaskType);
// taskRouter.get("/getAllTaskType", getAllTaskType);

taskRouter.post("/status", createTaskStatus);
taskRouter.get("/status", getAllTaskStatus);
taskRouter.put("/status/:id", updateTaskStatus);

taskRouter.post("/priority", createTaskPriority);
taskRouter.get("/priority", getAllTaskPriority);
taskRouter.put("/priority/:id", updateTaskPriority);

taskRouter.post("/detail", uploadFile.single('attachFile'), createTaskDetail);
taskRouter.get("/detail", getAllTaskDetail);
taskRouter.delete("/detail/:id", deleteTaskDetail);
taskRouter.put("/detail/:id", uploadFile.single('attachFile'), updateTaskDetail);
taskRouter.get("/detailById/:id", getTaskDetailById);

module.exports = taskRouter
