const { PrismaClient } = require("@prisma/client");
const { workEntrySchema } = require("../../../utils/validations.js");
const { get } = require("../../../router/admin/workEntry.router.js");
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


// const getAllWorkEntry = async (req, res) => {
//   try {
//     const { month, year } = req.query;
//     // Build the filter dynamically
//     const filter = {};

//     if (year) {
//       // Set up date range for the year and month if provided
//       filter.createdAt = {
//         gte: new Date(year, month ? month - 1 : 0, 1), // Start of month or start of year
//         lt: month ? new Date(year, month, 1) : new Date(Number(year) + 1, 0, 1), // End of month or end of year
//       };
//     }
//     // Fetch work entries with optional filtering
//     const getAllWorkEntry = await prisma.workEntry.findMany({
//       where: filter,
//       include: {
//         StaffDetails: true // here i also want to include user that is in staff details
//       }
//     });

//     if (getAllWorkEntry.length === 0) {
//       return res.status(200).json({ message: "No work entry found for this month!" });
//     }
//     // Calculate the count of entries for the specific month and year
//     const entryCount = getAllWorkEntry.length;
//     // console.log(entryCount)
//     return res.status(200).json({
//       status: 200,
//       message: "All Work Entry Data!",
//       data: getAllWorkEntry,
//       entryCount: entryCount,
//     });
//   } catch (error) {
//     console.log(error);
//     return res.status(500).json({ status: 500, message: "Internal Server Error" });
//   }
// };

// const getAllWorkEntry = async (req, res) => {
//   try {
//     const { month, year } = req.query;

//     // Fetch the user with the role "STAFF" based on the logged-in user's ID (req.userId)
//     const user = await prisma.user.findFirst({
//       where: { id: req.userId, role: "STAFF" },
//     });

//     if (!user) {
//       return res.status(404).json({ message: "User not found or user is not a staff member!" });
//     }

//     // Build the filter dynamically for date (if year and month are provided)
//     const filter = {};

//     if (year) {
//       filter.createdAt = {
//         gte: new Date(year, month ? month - 1 : 0, 1), // Start of the month or start of the year
//         lt: month ? new Date(year, month, 1) : new Date(Number(year) + 1, 0, 1), // End of the month or end of the year
//       };
//     }

//     // Fetch all work entries and include the related StaffDetails and User
//     const workEntries = await prisma.workEntry.findMany({
//       where: filter,
//       include: {
//         StaffDetails: {
//           include: {
//             User: true, // Include the User details related to the StaffDetails
//           },
//         },
//       },
//     });

//     console.log(workEntries)
//     // Filter the work entries to include only those with matching userId in StaffDetails
//     const filteredWorkEntries = workEntries.filter(workEntry =>
//       workEntry.StaffDetails.some(staffDetail => staffDetail.user.id === user.id)
//     );

//     if (filteredWorkEntries.length === 0) {
//       return res.status(200).json({ message: "No work entry found for this month!" });
//     }

//     // Calculate the count of entries for the specific month and year
//     const entryCount = filteredWorkEntries.length;

//     return res.status(200).json({
//       status: 200,
//       message: "All Work Entry Data!",
//       data: filteredWorkEntries,
//       entryCount: entryCount,
//     });
//   } catch (error) {
//     console.log(error);
//     return res.status(500).json({ status: 500, message: "Internal Server Error" });
//   }
// };


const getAllWorkEntry = async (req, res) => {
  try {
    const { month, year } = req.query;

    // Fetch the user with the role "STAFF" based on the logged-in user's ID (req.userId)
    const user = await prisma.user.findFirst({
      where: { id: req.userId, role: "STAFF" },
    });

    if (!user) {
      return res.status(404).json({ message: "User not found or user is not a staff member!" });
    }

    // Build the filter dynamically for date (if year and month are provided)
    const filter = {};

    if (year) {
      filter.createdAt = {
        gte: new Date(year, month ? month - 1 : 0, 1), // Start of the month or start of the year
        lt: month ? new Date(year, month, 1) : new Date(Number(year) + 1, 0, 1), // End of the month or end of the year
      };
    }

    // Fetch all work entries with relevant StaffDetails and associated User details
    const workEntries = await prisma.workEntry.findMany({
      where: filter,
      include: {
        StaffDetails: {
          include: {
            User: true, // Include related User details for StaffDetails
          },
        },
      },
    });

    // Filter work entries where StaffDetails belong to the logged-in user
    const filteredWorkEntries = workEntries.filter(workEntry =>
      workEntry.staffDetailsId
    );

    if (filteredWorkEntries.length === 0) {
      return res.status(200).json({ message: "No work entry found for this month!" });
    }

    // Calculate the count of entries for the specific month and year
    const entryCount = filteredWorkEntries.length;

    // Simplify the response to remove unnecessary nesting
    const simplifiedWorkEntries = filteredWorkEntries.map(workEntry => {
      const staffDetails = workEntry.StaffDetails; // There's only one matching StaffDetail
      return {
        id: workEntry.id,
        work_name: workEntry.work_name,
        units: workEntry.units,
        description: workEntry.description,
        attachments: workEntry.attachments,
        location: workEntry.location,
        createdAt: workEntry.createdAt,
        staffDetailsId: staffDetails.id,
        job_title: staffDetails.job_title,
        branch: staffDetails.branch,
        userId: staffDetails.userId, // Include relevant User fields here
        user_name: staffDetails.User.name,
        user_email: staffDetails.User.email,
        current_address: staffDetails.current_address,
      };
    });

    return res.status(200).json({
      status: 200,
      message: "All Work Entry Data!",
      data: simplifiedWorkEntries,
      entryCount: entryCount,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: 500, message: "Internal Server Error" });
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
