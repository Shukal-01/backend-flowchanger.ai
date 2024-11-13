const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { ZodError } = require("zod");
const {
  TaskPrioritySchema,
  TaskStatusSchema,
  TaskDetailSchema,
} = require("../../utils/validations");

async function createTaskStatus(req, res) {
  try {
    const {
      taskStatusName,
      statusColor,
      statusOrder,
      isHiddenId,
      canBeChangedId,
    } = req.body;

    // Validate the taskTypeName using TaskTypeSchema
    const TaskStatusResult = TaskStatusSchema.safeParse({
      taskStatusName,
      statusColor,
      statusOrder,
      // isHiddenId: {
      //   connect: isHiddenId.map((id) => ({ id })), // Connect existing StaffDetails by id
      // },
      isHiddenId,
      canBeChangedId,
    });

    if (!TaskStatusResult.success) {
      return res
        .status(400)
        .json({ message: TaskStatusResult.error.issues[0].message });
    }

    const taskStatus = await prisma.taskStatus.create({
      data: {
        ...TaskStatusResult.data,
        isHiddenId: {
          connect: isHiddenId.map((id) => ({ id })), // Connect existing StaffDetails by id
        },
      },
      include: {
        isHiddenId: true, // Include the isHiddenId relation in the response
      },
    });

    res.status(201).json(taskStatus);
  } catch (error) {
    if (error instanceof ZodError) {
      res.status(400).json({ error: "Invalid request data" });
    } else {
      console.log(error);
      res.status(500).json({ error: "Failed to create new task status" });
    }
  }
}

async function getAllTaskStatus(req, res) {
  try {
    const taskStatus = await prisma.taskStatus.findMany({
      include: {
        isHiddenId: true, // Include the isHiddenId relation in the response
      },
    });
    res.status(200).json(taskStatus);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch task status" });
  }
}

async function updateTaskStatus(req, res) {
  try {
    const { id } = req.params; // Assuming the ID of the task status is passed in the URL
    const {
      taskStatusName,
      statusColor,
      statusOrder,
      isHiddenId,
      canBeChangedId,
    } = req.body;

    // Validate the incoming data using TaskStatusSchema
    const TaskStatusResult = TaskStatusSchema.safeParse({
      taskStatusName,
      statusColor,
      statusOrder,
      isHiddenId,
      canBeChangedId,
    });

    if (!TaskStatusResult.success) {
      return res
        .status(400)
        .json({ message: TaskStatusResult.error.issues[0].message });
    }

    // Update the task status in the database
    const updatedTaskStatus = await prisma.taskStatus.update({
      where: { id: id }, // Convert ID to a number if necessary
      data: TaskStatusResult.data,
    });

    res.status(200).json(updatedTaskStatus);
  } catch (error) {
    if (error instanceof ZodError) {
      res.status(400).json({ error: "Invalid request data" });
    } else {
      console.log(error);
      res.status(500).json({ error: "Failed to update task status" });
    }
  }
}

async function createTaskPriority(req, res) {
  try {
    const { taskPriorityName } = req.body;

    // Validate the taskTypeName using TaskTypeSchema
    const taskPriorityResult = TaskPrioritySchema.safeParse({
      taskPriorityName,
    });

    if (!taskPriorityResult.success) {
      return res
        .status(400)
        .json({ message: taskPriorityResult.error.issues[0].message });
    }

    const taskPriority = await prisma.taskPriority.create({
      data: taskPriorityResult.data,
    });
    res.status(201).json(taskPriority);
  } catch (error) {
    if (error instanceof ZodError) {
      res.status(400).json({ error: "Invalid request data" });
    } else {
      console.log(error);
      res.status(500).json({ error: "Failed to create new task priority" });
    }
  }
}

async function getAllTaskPriority(req, res) {
  try {
    const taskPriority = await prisma.taskPriority.findMany({
      // include: {
      //    TaskDetail: true,
      // },
    });
    res.status(200).json(taskPriority);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch task priority" });
  }
}

async function updateTaskPriority(req, res) {
  try {
    const { id } = req.params; // Assuming the ID of the task priority is passed in the URL
    const { taskPriorityName } = req.body;  // Assuming the name of the task priority is passed in the request body

    // Validate the incoming data using TaskPrioritySchema
    const taskPriorityResult = TaskPrioritySchema.safeParse({
      taskPriorityName,
    });

    if (!taskPriorityResult.success) {
      return res
        .status(400)
        .json({ message: taskPriorityResult.error.issues[0].message });
    }

    // Update the task priority in the database
    const updatedTaskPriority = await prisma.taskPriority.update({
      where: { id: id }, // Convert ID to a number if necessary
      data: taskPriorityResult.data,
    });

    res.status(200).json(updatedTaskPriority);
  } catch (error) {
    if (error instanceof ZodError) {
      res.status(400).json({ error: "Invalid request data" });
    } else {
      console.log(error);
      res.status(500).json({ error: "Failed to update task priority" });
    }
  }
}

async function createTaskDetail(req, res) {
  try {
    const {
      taskStatusId,
      taskPriorityId,
      taskName,
      startDate,
      endDate,
      dueDate,
      selectProjectId,
      selectDepartmentId,
      taskAssign,
      taskDescription,
      taskTag,
    } = req.body;

    // Validate the task details using TaskDetailSchema
    const taskDetailResult = TaskDetailSchema.safeParse({
      taskStatusId,
      taskPriorityId,
      taskName,
      startDate,
      endDate,
      dueDate,
      selectProjectId,
      selectDepartmentId,
      taskAssign,
      taskDescription,
      taskTag,
      attachFile: req.imageUrl, // Set attachFile if available
    });

    if (!taskDetailResult.success) {
      return res
        .status(400)
        .json({ message: taskDetailResult.error.issues[0].message });
    }

    // Create taskDetail and associate taskAssign users
    const taskDetail = await prisma.taskDetail.create({
      data: {
        ...taskDetailResult.data,
        taskAssign: {
          connect: taskAssign.map((id) => ({ id })), // Connect assigned users by IDs
        },
        selectDepartmentId: {
          connect: selectDepartmentId.map((id) => ({ id })),
        },
        selectProjectId: {
          connect: selectProjectId.map((id) => ({ id })),
        }
      },
      include: {
        taskAssign: true,
        selectDepartmentId: true,
        selectProjectId: true
      },
    });

    res.status(201).json(taskDetail);
  } catch (error) {
    if (error instanceof ZodError) {
      res.status(400).json({ error: "Invalid request data" });
    } else {
      console.log(error);
      res.status(500).json({ error: "Failed to create new task detail" });
    }
  }
}


async function getAllTaskDetail(req, res) {
  try {
    const taskDetail = await prisma.taskDetail.findMany({
      include: {
        taskAssign: true,
        selectDepartmentId: true,
        selectProjectId: true
      },
    });
    res.status(200).json(taskDetail);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch task detail" });
  }
}
//added

async function deleteTaskDetail(req, res) {
  const { id } = req.params;
  try {
    // Check if the task exists before attempting to delete
    const taskDetail = await prisma.taskDetail.findUnique({
      where: { id },
    });

    if (!taskDetail) {
      return res.status(404).json({ error: "Task not found" });
    }

    // Delete the task detail
    await prisma.taskDetail.delete({
      where: { id },
    });

    res.status(200).json(taskDetail);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to delete task detail" });
  }
}

async function updateTaskDetail(req, res) {
  try {
    const { id } = req.params; // Extract taskDetail ID from the URL params
    const {
      taskStatusId,
      taskPriorityId,
      taskName,
      startDate,
      endDate,
      dueDate,
      selectProjectId,
      selectDepartmentId,
      taskAssign,
      taskDescription,
      taskTag,
    } = req.body;
    // const attachFile = req.file ? req.savedFilename : null; // Check if a new file is uploaded

    // Validate the input data using Zod schema
    const taskDetailResult = TaskDetailSchema.safeParse({
      taskStatusId,
      taskPriorityId,
      taskName,
      startDate,
      endDate,
      dueDate,
      selectProjectId,
      selectDepartmentId,
      taskAssign,
      taskDescription,
      taskTag,
      attachFile: req.imageUrl,
    });

    if (!taskDetailResult.success) {
      return res
        .status(400)
        .json({ message: taskDetailResult.error.issues[0].message });
    }

    // Check if the task exists before updating
    const existingTaskDetail = await prisma.taskDetail.findUnique({
      where: { id },
    });

    if (!existingTaskDetail) {
      return res.status(404).json({ error: "Task not found" });
    }

    // Update the task detail
    const updatedTaskDetail = await prisma.taskDetail.update({
      where: { id },
      data: {
        ...taskDetailResult.data,
        taskAssign: {
          connect: taskAssign.map((id) => ({ id })), // Connect assigned users by IDs
        },
      },
    });

    res.status(200).json(updatedTaskDetail);
  } catch (error) {
    if (error instanceof ZodError) {
      res.status(400).json({ error: "Invalid request data" });
    } else {
      console.log(error);
      res.status(500).json({ error: "Failed to update task detail" });
    }
  }
}

async function getTaskDetailById(req, res) {
  try {
    const { id } = req.params; // Extract the taskDetail ID from the URL params

    // Find the task detail by ID
    const taskDetail = await prisma.taskDetail.findUnique({
      where: { id },
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

// Search Data by task priority Name

const searchTaskDetailByName = async (req, res) => {
  try {
    const { taskPriorityName } = req.query;
    const taskDetail = await prisma.taskPriority.findMany({
      where: {
        taskPriorityName: {
          contains: taskPriorityName,
          mode: "insensitive",
        },
      },
    });
    res.status(200).json(taskDetail);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to fetch task detail" });
  }
};

// Search Task Status By taskStatusName -----------------------------

const searchTaskStatusByName = async (req, res) => {
  try {
    const { taskStatusName } = req.query;
    const taskStatus = await prisma.taskStatus.findMany({
      where: {
        taskStatusName: {
          contains: taskStatusName,
          mode: "insensitive",
        },
      },
    });
    res.status(200).json(taskStatus);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to fetch task status" });
  }
};

module.exports = {
  createTaskStatus,
  getAllTaskStatus,
  createTaskPriority,
  getAllTaskPriority,
  createTaskDetail,
  getAllTaskDetail,
  deleteTaskDetail,
  updateTaskDetail,
  getTaskDetailById,
  updateTaskStatus,
  searchTaskDetailByName,
  searchTaskStatusByName,
  updateTaskPriority,
};
