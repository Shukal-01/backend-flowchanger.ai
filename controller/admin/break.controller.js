
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { ZodError } = require("zod");
const {
    StartBreakSchema,
    EndBreakSchema,
} = require("../../utils/validations");

async function createStartBreak(req, res) {
    try {
        const { breakMethod, biometricData, qrCodeValue, location, staffId } = req.body;
        // const photoUrl = JSON.stringify(req.file);
        const photoUrl = String(req.file);
        if (!req.file) {
            return res.status(400).send("No file uploaded.");
        }

        // Validate input using zod schema
        StartBreakSchema.parse({
            staffId,
            breakMethod,
            biometricData,
            qrCodeValue,
            photoUrl,
            location
        });

        // Check if there’s an existing startBreak without an endBreak for the same staffId
        const existingStartBreak = await prisma.startBreak.findFirst({
            where: {
                staffId,
                endBreak: null  // Ensure no endBreak is associated
            }
        });

        if (existingStartBreak) {
            return res.status(400).json({ error: "A startBreak already exists without a corresponding endBreak. Complete the current break before starting a new one." });
        }

        let breakData = { breakMethod, location, staffId };

        // console.log(location);
        // Determine the method of punch-in and set the appropriate data
        if (breakMethod === "PHOTOCLICK") {
            // punchInData = { ...punchInData, photoUrl: req.file.originalname };
            breakData = { ...breakData, photoUrl: req.savedFilename };
        } else if (breakMethod === "QRSCAN") {
            breakData = { ...breakData, qrCodeValue };
        } else if (breakMethod === "BIOMETRIC") {
            breakData = { ...breakData, biometricData };
        }

        // Create the punch-in record in the database
        const startBreak = await prisma.startBreak.create({
            data: {
                breakMethod: breakMethod || "PHOTOCLICK", // default to PHOTOCLICK if not provided
                ...breakData,
                location,
                staffId
            },
        });

        return res.status(201).json(startBreak);
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

async function getAllStartBreaks(req, res) {
    try {
        const startBreaks = await prisma.startBreak.findMany();
        res.status(200).json(startBreaks);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch startBreaks" });
    }
}

async function getStartBreakByStaffId(req, res) {
    try {
        const { staffId } = req.params;
        const startBreaks = await prisma.startBreak.findMany({
            where: { staffId },
        });
        res.status(200).json(startBreaks);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch startBreaks" });
    }
}

async function createEndBreak(req, res) {
    try {
        const { breakMethod, biometricData, qrCodeValue, location, staffId } = req.body;
        // const photoUrl = JSON.stringify(req.file);
        const photoUrl = String(req.file);
        if (!req.file) {
            return res.status(400).send("No file uploaded.");
        }

        // Validate input using zod schema
        EndBreakSchema.parse({
            staffId,
            breakMethod,
            biometricData,
            qrCodeValue,
            photoUrl,
            location
        });

        // Check if a startBreak exists for this staffId
        const existingStartBreak = await prisma.startBreak.findFirst({
            where: { staffId },
            orderBy: { createdAt: 'desc' } // Order by the most recent startBreak
        });

        if (!existingStartBreak) {
            return res.status(400).json({ error: "Cannot create endBreak if startBreak does not exist." });
        }


        let breakData = { breakMethod, location, staffId };

        // console.log(location);
        // Determine the method of punch-in and set the appropriate data
        if (breakMethod === "PHOTOCLICK") {
            // punchInData = { ...punchInData, photoUrl: req.file.originalname };
            breakData = { ...breakData, photoUrl: req.savedFilename };
        } else if (breakMethod === "QRSCAN") {
            breakData = { ...breakData, qrCodeValue };
        } else if (breakMethod === "BIOMETRIC") {
            breakData = { ...breakData, biometricData };
        }

        // Create the punch-in record in the database
        const endBreak = await prisma.endBreak.create({
            data: {
                breakMethod: breakMethod || "PHOTOCLICK", // default to PHOTOCLICK if not provided
                ...breakData,
                location,
                staffId
            },
        });

        return res.status(201).json(endBreak);
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

async function getAllEndBreaks(req, res) {
    try {
        const endBreaks = await prisma.endBreak.findMany();
        res.status(200).json(endBreaks);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch endBreaks" });
    }
}

async function getEndBreakByStaffId(req, res) {
    try {
        const { staffId } = req.params;
        const endBreaks = await prisma.endBreak.findMany({
            where: { staffId },
        });
        res.status(200).json(endBreaks);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Failed to fetch endBreaks" });
    }
}

module.exports = { createStartBreak, createEndBreak, getAllStartBreaks, getStartBreakByStaffId, getAllEndBreaks, getEndBreakByStaffId };

