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
    const { punchInMethod, biometricData, qrCodeValue, staffId } = req.body;
    // const photoUrl = JSON.stringify(req.file);
    const photoUrl = String(req.file);
    if (!req.file) {
      return res.status(400).send("No file uploaded.");
    }

    // Validate input using zod schema
    PunchInSchema.parse({
      staffId,
      punchInMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
    });

    let punchInData = { staffId, punchInMethod };

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
        staffId,
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
        staffId,
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

async function getPunchIn(req, res) {
  try {
    const { staffId } = req.query; // Optionally filter by userId

    // Construct the query options based on whether userId is provided
    const queryOptions = {};
    if (staffId) {
      queryOptions.where = {
        staffId: staffId,
      };
    }

    // Fetch the punch-in records from the database
    const records = await prisma.punchIn.findMany(queryOptions, {
      include: {
        PunchRecords: true
      }
    });

    // Convert date strings back to JavaScript Date objects if needed
    const formattedRecords = records.map((record) => ({
      ...record,
      punchInTime: record.punchInTime ? new Date(record.punchInTime) : null,
      punchOutTime: record.punchOutTime ? new Date(record.punchOutTime) : null,
    }));

    return res.status(200).json(formattedRecords);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ error: "Failed to retrieve punch-in records" });
  }
}

async function createPunchOut(req, res) {
  try {
    const { punchOutMethod, biometricData, qrCodeValue, staffId } = req.body;
    // const photoUrl = JSON.stringify(req.file);
    const photoUrl = String(req.file);
    if (!req.file) {
      return res.status(400).send("No file uploaded.");
    }

    // Validate input using zod schema
    PunchOutSchema.parse({
      staffId,
      punchOutMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
    });

    let punchOutData = { staffId, punchOutMethod };

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

    // Check if a punch-in already exists for the same staff and date
    const existingPunchOut = await prisma.punchOut.findFirst({
      where: {
        staffId,
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
        staffId,
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

async function getPunchOut(req, res) {
  try {
    const { staffId } = req.query; // Optionally filter by userId

    // Construct the query options based on whether userId is provided
    const queryOptions = {};
    if (staffId) {
      queryOptions.where = {
        staffId: staffId,
      };
    }

    // Fetch the punch-in records from the database
    const records = await prisma.punchOut.findMany(queryOptions, {
      include: {
        PunchRecords: true
      }
    });

    // Convert date strings back to JavaScript Date objects if needed
    const formattedRecords = records.map((record) => ({
      ...record,
      punchInTime: record.punchInTime ? new Date(record.punchInTime) : null,
      punchOutTime: record.punchOutTime ? new Date(record.punchOutTime) : null,
    }));

    return res.status(200).json(formattedRecords);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ error: "Failed to retrieve punch-in records" });
  }
}

// async function createPunchRecords(req, res) {
//   try {
//     const { punchInId, punchOutId } = req.body;

//     // Get today's date (only the date part)
//     const today = new Date();
//     today.setHours(0, 0, 0, 0); // Set time to 00:00:00 to compare only the date

// Check if there's already a punchInId or punchOutId for today
// const existingPunch = await prisma.punchRecords.findFirst({
//   where: {
//     punchDate: {
//       // Check the punchInDate field
//       gte: today, // Greater than or equal to today
//       lt: new Date(today.getTime() + 86400000), // Less than tomorrow
//     },
//     OR: [{ punchInId }, { punchOutId }],
//   },
// });

// If the punch already exists, return an error
// if (existingPunch) {
//   return res
//     .status(400)
//     .json({ message: "PunchInId or PunchOutId already exists for today." });
// }

// PunchRecordsSchema.safeParse({ punchInId, punchOutId });

// If no record exists for today, create a new punch entry
//   const newPunchRecord = await prisma.punchRecords.create({
//     data: {
//       punchInId,
//       punchOutId,
//     },
//   });

//   return res.status(201).json(newPunchRecord);
// } catch (error) {
//   console.log(error);
//   // Check if the error is from Zod validation and handle accordingly
//   if (error instanceof ZodError) {
//     return res.status(400).json({ errors: error.errors }); // Return detailed validation errors
//   }
//   if (error.code === "P2002") {
//     res.status(409).json({
//       success: false,
//       error: "PunchRecordId is already exists.",
//     });
//   }

//   // For any other errors, return a general error message
//   return res.status(500).json({ error: "Internal Server Error" });
// }


async function getPunchRecordById(req, res) {
  try {
    const { punchInId, punchOutId } = req.params; // Extract the IDs from the URL params

    // Fetch punch record by punchInId or punchOutId
    const punchRecord = await prisma.punchRecords.findFirst({
      where: {
        OR: [
          { punchInId },
          { punchOutId }
        ]
      },
      include: {
        punchIn: true,  // Include PunchIn details
        punchOut: true, // Include PunchOut details
        staff: true,    // Optionally include Staff details if needed
      },
    });

    // If the punch record is not found, return a 404 error
    if (!punchRecord) {
      return res.status(404).json({ message: "Punch record not found" });
    }

    // If punch record is found, return it
    res.status(200).json(punchRecord);
  } catch (error) {
    console.log(error)
    // Check if the error is from Zod validation and handle accordingly
    if (error instanceof ZodError) {
      return res.status(400).json({ errors: error.errors }); // Return detailed validation errors
    }
    if (error.code === "P2002") {
      res.status(409).json({
        success: false,
        error: "PunchRecordId is already exists.",
      })
    }

    // For any other errors, return a general error message
    return res.status(500).json({ error: "Internal Server Error" });
  }
}



async function getPunchRecords(req, res) {
  try {
    const { id } = req.params;
    const punchRecords = await prisma.punchRecords.findMany({
      where: { id },
    });
    res.status(200).json(punchRecords);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch punch-in" });
  }
}

module.exports = { createPunchIn, getPunchIn, createPunchOut, getPunchOut, getPunchRecords, getPunchRecordById };