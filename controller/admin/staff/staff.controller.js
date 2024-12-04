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
    departmentId,
    branchId,
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
    status,
    employment,
  } = validation.data;

  try {
    const existingEmail = await prisma.user.findUnique({
      where: {
        email: official_email, // Check if email exists
      },
    });

    if (existingEmail) {
      // If email exists, return an error response
      return res.status(400).json({
        message: "Email already exists!",
      });
    }
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
            departmentId,
            branchId,
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
            status,
            employment,
          },
        },
      },
    });

    res.status(201).json({ message: "Staff created successfully!", user });
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
    departmentId,
    branchId,
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
    status,
    employment,
  } = validation.data;

  try {
    const existingUser = await prisma.user.findFirst({
      where: {
        OR: [
          { email: official_email }, // Check for email
          { mobile: mobile }, // Check for mobile
        ],
      },
    });

    if (existingUser && existingUser.id !== id) {
      // If an email exists
      if (existingUser.email === official_email) {
        return res.status(400).json({
          message: "Email already exists!",
        });
      }

      // If a mobile exists
      if (existingUser.mobile === mobile) {
        return res.status(400).json({
          message: "Mobile already exists!",
        });
      }
    }
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
        branchId,
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
        status,
        employment,
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
            branch: true,
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
            projects: true,
            TaskDetail: true,
            // TaskStatus: true,
            past_Employment: true,
            Fine: true,
            Overtime: true,
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
    const staff = await prisma.user.findFirst({
      where: {
        id: req.userId,
      },
      include: {
        staffDetails: {
          include: {
            branch: true,
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
            projects: true,
            TaskDetail: true,
            // TaskStatus: true,
            past_Employment: true,
          },
        },
      },
    });
    if (staff) {
      res.status(200).json(staff);
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
      where: { userId: id },
    });
    res.status(201).json({ message: "Staff member deleted successfully" });
  } catch (error) {
    res.status(500).json({
      error: "Failed to delete staff member",
      details: error.message,
    });
  }
};

// Search staff by name department and date
const searchStaffByName = async (req, res) => {
  try {
    const { name, department_name, date_of_joining } = req.query;

    const searchStaff = await prisma.user.findMany({
      where: {
        role: "STAFF",
        name: name
          ? {
              contains: name,
              mode: "insensitive",
            }
          : undefined,
        staffDetails: {
          department: department_name
            ? {
                department_name: {
                  contains: department_name,
                  mode: "insensitive",
                },
              }
            : undefined,
          date_of_joining: date_of_joining
            ? new Date(date_of_joining)
            : undefined,
        },
      },
      include: {
        staffDetails: {
          include: {
            department: true,
          },
        },
      },
    });

    return res.status(200).json(searchStaff);
  } catch (error) {
    console.error("Error fetching staff members:", error);
    return res
      .status(500)
      .json({ message: "Failed to search staff members" + error.message });
  }
};

// Search staff by status gender employment
const searchStaffByStatus = async (req, res) => {
  const { status, gender, employment } = req.query;
  try {
    // Filter criteria object
    const whereDataArray = {};

    if (status) {
      whereDataArray.status = {
        contains: status,
        mode: "insensitive",
      };
    }

    if (gender) {
      whereDataArray.gender = {
        contains: gender,
        mode: "insensitive",
      };
    }

    if (employment) {
      whereDataArray.employment = {
        contains: employment,
        mode: "insensitive",
      };
    }

    // Fetch data based on filtered criteria
    const filteredData = await prisma.staffDetails.findMany({
      where: whereDataArray,
    });

    return res.status(200).json(filteredData);
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      status: false,
      message: "Failed to search staff members" + error.message,
    });
  }
};
module.exports = {
  createStaff,
  getAllStaff,
  getStaffById,
  updateStaff,
  searchStaffByName,
  deleteStaff,
  searchStaffByStatus,
};
