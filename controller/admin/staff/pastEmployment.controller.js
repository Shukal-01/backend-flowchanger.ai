const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

// Create Past Employment
const createPastEmployment = async (req, res) => {
  const {
    staffId,
    company_name,
    designation,
    joining_date,
    leaving_date,
    currency,
    salary,
    company_gst,
  } = req.body;

  try {
    const newEmployment = await prisma.pastEmployment.create({
      data: {
        staffId,
        company_name,
        designation,
        joining_date: joining_date,
        leaving_date: leaving_date,
        currency,
        salary: parseFloat(salary),
        company_gst,
      },
    });
    res.status(201).json(
      newEmployment,
    );
  } catch (error) {
    console.error("Error creating past employment:", error);
    res.status(500).json({
      message: "Failed to create past employment",
      error: error.message,
    });
  }
};

// Read All Past Employment Records
const getAllPastEmployment = async (req, res) => {
  try {
    const employments = await prisma.pastEmployment.findMany();
    res.status(200).json(employments);
  } catch (error) {
    console.error("Error fetching past employment records:", error);
    res.status(500).json({
      message: "Failed to fetch past employment records",
      error: error.message,
    });
  }
};

// Read Past Employment by ID
const getPastEmploymentById = async (req, res) => {
  const { id } = req.params;

  try {
    const employment = await prisma.pastEmployment.findUnique({
      where: { staffId: id },
    });

    if (employment) {
      res.status(200).json(employment);
    } else {
      res.status(404).json({ message: "Past employment not found" });
    }
  } catch (error) {
    console.error("Error fetching past employment by ID:", error);
    res.status(500).json({
      message: "Failed to fetch past employment by ID",
      error: error.message,
    });
  }
};

// Update Past Employment by ID
const updatePastEmployment = async (req, res) => {
  const { id } = req.params;
  const {
    company_name,
    designation,
    joining_date,
    leaving_date,
    currency,
    salary,
    company_gst,
  } = req.body;

  try {
    const updatedEmployment = await prisma.pastEmployment.update({
      where: { staffId: id },
      data: {
        company_name,
        designation,
        joining_date: joining_date,
        leaving_date: leaving_date,
        currency,
        salary: parseFloat(salary),
        company_gst,
      },
    });
    res.status(200).json(
      updatedEmployment,
    );
  } catch (error) {
    console.error("Error updating past employment:", error);
    res.status(500).json({
      message: "Failed to update past employment",
      error: error.message,
    });
  }
};

// Delete Past Employment by ID
const deletePastEmployment = async (req, res) => {
  const { id } = req.params;

  try {
    const deleteEmployment = await prisma.pastEmployment.delete({
      where: { id: id },
    });
    res.status(200).json("Past employment deleted successfully");
  } catch (error) {
    console.error("Error deleting past employment:", error);
    res.status(500).json({
      message: "Failed to delete past employment",
      error: error.message,
    });
  }
};

module.exports = {
  createPastEmployment,
  getAllPastEmployment,
  getPastEmploymentById,
  updatePastEmployment,
  deletePastEmployment,
};