const { PrismaClient } = require("@prisma/client");
const nodemailer = require("nodemailer");
const upload = require("../../middleware/upload.js");
const prisma = new PrismaClient();

// Add Work Entry Query
const addWorkEntry = async (req, res) => {
  try {
    const {
      staffLoginId,
      work_name,
      units,
      attachments,
      description,
      location,
    } = req.body;
    const file_name = req.file ? req.file.originalname : null;

    // Get today's date (set time to midnight)
    const today = new Date();
    today.setHours(0, 0, 0, 0); // Set time to 00:00:00

    // Check if a work entry already exists for today
    const existingEntry = await prisma.workEntry.findFirst({
      where: {
        staffLoginId: staffLoginId,
        createdAt: {
          gte: today, // Greater than or equal to today's date
          lt: new Date(today.getTime() + 86400000), // Less than tomorrow's date
        },
      },
    });

    if (existingEntry) {
      return res.status(400).json({
        status: 400,
        message: "You cannot create more than one entry per day.",
      });
    }

    // Create new work entry if no existing entry found for today
    const newWorkEntry = await prisma.workEntry.create({
      data: {
        work_name: work_name,
        units: units,
        description: description,
        attachments: file_name,
        location: location,
        staffLoginId: staffLoginId,
      },
    });

    return res.status(200).json({
      status: 200,
      message: "Work Entry Created Successfully!",
      data: newWorkEntry,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: 500,
      message: "An error occurred while creating the work entry",
    });
  }
};

// get all work entry
const getAllWorkEntry = async (req, res) => {
  try {
    const getAllWorkEntry = await prisma.workEntry.findMany({
      where: {
        staffLoginId: req.params.id,
      },
    });
    return res.status(200).json({
      status: 200,
      message: "All Work Entry Data!",
      data: getAllWorkEntry,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: 500,
      message: "An error occurred while fetching all work entry data",
    });
  }
};

// update work entry
const updateWorkEntry = async (req, res) => {
  const { id } = req.params;
  const { work_name, units, discription, location } = req.body;
  try {
    const updateWorkEntry = await prisma.workEntry.update({
      where: { id: id },
      data: {
        work_name: work_name,
        units: units,
        discription: discription,
        location: location,
      },
    });
    return res.status(200).json({
      status: 200,
      message: "Work Entry Updated Successfully!",
      data: updateWorkEntry,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: 500,
      message: "An error occurred while updating the work entry",
    });
  }
};

// delete work entry
const deleteWorkEntry = async (req, res) => {
  const { id } = req.params;
  try {
    const deleteWorkEntry = await prisma.workEntry.delete({
      where: { id: id },
    });
    return res
      .status(200)
      .json({ status: 200, message: "Work Entry Deleted Successfully!" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: 500,
      message: "An error occurred while deleting the work entry",
    });
  }
};

// get by id work entry
const getWorkEntryById = async (req, res) => {
  const { id } = req.params;
  try {
    const getWorkEntryById = await prisma.workEntry.findUnique({
      where: { id: id },
    });
    return res.status(200).json({
      status: 200,
      message: "Work Entry Data!",
      data: getWorkEntryById,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: 500,
      message: "An error occurred while fetching work entry data",
    });
  }
};

module.exports = {
  addWorkEntry,
  getAllWorkEntry,
  updateWorkEntry,
  deleteWorkEntry,
  getWorkEntryById,
};
