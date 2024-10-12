const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

// Create a new staff member
const createStaff = async (req, res) => {
  const {
    name,
    job_title,
    branch,
    departmentId,
    roleId,
    mobile,
    login_otp,
    gender,
    official_email,
    date_of_joining,
    address,
  } = req.body;

  try {
    const staff = await prisma.staff.create({
      data: {
        name,
        job_title,
        branch,
        departmentId, // This needs to be an existing department's ID
        roleId, // This needs to be an existing role's ID
        mobile,
        login_otp,
        gender,
        official_email,
        date_of_joining: new Date(date_of_joining), // Converts date string to Date
        address,
      },
    });
    res.status(201).json(staff);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to create staff member", details: error.message });
  }
};

// Get all staff members
const getAllStaff = async (req, res) => {
  try {
    const staff = await prisma.staff.findMany({
      include: {
        department: true, // Include department details in the response
        role: true, // Include role details in the response
      },
    });
    res.status(200).json(staff);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to fetch staff members", details: error.message });
  }
};

// Get a single staff member by UUID
const getStaffById = async (req, res) => {
  const { id } = req.params;
  try {
    const staff = await prisma.staff.findUnique({
      where: { id },
      include: {
        department: true, // Include department details in the response
        role: true, // Include role details in the response
      },
    });
    if (staff) {
      res.status(200).json(staff);
    } else {
      res.status(404).json({ error: "Staff member not found" });
    }
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to fetch staff member", details: error.message });
  }
};

// Update a staff member
const updateStaff = async (req, res) => {
  const { id } = req.params;
  const {
    name,
    job_title,
    branch,
    departmentId,
    roleId,
    mobile,
    login_otp,
    gender,
    official_email,
    date_of_joining,
    address,
  } = req.body;

  try {
    const updatedStaff = await prisma.staff.update({
      where: { id },
      data: {
        name,
        job_title,
        branch,
        departmentId, // Update department reference
        roleId, // Update role reference
        mobile,
        login_otp,
        gender,
        official_email,
        date_of_joining: new Date(date_of_joining), // Convert date string to Date
        address,
      },
    });
    res.status(200).json(updatedStaff);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to update staff member", details: error.message });
  }
};

// Delete a staff member
const deleteStaff = async (req, res) => {
  const { id } = req.params;
  try {
    await prisma.staff.delete({
      where: { id },
    });
    res.status(204).json({ message: "Staff member deleted" });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to delete staff member", details: error.message });
  }
};

module.exports = {
  createStaff,
  getAllStaff,
  getStaffById,
  updateStaff,
  deleteStaff,
};
