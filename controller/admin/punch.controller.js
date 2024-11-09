
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const PunchInSchema = require("../../utils/validations").PunchInSchema;
const { ZodError } = require("zod");
const {
  PunchOutSchema,
  PunchRecordsSchema,
} = require("../../utils/validations");

async function createPunchIn(req, res) {
  try {
    const { punchInMethod, biometricData, qrCodeValue, location } = req.body;

    if (punchInMethod === "PHOTOCLICK" && !req.file.cloudinaryUrl) {
      return res.status(400).send("No photo uploaded.");
    }


    // const photoUrl = String(req.file);
    // if (!req.file) {
    //   return res.status(400).send("No file uploaded.");
    // }
    const user = await prisma.user.findFirst({
      where: { id: req.userId, role: "STAFF" }
    })

    if (!user) {
      return res.status(404).send("user not found");
    }
    // Set photoUrl as the Cloudinary URL
    // const photoUrl = req.cloudinaryUrl;
    const photoUrl = req.file.cloudinaryUrl ?? "null";

    // Validate input using zod schema
    PunchInSchema.parse({
      punchInMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
      location
    });

    let punchInData = { punchInMethod, location };

    if (punchInMethod === "PHOTOCLICK") {
      punchInData = { ...punchInData, photoUrl };// Use Cloudinary URL
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
      return res.status(400).json({ error: "Punch-in record already exists for today." });
    }

    // Define the standard punch-in time
    const standardStartTime = new Date();
    standardStartTime.setHours(10, 0, 0, 0);

    const currentPunchInTime = new Date();

    // Calculate lateness in minutes
    const latenessMinutes = Math.max(
      0,
      Math.floor((currentPunchInTime - standardStartTime) / (1000 * 60))
    );

    const hoursLate = Math.floor(latenessMinutes / 60);
    const minutesLate = latenessMinutes % 60;

    // Set fine as a string based on lateness
    let fine;
    if (latenessMinutes > 0) {
      fine = `${hoursLate > 0 ? hoursLate : ""} : ${minutesLate}`;
    } else {
      fine = "On time";
    }

    // Add lateness information to punchInData
    punchInData = { ...punchInData, punchInTime: currentPunchInTime };

    // Create the punch-in record in the database
    const punchIn = await prisma.punchIn.create({
      data: {
        punchInMethod: punchInMethod || "PHOTOCLICK",
        ...punchInData,
        location,
        fine: fine
      },
    });

    const punchRecords = await prisma.punchRecords.create({
      data: {
        punchIn: punchIn.id,
        staffId: user.staffDetails.id
      }
    })
    console.log(punchRecords)

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
    // const photoUrl = String(req.file);
    // if (!req.file) {
    //   return res.status(400).send("No file uploaded.");
    // }
    const user = await prisma.user.findFirst({
      where: { id: req.userId, role: "STAFF" }
    })

    if (!user) {
      return res.status(404).send("user not found");
    }
    const photoUrl = req.file.cloudinaryUrl || "null";
    // Validate input using zod schema
    PunchOutSchema.parse({
      punchOutMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
      location
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

    const existingPunchIn = await prisma.punchIn.findFirst({
      where: {
        punchInDate: {
          gte: today,
          lt: new Date(today.getTime() + 86400000),
        },
      },
    });

    if (!existingPunchIn) {
      return res.status(400).json({ error: "No punch-in record found for today." });
    }

    const existingPunchOut = await prisma.punchOut.findFirst({
      where: {
        punchOutDate: {
          gte: today,
          lt: new Date(today.getTime() + 86400000),
        },
      },
    });

    if (existingPunchOut) {
      return res.status(400).json({ error: "Punch-out record already exists for today." });
    }

    // Define standard start and end times (10:00 am to 6:30 pm on the current date)
    const standardStartTime = new Date();
    standardStartTime.setHours(10, 0, 0, 0);

    // Standard end time (6:30 pm on the current date)
    const standardEndTime = new Date();
    standardEndTime.setHours(18, 30, 0, 0);

    const currentPunchOutTime = new Date();
    const punchInTime = new Date(existingPunchIn.punchInTime);  // Assume this field holds punch-in time

    // Calculate overtime before the standard start time
    let overtimeBefore = 0;
    if (punchInTime < standardStartTime) {
      overtimeBefore = Math.floor((standardStartTime - punchInTime) / (1000 * 60));
    }

    // Calculate overtime after the standard end time
    let overtimeAfter = 0;
    if (currentPunchOutTime > standardEndTime) {
      overtimeAfter = Math.floor((currentPunchOutTime - standardEndTime) / (1000 * 60));
    }

    // Total overtime in minutes
    const totalOvertimeMinutes = overtimeBefore + overtimeAfter;

    // Format total overtime in hours and minutes
    const hoursOvertime = Math.floor(totalOvertimeMinutes / 60);
    const minutesOvertime = totalOvertimeMinutes % 60;
    const overtime = totalOvertimeMinutes > 0 ? `${hoursOvertime} : ${minutesOvertime}` : "No overtime";

    // Add punch-out time and overtime information to punchOutData
    punchOutData = { ...punchOutData, punchOutTime: currentPunchOutTime };

    //find user then punchrecord 

    // Create the punch-out record in the database
    const punchOut = await prisma.punchOut.create({
      data: {
        punchOutMethod: punchOutMethod || 'PHOTOCLICK',
        ...punchOutData,
        location,
        overtime: overtime
      },
    });

    return res.status(201).json(punchOut);
  } catch (error) {
    console.log(error);
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
    const punchRecords = await prisma.punchRecords.findMany({
      include: {
        punchIn: true,
        punchOut: true
      }
    });
    res.status(200).json(punchRecords);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch punch-in" });
  }
}


module.exports = { createPunchIn, getAllPunchIn, createPunchOut, getAllPunchOut, getPunchRecords, getPunchRecordById };

