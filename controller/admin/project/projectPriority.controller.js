const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

// Project Priority
const createProjectPriority = async (req, res) => {
  const {
    Priority_name,
    Priority_color,
    Priority_order,
    default_filter,
    is_hidden,
    can_changed,
  } = req.body;
  try {
    // Ensure canBeChanged is an array, filter out null or undefined values
    const isArrayChangedValue = Array.isArray(can_changed)
      ? can_changed.filter((item) => item != null)
      : [can_changed].filter((item) => item != null);
    const isArrayHiddenValue = Array.isArray(is_hidden)
      ? is_hidden.filter((item) => item != null)
      : [is_hidden].filter((item) => item != null);

    const addProjectPriority = await prisma.projectPriority.create({
      data: {
        Priority_name,
        Priority_color,
        Priority_order,
        default_filter: !!default_filter,
        is_hidden: isArrayHiddenValue,
        can_changed: isArrayChangedValue,
      },
    });
    return res
      .status(201)
      .json({
        message: "Project Priority Added Successfully!",
        data: addProjectPriority,
      });
  } catch (error) {
    console.error("Failed adding project Priority:", error.message);
    return res
      .status(500)
      .json({ message: "Project priority failed to created" + error.message });
  }
};

// get project Priority
const getProjectPriority = async (req, res) => {
  try {
    const projectPriority = await prisma.projectPriority.findMany();

    // Check if any records were found
    if (projectPriority.length === 0) {
      return res
        .status(404)
        .json({ message: "No project priority found!" + error.message });
    }

    return res
      .status(201)
      .json({
        message: "Project Priority fetched successfully!",
        data: projectPriority,
      });
  } catch (error) {
    console.error("Failed fetching project Priority:", error);
    return res
      .status(500)
      .json({ message: "Failed to fetch project priority!" + error.message });
  }
};

// update project Priority
const updateProjectPriority = async (req, res) => {
  const {
    id,
    Priority_name,
    Priority_color,
    Priority_order,
    default_filter,
    is_hidden,
    can_changed,
  } = req.body;
  try {
    // Ensure canBeChanged is an array, filter out null or undefined values
    const isArrayChangedValue = Array.isArray(can_changed)
      ? can_changed.filter((item) => item != null)
      : [can_changed].filter((item) => item != null);
    const isArrayHiddenValue = Array.isArray(is_hidden)
      ? is_hidden.filter((item) => item != null)
      : [is_hidden].filter((item) => item != null);
    const updateProjectPriority = await prisma.projectPriority.update({
      where: { id },
      data: {
        Priority_name,
        Priority_color,
        Priority_order,
        default_filter: !!default_filter,
        is_hidden: isArrayHiddenValue,
        can_changed: isArrayChangedValue,
      },
    });
    return res
      .status(201)
      .json({
        message: "Project Priority Updated Successfully!",
        data: updateProjectPriority,
      });
  } catch (error) {
    console.error("Failed updating project Priority:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to update project priority" + error.message });
  }
};

const searchProjectPriorityByName = async (req, res) => {
  try {
    const { name } = req.query;
    const projectPriority = await prisma.projectPriority.findMany({
      where: {
        Priority_name: {
          contains: name,
        },
      },
    });
    return res.status(200).json(projectPriority);
  } catch (error) {
    console.error("Failed searching project priority:", error);
    return res
      .status(500)
      .json({ message: "Failed to search project priority" + error.message });
  }
};
module.exports = {
  createProjectPriority,
  getProjectPriority,
  updateProjectPriority,
  searchProjectPriorityByName,
};
