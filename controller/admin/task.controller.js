const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { ZodError } = require('zod');
const { TaskPrioritySchema, TaskStatusSchema, TaskDetailSchema } = require('../../utils/validations');

// async function createTaskType(req, res) {
//     try {
//         const { taskTypeName } = req.body;

//         // Validate the taskTypeName using TaskTypeSchema
//         const taskTypeResult = TaskTypeSchema.safeParse({ taskTypeName });

//         if (!taskTypeResult.success) {
//             return res.status(400).json({ message: taskTypeResult.error.issues[0].message });
//         }

//         const taskType = await prisma.taskType.create({
//             data: taskTypeResult.data
//         });
//         res.status(201).json(taskType);
//     } catch (error) {
//         if (error instanceof ZodError) {
//             res.status(400).json({ error: 'Invalid request data' });
//         } else {
//             console.log(error);
//             res.status(500).json({ error: 'Failed to create new task type' });
//         }
//     }
// }

// async function getAllTaskType(req, res) {
//     try {
//         const taskTypes = await prisma.taskType.findMany();
//         res.status(200).json(taskTypes);
//     } catch (error) {
//         console.log(error);
//         res.status(500).json({ error: 'Failed to fetch task types' });
//     }
// }

async function createTaskStatus(req, res) {
    try {
        const { taskStatusName, statusColor, statusOrder, isHiddenId, canBeChangedId } = req.body;

        // Validate the taskTypeName using TaskTypeSchema
        const TaskStatusResult = TaskStatusSchema.safeParse({ taskStatusName, statusColor, statusOrder, isHiddenId, canBeChangedId });

        if (!TaskStatusResult.success) {
            return res.status(400).json({ message: TaskStatusResult.error.issues[0].message });
        }

        const taskStatus = await prisma.taskStatus.create({
            data: TaskStatusResult.data
        });
        res.status(201).json(taskStatus);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
            res.status(500).json({ error: 'Failed to create new task status' });
        }
    }
}

async function getAllTaskStatus(req, res) {
    try {
        const taskStatus = await prisma.taskStatus.findMany();
        res.status(200).json(taskStatus);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: 'Failed to fetch task status' });
    }
}

async function createTaskPriority(req, res) {
    try {
        const { taskPriorityName } = req.body;

        // Validate the taskTypeName using TaskTypeSchema
        const taskPriorityResult = TaskPrioritySchema.safeParse({ taskPriorityName });

        if (!taskPriorityResult.success) {
            return res.status(400).json({ message: taskPriorityResult.error.issues[0].message });
        }

        const taskPriority = await prisma.taskPriority.create({
            data: taskPriorityResult.data
        });
        res.status(201).json(taskPriority);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
            res.status(500).json({ error: 'Failed to create new task priority' });
        }
    }
}

async function getAllTaskPriority(req, res) {
    try {
        const taskPriority = await prisma.taskPriority.findMany();
        res.status(200).json(taskPriority);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: 'Failed to fetch task priority' });
    }
}

async function createTaskDetail(req, res) {
    try {
        const { taskTypeId, taskStatusId, taskPriorityId, taskName, startDate, endDate, dueDate, selectProject, selectDepartment, taskAssign, taskDescription } = req.body;
        // const attachFile = JSON.stringify(req.file);
        // if (!req.file) {
        //     return res.status(400).json({ message: 'File upload is required.' });
        // }
        // Validate the taskTypeName using TaskTypeSchema
        const taskDetailResult = TaskDetailSchema.safeParse({ taskTypeId, taskStatusId, taskPriorityId, taskName, startDate, endDate, dueDate, selectProject, selectDepartment, taskAssign, taskDescription, attachFile: req.savedFilename });

        if (!taskDetailResult.success) {
            return res.status(400).json({ message: taskDetailResult.error.issues[0].message });
        }

        const taskDetail = await prisma.taskDetail.create({
            data: {
                ...taskDetailResult.data,
                // attachFile: req.savedFileName
            }
        });
        console.log(taskDetail)
        res.status(201).json(taskDetail);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
            res.status(500).json({ error: 'Failed to create new task detail' });
        }
    }
}

async function getAllTaskDetail(req, res) {
    try {
        const taskDetail = await prisma.taskDetail.findMany();
        res.status(200).json(taskDetail);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: 'Failed to fetch task detail' });
    }
}

async function deleteTaskDetail(req, res) {
    const { id } = req.params;
    try {
        // Check if the task exists before attempting to delete
        const taskDetail = await prisma.taskDetail.findUnique({
            where: { id }
        });

        if (!taskDetail) {
            return res.status(404).json({ error: "Task not found" });
        }

        // Delete the task detail
        await prisma.taskDetail.delete({
            where: { id }
        });

        res.status(200).json(taskDetail);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: 'Failed to delete task detail' });
    }
}

async function updateTaskDetail(req, res) {
    try {
        const { id } = req.params; // Extract taskDetail ID from the URL params
        const { taskTypeId, taskStatusId, taskPriorityId, taskName, startDate, endDate, dueDate, selectProject, selectDepartment, taskAssign, taskDescription } = req.body;
        const attachFile = req.file ? req.savedFilename : null; // Check if a new file is uploaded

        // Validate the input data using Zod schema
        const taskDetailResult = TaskDetailSchema.safeParse({
            taskTypeId,
            taskStatusId,
            taskPriorityId,
            taskName,
            startDate,
            endDate,
            dueDate,
            selectProject,
            selectDepartment,
            taskAssign,
            taskDescription,
            attachFile
        });

        if (!taskDetailResult.success) {
            return res.status(400).json({ message: taskDetailResult.error.issues[0].message });
        }

        // Check if the task exists before updating
        const existingTaskDetail = await prisma.taskDetail.findUnique({
            where: { id }
        });

        if (!existingTaskDetail) {
            return res.status(404).json({ error: "Task not found" });
        }

        // Update the task detail
        const updatedTaskDetail = await prisma.taskDetail.update({
            where: { id },
            data: {
                ...taskDetailResult.data,
                attachFile: attachFile || existingTaskDetail.attachFile // Preserve the existing file if no new file is uploaded
            }
        });

        res.status(200).json(updatedTaskDetail);
    } catch (error) {
        if (error instanceof ZodError) {
            res.status(400).json({ error: 'Invalid request data' });
        } else {
            console.log(error);
            res.status(500).json({ error: 'Failed to update task detail' });
        }
    }
}

async function getTaskDetailById(req, res) {
    try {
        const { id } = req.params; // Extract the taskDetail ID from the URL params

        // Find the task detail by ID
        const taskDetail = await prisma.taskDetail.findUnique({
            where: { id }
        });

        // If the task detail is not found, return a 404 error
        if (!taskDetail) {
            return res.status(404).json({ message: "Task detail not found" });
        }

        // If task detail is found, return it
        res.status(200).json(taskDetail);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Failed to fetch task detail" });
    }
}


module.exports = {
    createTaskStatus,
    getAllTaskStatus,
    createTaskPriority,
    getAllTaskPriority,
    createTaskDetail,
    getAllTaskDetail,
    deleteTaskDetail,
    updateTaskDetail,
    getTaskDetailById
}