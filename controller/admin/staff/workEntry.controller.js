const { PrismaClient } = require("@prisma/client");
const { workEntrySchema } = require("../../../utils/validations.js");
const prisma = new PrismaClient();

// Add Work Entry Query
const addWorkEntry = async (req, res) => {
  try {
    const { work_name, units, description } = req.body;

    const location = req.body.location ? req.body.location : "null";

    const user = await prisma.user.findFirst({
      where: { id: req.userId, role: "STAFF" },
      include: { staffDetails: true },
    });
    if (!user) {
      return res.status(404).send("user not found");
    }

    const attachments = req.imageUrl || "null";

    const validation = workEntrySchema.safeParse({
      staffDetailsId: user.staffDetails.id,
      work_name,
      units,
      description,
      location,
      attachments,
    });
    console.log(validation);
    if (validation.error) {
      return res.status(400).json({
        status: 400,
        msg: "Invalid request data",
        errors: validation.error.issues.map((issue) => issue.message),
      });
    }

    // Get today's date (set time to midnight)
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    // Check if a work entry already exists for today
    const existingEntry = await prisma.workEntry.findFirst({
      where: {
        staffDetailsId: validation.data.staffDetailsId,
        createdAt: {
          gte: today, // Start of today
          lt: new Date(today.getTime() + 86400000), // Start of tomorrow
        },
      },
    });

    if (existingEntry) {
      return res.json({
        message: "You cannot create more than one entry per day.",
      });
    }

    // Create new work entry if no existing entry found for today
    const newWorkEntry = await prisma.workEntry.create({
      data: validation.data,
    });
    console.log(newWorkEntry);
    return res.status(201).json({
      status: 201,
      message: "Work Entry Created Successfully!",
      newWorkEntry
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "Internal Server Error!" });
  }
};


const getAllWorkEntry = async (req, res) => {
  try {
    const getAllWorkEntry = await prisma.workEntry.findMany({
      where: {
        staffDetailsId: req.params.id,
      },
    });
    return res.status(200).json({
      status: 200,
      message: "All Work Entry Data!",
      data: getAllWorkEntry,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "Internal Server Error" });
  }
};

const updateWorkEntry = async (req, res) => {
  const { id } = req.params;
  const { work_name, units, description, location } = req.body;
  const attachments = req.imageUrl;
  try {
    const updateWorkEntry = await prisma.workEntry.update({
      where: { id: id },
      data: {
        work_name: work_name,
        units: units,
        description: description,
        location: location,
        attachments: attachments,
      },
    });
    return res.status(200).json({
      status: 200,
      message: "Work Entry Updated Successfully!",
      data: updateWorkEntry,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "Internal Server Error" });
  }
};

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
    return res
      .status(500)
      .json({ status: 500, message: "Internal Server Error" });
  }
};

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
    return res
      .status(500)
      .json({ status: 500, message: "Internal Server Error" });
  }
};

module.exports = {
  addWorkEntry,
  getAllWorkEntry,
  updateWorkEntry,
  deleteWorkEntry,
  getWorkEntryById,
};
