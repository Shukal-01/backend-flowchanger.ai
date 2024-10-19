const express = require("express");
const taskRouter = express.Router();
const { uploadFile } = require("../../middleware/multer.middleware.js")
const { createTaskType, getAllTaskType, createTaskStatus, getAllTaskStatus, createTaskPriority, getAllTaskPriority, createTaskDetail, getAllTaskDetail, deleteTaskDetail, updateTaskDetail, getTaskDetailById } = require("../../controller/admin/task.controller");

taskRouter.post("/createTaskType", createTaskType);
taskRouter.get("/getAllTaskType", getAllTaskType);

taskRouter.post("/createTaskStatus", createTaskStatus);
taskRouter.get("/getAllTaskStatus", getAllTaskStatus);

taskRouter.post("/createTaskPriority", createTaskPriority);
taskRouter.get("/getAllTaskPriority", getAllTaskPriority);

taskRouter.post("/createTaskDetail", uploadFile.single('attachFile'), createTaskDetail);
taskRouter.get("/getAllTaskDetail", getAllTaskDetail);
taskRouter.delete("/deleteTaskDetail/:id", deleteTaskDetail);
taskRouter.put("/updateTaskDetail/:id", uploadFile.single('attachFile'), updateTaskDetail);
taskRouter.get("/getTaskDetailById/:id", getTaskDetailById);

module.exports = taskRouter