const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const allStaffAttendanceByDate = async (req, res) => {
  try {
    const { type, date } = req.query;

    if (type === "day") {
      const [day, month, year] = date.split("/").map(Number);
      const requestedDate = new Date(year, month - 1, day);
      const startOfDay = new Date(requestedDate.setHours(0, 0, 0, 0));
      const endOfDay = new Date(startOfDay.getTime() + 86400000);

      // Get the current date to ensure no future dates are handled
      const currentDate = new Date();
      currentDate.setHours(0, 0, 0, 0); // Reset time for comparison

      // Check if requested date is in the future
      if (requestedDate > currentDate) {
        return res.status(400).json({
          message: `The requested date (${day}/${month}/${year}) is a future date. No entries are available for future dates.`,
        });
      }

      // Fetch all staff details
      const staffList = await prisma.staffDetails.findMany({
        select: {
          id: true,
          date_of_joining: true,
        },
      });

      const eligibleStaff = staffList.filter((staff) => {
        const joiningDate = new Date(staff.date_of_joining);
        return requestedDate >= joiningDate; // Only include staff who joined on or before the requested date
      });

      // If no eligible staff, return appropriate message
      if (eligibleStaff.length === 0) {
        return res.status(404).json({
          message: `No staff available for the requested date (${day}/${month}/${year}) as all have joining dates after this date.`,
        });
      }

      const records = [];

      for (const staff of eligibleStaff) {
        const { id, date_of_joining } = staff;
        const joiningDate = new Date(date_of_joining);

        // Check if the requested date is before the staff's date of joining
        if (requestedDate < joiningDate) {
          return res.status(400).json({
            message: `The requested date (${day}/${month}/${year}) is before the joining date of staff ID ${id}. No entry will be created.`,
          });
        }

        // Check for existing punch record for the staff on the requested date
        let punchRecord = await prisma.punchRecords.findFirst({
          where: {
            staffId: id,
            punchDate: {
              gte: startOfDay,
              lt: endOfDay,
            },
          },
          include: {
            punchIn: true,
            punchOut: true,
            fine: true,
            Overtime: true,
            endBreak: true,
            startBreak: true,
            staff: {
              include: {
                User: true,
              },
            },
          },
        });

        // If no record exists, create one
        if (!punchRecord) {
          punchRecord = await prisma.punchRecords.create({
            data: {
              staff: {
                connect: {
                  id: id,
                },
              },
              punchDate: startOfDay,
              status: "ABSENT",
            },
          });
        }

        records.push({
          staffId: id,
          punchRecord,
        });
      }

      return res.status(200).json({
        message: `Punch records fetched successfully for the requested date (${day}/${month}/${year}).`,
        records,
      });
    } else {
      return res
        .status(400)
        .json({ message: "Invalid type. Only 'day' is supported." });
    }
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ message: "Failed to fetch staff punch records." });
  }
};

// single staff Attendance get

const getSingleStaffAttendance = async (req, res) => {
  try {
    const { id } = req.params;
    const { type, date } = req.query;

    const staff = await prisma.staffDetails.findFirst({
      where: { id: id },
      select: {
        id: true,
        date_of_joining: true,
      },
    });

    const { date_of_joining } = staff;
    let records = [];
    let entryCount = 0;
    let createdCount = 0;

    const indiaTime = new Date().toLocaleString("en-US", {
      timeZone: "Asia/Kolkata",
    });
    let indianTime = new Date(indiaTime);

    const currentDate = new Date(indianTime);

    // Get the current date to check for future date
    // const currentDate = new Date();
    currentDate.setHours(0, 0, 0, 0); // Reset time for comparison

    if (type === "day") {
      const [day, month, year] = date.split("/").map(Number);
      const requestedDate = new Date(year, month - 1, day); // Parse requested date

      // Check if requested date is in the future
      if (requestedDate > currentDate) {
        return res.status(400).json({
          message: `The requested date is a future date. No entries are available for future dates.`,
        });
      }

      const startDate = new Date(date_of_joining); // Staff's date of joining
      if (requestedDate < startDate) {
        return res.status(400).json({
          message: `The requested date is before the joining date of staff ID. No entry will be created.`,
        });
      }

      const startOfDay = new Date(requestedDate.setHours(0, 0, 0, 0)); // Start of requested date
      const endOfDay = new Date(startOfDay.getTime() + 86400000); // End of requested date

      // Find punch record for the requested date along with punchIn and punchOut details
      let punchRecord = await prisma.punchRecords.findFirst({
        where: {
          staffId: id,
          punchDate: {
            gte: startOfDay,
            lt: endOfDay,
          },
        },
        include: {
          fine: true,
          Overtime: true,
          punchIn: true,
          punchOut: true,
          // endBreak: true,
          // startBreak: true,
          breakRecord: true,
          staff: {
            include: {
              User: true,
            },
          },
        },
      });

      if (!punchRecord) {
        // Create a new record if it doesn't exist
        punchRecord = await prisma.punchRecords.create({
          data: {
            staff: {
              connect: {
                id: id,
              },
            },
            punchDate: startOfDay,
            status: "ABSENT",
          },
        });
        createdCount++;
        return res.status(200).json({
          message: "Attendance record fetched successfully",
          attendanceRecord: punchRecord,
        });
      } else {
        return res.status(200).json({
          message:
            "Attendance record fetched successfully for the requested date.",
          attendanceRecord: punchRecord,
        });
      }
    } else if (type === "month") {
      const [month, year] = date.split("/").map(Number);
      const startMonth = new Date(year, month - 1, 1);
      const endMonth = new Date(year, month, 0);
      const startDate = new Date(date_of_joining);

      // Check if the requested month is in the future
      if (startMonth > currentDate) {
        return res.status(400).json({
          message: `The requested month is in the future. No entries are available for future months.`,
        });
      }

      // Check if the requested month is before the joining month
      if (
        startMonth < new Date(startDate.getFullYear(), startDate.getMonth(), 1)
      ) {
        return res.status(400).json({
          message: `This month data not found as it is before the staff joining date.`,
        });
      }

      const records = [];

      // Loop through each day in the requested month
      for (let day = 1; day <= endMonth.getDate(); day++) {
        const currentDay = new Date(year, month - 1, day);

        // Skip dates before the joining date
        if (currentDay < startDate) continue;

        // Skip future dates
        if (currentDay > currentDate) continue;

        // Fetch punch record for the current day
        const punchRecord = await prisma.punchRecords.findFirst({
          where: {
            staffId: id,
            punchDate: {
              gte: currentDay,
              lt: new Date(currentDay.getTime() + 86400000),
            },
          },
          include: {
            fine: true,
            Overtime: true,
            punchIn: true,
            punchOut: true,
            endBreak: true,
            startBreak: true,
            breakRecord: true,
            staff: {
              include: {
                User: true,
              },
            },
          },
        });

        if (punchRecord) {
          // Add existing record with all relational data
          records.push(punchRecord);
        } else {
          // Create a new record if none exists
          const newPunchRecord = await prisma.punchRecords.create({
            data: {
              staff: { connect: { id } },
              punchDate: currentDay,
              status: "ABSENT",
            },
          });
          records.push(newPunchRecord);
        }
      }

      // Send the response with all relational data included
      return res.status(200).json({
        message: `Attendance records for the month fetched successfully.`,
        attendanceRecords: records,
      });
    }
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ message: "Attendance not fetched", error: error.message });
  }
};

const updatePunchRecordStatus = async (req, res) => {
  const { id } = req.params;
  const { status, shiftId, startTime, endTime } = req.body;

  const validStatuses = ["ABSENT", "PRESENT", "HALFDAY", "PAIDLEAVE"];

  if (!validStatuses.includes(status)) {
    return res.status(400).json({
      error:
        "Invalid status. Valid statuses are ABSENT, PRESENT, HALFDAY, PAIDLEAVE.",
    });
  }

  try {
    if (status === "PRESENT") {
      const punchRecord = await prisma.punchRecords.findUnique({
        where: { id },
        include: {
          punchIn: true,
          punchOut: true,
        },
      });
      if (punchRecord.punchIn) {
        const punchIn = await prisma.punchIn.update({
          where: { id: punchRecord.punchIn.id },
          data: {
            punchInTime: startTime,
            punchInDate: startTime,
          },
        });
      } else {
        await prisma.punchRecords.update({
          data: {
            punchIn: {
              create: {
                punchInTime: startTime,
                punchInDate: startTime,
              },
            },
          },
        });
      }
      if (punchRecord.punchOut) {
        const punchOut = await prisma.punchOut.update({
          where: { id: punchRecord.punchOut.id },
          data: {
            punchOutTime: endTime,
            punchOutDate: endTime,
          },
        });
      } else {
        await prisma.punchRecords.update({
          data: {
            punchOut: {
              create: {
                punchInTime: startTime,
                punchInDate: startTime,
              },
            },
          },
        });
      }
      return res.status(200).json({
        message: "Punch record status updated successfully",
        updatedPunchRecord,
      });
    }
    const updatedPunchRecord = await prisma.punchRecords.update({
      where: { id },
      data: { status: status, isApproved: true },
    });

    res.status(200).json({
      message: "Punch record status updated successfully",
      updatedPunchRecord,
    });
  } catch (error) {
    console.error("Error updating punch record:", error);
    res.status(500).json({ error: "Failed to update punch record status" });
  }
};

// get breakRecord data by staffId and date/month/year
const getBreakRecordByStaffId = async (req, res) => {
  try {
    const { staffId } = req.params; // Get the staffId from URL parameters
    const { date } = req.query; // Get the date (format: 21/11/2024) from query parameters

    if (!date) {
      return res
        .status(400)
        .json({ error: "Date is required in format DD/MM/YYYY" });
    }

    // Parse the input date string
    const [day, month, year] = date.split("/");

    // Start of the day in IST
    const startOfDayIST = new Date(`${year}-${month}-${day}T00:00:00`);
    const indiaStartTime = new Date(
      startOfDayIST.toLocaleString("en-US", { timeZone: "Asia/Kolkata" })
    );

    // End of the day in IST
    const endOfDayIST = new Date(`${year}-${month}-${day}T23:59:59`);
    const indiaEndTime = new Date(
      endOfDayIST.toLocaleString("en-US", { timeZone: "Asia/Kolkata" })
    );

    // Fetch all startBreaks for the given staffId and date
    const startBreaks = await prisma.startBreak.findMany({
      where: {
        staffId: staffId,
        startBreakTime: {
          gte: indiaStartTime, // Start of the day in IST
          lte: indiaEndTime, // End of the day in IST
        },
      },
      orderBy: { startBreakTime: "desc" }, // Sort by latest startBreakTime
    });

    if (startBreaks.length === 0) {
      return res.status(404).json({
        message: "No break records found for this staff ID on the given date",
      });
    }

    // Fetch corresponding endBreaks and merge them
    const breakRecords = await Promise.all(
      startBreaks.map(async (startBreak) => {
        // Find the corresponding endBreak for this startBreak
        const endBreak = await prisma.endBreak.findFirst({
          where: {
            staffId: staffId,
            endBreakTime: {
              gte: startBreak.startBreakTime, // Must be after or equal to the startBreak time
              lte: indiaEndTime, // Ensure it's within the same day
            },
          },
          orderBy: { endBreakTime: "asc" }, // Get the earliest matching endBreak
        });

        // Combine startBreak and endBreak into a single object
        return {
          breakDate: new Date(startBreak.startBreakTime).toLocaleString(
            "en-IN",
            {
              timeZone: "Asia/Kolkata",
              year: "numeric",
              month: "2-digit",
              day: "2-digit",
            }
          ),
          startBreak: {
            ...startBreak,
            startBreakTime: new Date(startBreak.startBreakTime).toLocaleString(
              "en-IN",
              {
                timeZone: "Asia/Kolkata",
                hour: "2-digit",
                minute: "2-digit",
                second: "2-digit",
              }
            ),
          },
          endBreak: endBreak
            ? {
                ...endBreak,
                endBreakTime: new Date(endBreak.endBreakTime).toLocaleString(
                  "en-IN",
                  {
                    timeZone: "Asia/Kolkata",
                    hour: "2-digit",
                    minute: "2-digit",
                    second: "2-digit",
                  }
                ),
              }
            : null, // If no endBreak, keep it null
        };
      })
    );

    // Return the combined break records as a response
    return res.status(200).json({
      message: `Break Records for ${date}`,
      breakRecords,
    });
  } catch (error) {
    console.error("Error fetching break records:", error);

    // Return an error response for any issues during the process
    return res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = {
  allStaffAttendanceByDate,
  updatePunchRecordStatus,
  getSingleStaffAttendance,
  getBreakRecordByStaffId,
};
