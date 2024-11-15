const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const PunchInSchema = require("../../utils/validations").PunchInSchema;
const { ZodError } = require("zod");
const {
  PunchOutSchema,
  PunchRecordsSchema,
} = require("../../utils/validations");
const { connect } = require("../../router/chat.router");

async function createPunchIn(req, res) {
  try {
    const { punchInMethod, biometricData, qrCodeValue, location } = req.body;

    const photoUrl = req.imageUrl ?? "null";

    console.log(photoUrl);

    const user = await prisma.user.findFirst({
      where: { id: req.userId, role: "STAFF" },
      include: { staffDetails: true },
    });

    if (!user) {
      return res.status(404).send("user not found");
    }

    PunchInSchema.parse({
      punchInMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
      location,
    });

    let punchInData = { punchInMethod, location };

    if (punchInMethod === "PHOTOCLICK") {
      punchInData = { ...punchInData, photoUrl };
    } else if (punchInMethod === "QRSCAN") {
      punchInData = { ...punchInData, qrCodeValue };
    } else if (punchInMethod === "BIOMETRIC") {
      punchInData = { ...punchInData, biometricData };
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const existingPunchIn = await prisma.punchIn.findFirst({
      where: {
        punchInDate: {
          gte: today,
          lt: new Date(today.getTime() + 86400000),
        },
      },
    });

    if (existingPunchIn) {
      return res
        .status(400)
        .json({ error: "Punch-in record already exists for today." });
    }

    const standardStartTime = new Date();
    standardStartTime.setHours(10, 0, 0, 0);

    const currentPunchInTime = new Date();

    const latenessMinutes = Math.max(
      0,
      Math.floor((currentPunchInTime - standardStartTime) / (1000 * 60))
    );

    const hoursLate = Math.floor(latenessMinutes / 60);
    const minutesLate = latenessMinutes % 60;

    let fine;
    if (latenessMinutes > 0) {
      fine = `${hoursLate > 0 ? hoursLate : ""} hours : ${minutesLate} minutes`;
    } else {
      fine = "On time";
    }

    punchInData = { ...punchInData, punchInTime: currentPunchInTime };

    const punchIn = await prisma.punchIn.create({
      data: {
        punchInMethod: punchInMethod || "PHOTOCLICK",
        ...punchInData,
        location,
        fine: fine,
      },
    });

    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);

    const existingPunchRecord = await prisma.punchRecords.findFirst({
      where: {
        staffId: user.staffDetails.id,
        punchDate: {
          gte: today,
          lt: tomorrow,
        },
      },
    });

    if (existingPunchRecord) {
      const updatedPunchRecord = await prisma.punchRecords.update({
        where: {
          id: existingPunchRecord.id,
        },
        data: {
          punchIn: {
            connect: { id: punchIn.id },
          },
          status: "PRESENT",
        },
      });
    } else {
      const punchRecords = await prisma.punchRecords.create({
        data: {
          punchIn: {
            connect: { id: punchIn.id },
          },
          staff: {
            connect: { id: user.staffDetails.id },
          },
          status: "PRESENT",
        },
      });
    }

    return res.status(201).json(punchIn);
  } catch (error) {
    console.log(error);
    if (error instanceof ZodError) {
      return res.status(400).json({ errors: error.errors });
    }

    return res.status(500).json({ error: "Internal Server Error" });
  }
}

async function getAllPunchIn(req, res) {
  try {
    const records = await prisma.punchIn.findMany();
    return res.status(200).json(records);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ error: "Failed to retrieve punch-in records" });
  }
}

async function createPunchOut(req, res) {
  try {
    const { punchOutMethod, biometricData, qrCodeValue, location } = req.body;
    const user = await prisma.user.findFirst({
      where: { id: req.userId, role: "STAFF" },
      include: { staffDetails: true },
    });

    if (!user) {
      return res.status(404).send("User not found");
    }
    const photoUrl = req.imageUrl ? req.imageUrl : "null";

    PunchOutSchema.parse({
      punchOutMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
      location,
    });

    let punchOutData = { punchOutMethod, location };

    if (punchOutMethod === "PHOTOCLICK") {
      punchOutData = { ...punchOutData, photoUrl };
    } else if (punchOutMethod === "QRSCAN") {
      punchOutData = { ...punchOutData, qrCodeValue };
    } else if (punchOutMethod === "BIOMETRIC") {
      punchOutData = { ...punchOutData, biometricData };
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);

    const punchRecord = await prisma.punchRecords.findFirst({
      where: {
        staffId: user.staffDetails.id,
        punchDate: {
          gte: today,
          lt: tomorrow,
        },
      },
    });

    if (!punchRecord || !punchRecord.punchInId) {
      return res
        .status(400)
        .json({ error: "No punch-in record found for today." });
    }

    if (punchRecord.punchOutId) {
      return res
        .status(400)
        .json({ error: "Punch-out record already exists for today." });
    }

    const standardStartTime = new Date();
    standardStartTime.setHours(10, 0, 0, 0);

    const standardEndTime = new Date();
    standardEndTime.setHours(18, 30, 0, 0);

    const currentPunchOutTime = new Date();
    const punchInTime = new Date(punchRecord.punchInId.punchInTime);

    let overtimeBefore = 0;
    if (punchInTime < standardStartTime) {
      overtimeBefore = Math.floor(
        (standardStartTime - punchInTime) / (1000 * 60)
      );
    }

    let overtimeAfter = 0;
    if (currentPunchOutTime > standardEndTime) {
      overtimeAfter = Math.floor(
        (currentPunchOutTime - standardEndTime) / (1000 * 60)
      );
    }

    const totalOvertimeMinutes = overtimeBefore + overtimeAfter;

    const hoursOvertime = Math.floor(totalOvertimeMinutes / 60);
    const minutesOvertime = totalOvertimeMinutes % 60;
    const overtime =
      totalOvertimeMinutes > 0
        ? `${hoursOvertime} : ${minutesOvertime}`
        : "No overtime";

    punchOutData = {
      ...punchOutData,
      punchOutTime: currentPunchOutTime,
      overtime,
    };

    const punchOut = await prisma.punchOut.create({
      data: {
        punchOutMethod: punchOutMethod || "PHOTOCLICK",
        ...punchOutData,
        location,
        overtime,
        photoUrl,
      },
    });

    const updatedPunchRecord = await prisma.punchRecords.update({
      where: {
        id: punchRecord.id,
      },
      data: {
        punchOut: {
          connect: { id: punchOut.id },
        },
      },
    });

    return res.status(201).json({ updatedPunchRecord, punchOut });
  } catch (error) {
    console.error(error);
    if (error instanceof ZodError) {
      return res.status(400).json({ errors: error.errors });
    }

    return res.status(500).json({ error: "Internal Server Error" });
  }
}

async function getAllPunchOut(req, res) {
  try {
    const records = await prisma.punchOut.findMany();
    return res.status(200).json(records);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ error: "Failed to retrieve punch-out records" });
  }
}

async function getPunchRecordById(req, res) {
  try {
    const { staffId } = req.params;
    const punchRecords = await prisma.punchRecords.findMany({
      where: { staffId },
    });
    res.status(200).json(punchRecords);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch punch-in" });
  }
}

async function getPunchRecords(req, res) {
  try {
    const { month, year } = req.query; // Month and Year are passed as query params

    // Initialize the date range filter
    let filter = {};

    // If both month and year are provided, apply the date range filter
    if (month && year) {
      const startDate = new Date(year, month - 1, 1); // Start of the month
      const endDate = new Date(year, month, 0); // End of the month

      filter.punchDate = {
        gte: startDate,
        lt: endDate,
      };
    }

    // Fetch the punch records based on the filter
    const punchRecords = await prisma.punchRecords.findMany({
      where: filter,
      include: {
        punchIn: true,
        punchOut: true,
        staff: true, // Include staff details
      },
    });

    // If no records are found, return a message
    if (punchRecords.length === 0) {
      return res.status(200).json({
        message:
          month && year
            ? `No punch records found for ${month}-${year}.`
            : "No punch records found.",
      });
    }

    // Calculate the totals for each status
    let totalLeave = 0;
    let totalPresent = 0;
    let totalAbsent = 0;
    let totalHalfDay = 0;

    // Iterate over punch records to calculate the totals
    punchRecords.forEach((record) => {
      switch (record.status) {
        case "LEAVE":
          totalLeave++;
          break;
        case "PRESENT":
          totalPresent++;
          break;
        case "ABSENT":
          totalAbsent++;
          break;
        case "HALF_DAY":
          totalHalfDay++;
          break;
        default:
          break;
      }
    });

    // Return the calculated results along with the punch records
    return res.status(200).json({
      status: 200,
      message: `Punch records${month && year ? ` for ${month}-${year}` : ""}`,
      data: punchRecords,
      totals: {
        totalLeave,
        totalPresent,
        totalAbsent,
        totalHalfDay,
      },
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch punch records" });
  }
}

module.exports = {
  createPunchIn,
  getAllPunchIn,
  createPunchOut,
  getAllPunchOut,
  getPunchRecords,
  getPunchRecordById,
};
