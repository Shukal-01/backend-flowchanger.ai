const { PrismaClient } = require("@prisma/client");
const { staffSchema } = require("../../../utils/validations");
const prisma = new PrismaClient();

const createStaff = async (req, res) => {
  const validation = staffSchema.safeParse(req.body);

  if (!validation.success) {
    return res.status(400).json({
      error: "Invalid data format",
      issues: validation.error.format(),
    });
  }

  const {
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
    name,
  } = validation.data;

  try {
    const user = await prisma.user.create({
      data: {
        name,
        mobile,
        role: "STAFF",
        email: official_email,
        otp: parseInt(login_otp),
        staffDetails: {
          create: {
            job_title,
            branch,
            departmentId,
            roleId,
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
        },
      },
    });

    res.status(201).json(user);
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
    name, // Updated field from User model
  } = validation.data;

  try {
    // Update user details if necessary
    await prisma.user.update({
      where: { id: id }, // Assuming the `id` corresponds to the User model
      data: {
        name,
        mobile,
      },
    });

    const updatedStaff = await prisma.staffDetails.update({
      where: { userId: id }, // Assuming userId is used to fetch staff
      data: {
        job_title,
        branch,
        departmentId,
        roleId,
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

async function getAllStaff(req, res) {
  try {
    const staffs = await prisma.user.findMany({
      where: {
        role: "STAFF",
      },
      include: {
        staffDetails: {
          include: {
            department: true,
            role: true,
            BankDetails: true,
            LeavePolicy: true,
            LeaveBalance: true,
            LeaveRequest: true,
            FixedShift: true,
            FlexibleShift: true,
            OverLeavePolicy: true,
            EarlyLeavePolicy: true,
            LateComingPolicy: true,
            SalaryDetails: true,
            PunchRecords: true,
            attendanceAutomationRule: true,
            AttendenceMode: true,
            staff_bg_verification: true,
            CustomDetails: true,
            TicketInformation: true,
            UpiDetails: true,
            WorkEntry: true,
            Earning: true,
            Deduction: true,
          },
        },
      },
    });

    if (staffs) {
      res.status(200).json(staffs);
    } else {
      res.status(404).json({ error: "Staff member not found" });
    }
  } catch (error) {
    res.status(500).json({
      error: "Failed to fetch staff members",
      details: error.message,
    });
  }
}

const getStaffById = async (req, res) => {
  try {
    const staffs = await prisma.user.findMany({
      where: {
        id: req.userId,
      },
      include: {
        staffDetails: {
          include: {
            department: true,
            role: true,
            BankDetails: true,
            LeavePolicy: true,
            LeaveBalance: true,
            LeaveRequest: true,
            FixedShift: true,
            FlexibleShift: true,
            OverLeavePolicy: true,
            EarlyLeavePolicy: true,
            LateComingPolicy: true,
            SalaryDetails: true,
            PunchRecords: true,
            attendanceAutomationRule: true,
            AttendenceMode: true,
            staff_bg_verification: true,
            CustomDetails: true,
            TicketInformation: true,
            UpiDetails: true,
            WorkEntry: true,
            Earning: true,
            Deduction: true,
          },
        },
      },
    });
    if (staffs) {
      res.status(200).json(staffs);
    } else {
      res.status(404).json({ error: "Staff member not found" });
    }
  } catch (error) {
    res.status(500).json({
      error: "Failed to fetch staff member",
      details: error.message,
    });
  }
};

const deleteStaff = async (req, res) => {
  const { id } = req.params;

  try {
    await prisma.staffDetails.delete({
      where: { userId: id }, // Adjusted to use userId
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
