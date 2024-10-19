const { PrismaClient } = require("@prisma/client");
const { staffSchema } = require("../../../utils/validations");
const { ZodError } = require("zod");
const prisma = new PrismaClient();

const createStaff = async (req, res) => {
  const validation = staffSchema.safeParse(req.body);
  if (Object.keys(req.body).length === 0) {
    return res.status(400).json({ error: "Request body is empty" });
  }
  // const validation = req.body

  if (!validation.success) {
    return res.status(400).json({
      error: "Invalid data format",
      // issues: validation.error.format(),
    });
  }

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
    date_of_birth,
    current_address,
    permanent_address,
    emergency_contact_name,
    emergency_contact_mobile,
    emergency_contact_relation,
    emergency_contact_address,
  } = validation.data;
  console.log(validation)
  try {
    const staff = await prisma.staff.create({
      data: {
        name,
        job_title,
        branch,
        departmentId,
        roleId,
        mobile,
        login_otp,
        gender,
        official_email,
        date_of_joining: date_of_joining ? new Date(date_of_joining) : null,
        date_of_birth: date_of_birth ? new Date(date_of_birth) : null,
        current_address,
        permanent_address,
        emergency_contact_name,
        emergency_contact_mobile,
        emergency_contact_relation,
        emergency_contact_address,
      },
    });
    res.status(201).json(staff);
  } catch (error) {
    console.log(error);
    res.status(500).json({
      error: "Failed to create staff member",
      details: error.message,
    });
  }
};


const updateStaff = async (req, res) => {
  const { id } = req.params;

  const validation = staffSchema.partial().safeParse(req.body);

  if (!validation.success) {
    return res.status(400).json({
      error: "Invalid data format",
      issues: validation.error.format(),
    });
  }

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
    date_of_birth,
    current_address,
    permanent_address,
    emergency_contact_name,
    emergency_contact_mobile,
    emergency_contact_relation,
    emergency_contact_address,
  } = validation.data;

  try {
    const updatedStaff = await prisma.staff.update({
      where: { id },
      data: {
        name,
        job_title,
        branch,
        departmentId,
        roleId,
        mobile,
        login_otp,
        gender,
        official_email,
        date_of_joining: date_of_joining ? new Date(date_of_joining) : null,
        date_of_birth: date_of_birth ? new Date(date_of_birth) : null,
        current_address,
        permanent_address,
        emergency_contact_name,
        emergency_contact_mobile,
        emergency_contact_relation,
        emergency_contact_address,
      },
    });
    res.status(200).json(updatedStaff);
  } catch (error) {
    res.status(500).json({
      error: "Failed to update staff member",
      details: error.message,
    });
  }
};

const getAllStaff = async (req, res) => {
  try {
    const staff = await prisma.staff.findMany({
      include: {
        department: true,
        role: true,
        verifications: true,
        BankDetails: true,
        LeaveBalance: true,
        LeavePolicy: true,
        FixedShift: true,
        FlexibleShift: true,
        panaltyOvertimeDetailId: true,
        PunchIn: true,
        PunchOut: true,
        SalaryDetails: true,
      },
    });
    res.status(200).json(staff);
  } catch (error) {
    res.status(500).json({
      error: "Failed to fetch staff members",
      details: error.message,
    });
  }
};

const getStaffById = async (req, res) => {
  const { id } = req.params;

  try {
    const staff = await prisma.staff.findUnique({
      where: { id },
    });
    if (staff) {
      res.status(200).json(staff);
    } else {
      res.status(404).json({ error: "Staff member not found" });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({
      error: "Failed to fetch staff member",
      details: error.message,
    });
  }
};

const deleteStaff = async (req, res) => {
  const { id } = req.params;
  try {
    await prisma.staff.delete({
      where: { id },
    });
    res.status(204).json({ message: "Staff member disabled" });
  } catch (error) {
    res.status(500).json({
      error: "Failed to disable staff member",
      details: error.message,
    });
  }
};

module.exports = {
  createStaff,
  getAllStaff,
  getStaffById,
  updateStaff,
  deleteStaff,
};
