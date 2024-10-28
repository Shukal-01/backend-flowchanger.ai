
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
    // const photoUrl = JSON.stringify(req.file);
    const photoUrl = String(req.file);
    if (!req.file) {
      return res.status(400).send("No file uploaded.");
    }

    // Validate input using zod schema
    PunchInSchema.parse({
      // staffId,
      punchInMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
      location
    });

    let punchInData = { punchInMethod, location };

    console.log(location);
    // Determine the method of punch-in and set the appropriate data
    if (punchInMethod === "PHOTOCLICK") {
      // punchInData = { ...punchInData, photoUrl: req.file.originalname };
      punchInData = { ...punchInData, photoUrl: req.savedFilename };
    } else if (punchInMethod === "QRSCAN") {
      punchInData = { ...punchInData, qrCodeValue };
    } else if (punchInMethod === "BIOMETRIC") {
      punchInData = { ...punchInData, biometricData };
    }

    // Get today's date (only the date part) to avoid multiple punch-ins on the same day
    const today = new Date();
    today.setHours(0, 0, 0, 0); // Set the time to 00:00:00 for accurate date comparison

    // Check if a punch-in already exists for the same staff and date
    const existingPunchIn = await prisma.punchIn.findFirst({
      where: {
        punchInDate: {
          // Check the punchInDate field
          gte: today, // Greater than or equal to today
          lt: new Date(today.getTime() + 86400000), // Less than tomorrow
        },
      },
    });

    // If a punch-out already exists for today, return an error
    if (existingPunchIn) {
      return res
        .status(400)
        .json({ error: "Punch-out record already exists for today." });
    }

    // Create the punch-in record in the database
    const punchIn = await prisma.punchIn.create({
      data: {
        punchInMethod: punchInMethod || "PHOTOCLICK", // default to PHOTOCLICK if not provided
        ...punchInData,
        location,
      },
    });

    return res.status(201).json(punchIn);
  } catch (error) {
    console.log(error);
    // Check if the error is from Zod validation and handle accordingly
    if (error instanceof ZodError) {
      return res.status(400).json({ errors: error.errors }); // Return detailed validation errors
    }

    // For any other errors, return a general error message
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
    // const photoUrl = JSON.stringify(req.file);
    const photoUrl = String(req.file);
    if (!req.file) {
      return res.status(400).send("No file uploaded.");
    }

    // Validate input using zod schema
    PunchOutSchema.parse({
      punchOutMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
      location
    });

    let punchOutData = { punchOutMethod };

    // Determine the method of punch-in and set the appropriate data
    if (punchOutMethod === "PHOTOCLICK") {
      // punchInData = { ...punchInData, photoUrl: req.file.originalname };
      punchOutData = { ...punchOutData, photoUrl: req.savedFilename };
    } else if (punchOutMethod === "QRSCAN") {
      punchOutData = { ...punchOutData, qrCodeValue };
    } else if (punchOutMethod === "BIOMETRIC") {
      punchOutData = { ...punchOutData, biometricData };
    }

    // Get today's date (only the date part) to avoid multiple punch-ins on the same day
    const today = new Date();
    today.setHours(0, 0, 0, 0); // Set the time to 00:00:00 for accurate date comparison

    // Check if a punch-in record exists for today
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

    // Check if a punch-in already exists for the same staff and date
    const existingPunchOut = await prisma.punchOut.findFirst({
      where: {
        punchOutDate: {
          // Check the punchInDate field
          gte: today, // Greater than or equal to today
          lt: new Date(today.getTime() + 86400000), // Less than tomorrow
        },
      },
    });

    // If a punch-out already exists for today, return an error
    if (existingPunchOut) {
      return res
        .status(400)
        .json({ error: "Punch-out record already exists for today." });
    }

    // Create the punch-in record in the database
    const punchOut = await prisma.punchOut.create({
      data: {
        punchOutMethod: punchOutMethod || 'PHOTOCLICK', // default to PHOTOCLICK if not provided
        ...punchOutData,
        location
      },
    });

    return res.status(201).json(punchOut);
  } catch (error) {
    console.log(error);
    // Check if the error is from Zod validation and handle accordingly
    if (error instanceof ZodError) {
      return res.status(400).json({ errors: error.errors }); // Return detailed validation errors
    }

    // For any other errors, return a general error message
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
    const punchRecords = await prisma.punchRecords.findMany();
    res.status(200).json(punchRecords);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch punch-in" });
  }
}


module.exports = { createPunchIn, getAllPunchIn, createPunchOut, getAllPunchOut, getPunchRecords, getPunchRecordById };

