const express = require("express");
const taskRouter = express.Router();
const { uploadAndSaveToCloudinary } = require("../../middleware/multer.middleware.js")
const { createTaskStatus, getAllTaskStatus, createTaskPriority, getAllTaskPriority, createTaskDetail, getAllTaskDetail, deleteTaskDetail, updateTaskDetail, getTaskDetailById, updateTaskStatus, updateTaskPriority, searchTaskDetailByName, searchTaskStatusByName } = require("../../controller/admin/task.controller");

// taskRouter.post("/createTaskType", createTaskType);
// taskRouter.get("/getAllTaskType", getAllTaskType);

taskRouter.post("/status", createTaskStatus);
taskRouter.get("/status", getAllTaskStatus);
taskRouter.put("/status/:id", updateTaskStatus);

taskRouter.post("/priority", createTaskPriority);
taskRouter.get("/priority", getAllTaskPriority);
taskRouter.put("/priority/:id", updateTaskPriority);

taskRouter.post("/detail", uploadAndSaveToCloudinary, createTaskDetail);
taskRouter.get("/detail", getAllTaskDetail);
taskRouter.delete("/detail/:id", deleteTaskDetail);
taskRouter.put("/detail/:id", uploadAndSaveToCloudinary, updateTaskDetail);
taskRouter.get("/detailById/:id", getTaskDetailById);

taskRouter.get("/searchTaskPriority", searchTaskDetailByName);
taskRouter.get("/searchTaskStatus", searchTaskStatusByName);

module.exports = taskRouter
