
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const { ZodError } = require("zod");
const {
    StartBreakSchema,
    EndBreakSchema,
} = require("../../utils/validations");

async function createStartBreak(req, res) {
    try {
        const { breakMethod, biometricData, qrCodeValue, location } = req.body;
        const photoUrl = req.imageUrl || "null";

        // Find the user and include staff details
        const user = await prisma.user.findFirst({
            where: { id: req.userId, role: "STAFF" },
            include: { staffDetails: true },
        });
        if (!user) {
            return res.status(404).send("User not found");
        }

        // Validate input using zod schema
        const start = StartBreakSchema.parse({
            staffId: user.staffDetails.id,
            breakMethod,
            biometricData,
            qrCodeValue,
            photoUrl,
            location,
        });

        const indiaTime = new Date().toLocaleString("en-US", {
            timeZone: "Asia/Kolkata",
        });
        const currentDayStart = new Date(indiaTime);
        currentDayStart.setHours(0, 0, 0, 0); // Start of the day
        const currentDayEnd = new Date(indiaTime);
        currentDayEnd.setHours(23, 59, 59, 999); // End of the day

        // Find the latest startBreak entry for today
        const latestStartBreak = await prisma.startBreak.findFirst({
            where: {
                staffId: start.staffId,
                startBreakTime: {
                    gte: currentDayStart, // From the start of the current day
                    lte: currentDayEnd,   // To the end of the current day
                },
            },
            orderBy: {
                startBreakTime: "desc", // Get the most recent entry
            },
        });

        if (latestStartBreak) {
            // Check for a corresponding endBreak with a time after the latest startBreak
            const correspondingEndBreak = await prisma.endBreak.findFirst({
                where: {
                    staffId: start.staffId, // Match the staff ID
                    endBreakTime: {
                        gte: latestStartBreak.startBreakTime, // Check for endBreak after startBreak time
                    },
                },
                orderBy: {
                    endBreakTime: "desc", // Get the latest entry
                },
            });

            // If no corresponding endBreak is found, return an error
            if (!correspondingEndBreak) {
                return res.status(400).json({
                    error: "A startBreak already exists without a corresponding endBreak. Complete the current break before starting a new one.",
                });
            }
        }

        // Prepare break data based on the break method
        let breakData = { breakMethod, location };
        if (breakMethod === "PHOTOCLICK") {
            breakData = { ...breakData, photoUrl };
        } else if (breakMethod === "QRSCAN") {
            breakData = { ...breakData, qrCodeValue };
        } else if (breakMethod === "BIOMETRIC") {
            breakData = { ...breakData, biometricData };
        }

        // Start a Prisma transaction to ensure both entries are created together
        const result = await prisma.$transaction(async (prisma) => {
            // Create the new startBreak
            const startBreak = await prisma.startBreak.create({
                data: {
                    breakMethod: breakMethod || "PHOTOCLICK", // Default to PHOTOCLICK if not provided
                    ...breakData,
                    location,
                    staffId: start.staffId,
                },
            });

            // Create the breakRecord entry
            const breakRecord = await prisma.breakRecord.create({
                data: {
                    staffId: start.staffId,
                    startBreakId: startBreak.id,
                    breakDate: new Date(),
                },
            });

            // Additional records if needed can be added here

            return { startBreak, breakRecord };
        });

        return res.status(201).json(result); // Return both records if successful
    } catch (error) {
        console.error("Error:", error);

        // Check if the error is from Zod validation and handle accordingly
        if (error instanceof ZodError) {
            return res.status(400).json({ errors: error.errors }); // Return detailed validation errors
        }

        // For any other errors, return a general error message
        return res.status(500).json({ error: "Internal Server Error" });
    }
}

// get break record by staff id

const getBreakRecordByStaffId = async (req, res) => {
    try {
        const { staffId } = req.params; // Get the staffId from URL parameters

        // Fetch all endBreaks for the given staffId
        const endBreaks = await prisma.endBreak.findMany({
            where: { staffId: staffId }, // Fetch endBreaks for this staffId
            orderBy: { endBreakTime: "desc" }, // Sort by latest endBreakTime
        });

        if (endBreaks.length === 0) {
            return res.status(404).json({ message: "No break records found for this staff ID" });
        }

        // Fetch corresponding startBreaks and merge them
        const breakRecords = await Promise.all(
            endBreaks.map(async (endBreak) => {
                // Find the latest startBreak before this endBreak
                const startBreak = await prisma.startBreak.findFirst({
                    where: {
                        staffId: staffId,
                        startBreakTime: {
                            lte: endBreak.endBreakTime, // Must be before or equal to the endBreak time
                        },
                    },
                    orderBy: { startBreakTime: "desc" }, // Get the latest startBreak
                });

                // Combine startBreak and endBreak into a single object
                return {
                    breakDate: endBreak.endBreakTime, // Use endBreak's time for the breakDate
                    startBreak: startBreak || null,  // Add startBreak if found, else null
                    endBreak: endBreak,
                };
            })
        );

        // Return the combined break records as a response
        return res.status(200).json({
            message: "Break Records",
            breakRecords,
        });
    } catch (error) {
        console.error("Error fetching break records:", error);

        // Return an error response for any issues during the process
        return res.status(500).json({ error: "Internal Server Error" });
    }
};



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
        const { breakMethod, biometricData, qrCodeValue, location } = req.body;
        const photoUrl = req.imageUrl || "null";

        // Fetch the user details, including their staff ID
        const user = await prisma.user.findFirst({
            where: { id: req.userId, role: "STAFF" },
            include: { staffDetails: true },
        });

        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        // Validate input using Zod schema
        const end = EndBreakSchema.parse({
            staffId: user.staffDetails.id,
            breakMethod,
            biometricData,
            qrCodeValue,
            photoUrl,
            location,
        });

        const staffId = end.staffId;
        // Get the current time in IST
        const indiaTime = new Date().toLocaleString("en-US", { timeZone: "Asia/Kolkata" });
        const currentISTTime = new Date(indiaTime); // Parse it into a Date object

        // Find the latest startBreak for this staffId
        const existingStartBreak = await prisma.startBreak.findFirst({
            where: {
                staffId: end.staffId,
                startBreakTime: {
                    lte: currentISTTime, // Ensure the startBreakTime is earlier or equal to the current time
                }
            },
            orderBy: { startBreakTime: 'desc' } // Order by the most recent startBreak
        });

        // If no startBreak is found or the latest startBreak doesn't exist, return an error
        if (!existingStartBreak) {
            return res.status(400).json({
                error: "Cannot create endBreak without a valid startBreak. Please start a break first."
            });
        }

        // Check if an endBreak already exists for this staffId and if the latest startBreak is already ended
        const existingEndBreak = await prisma.endBreak.findFirst({
            where: {
                staffId: end.staffId,
                endBreakTime: {
                    gte: existingStartBreak.startBreakTime, // Ensure endBreak is after the corresponding startBreak
                },
            },
            orderBy: { endBreakTime: 'desc' } // Order by the most recent endBreak
        });

        // If an endBreak is found for the latest startBreak, return an error
        if (existingEndBreak) {
            return res.status(400).json({
                error: "The latest startBreak has already been ended. Please start a new break before ending it."
            });
        }

        // Prepare break data based on the break method
        let breakData = { breakMethod, location };
        if (breakMethod === "PHOTOCLICK") {
            breakData = { ...breakData, photoUrl };
        } else if (breakMethod === "QRSCAN") {
            breakData = { ...breakData, qrCodeValue };
        } else if (breakMethod === "BIOMETRIC") {
            breakData = { ...breakData, biometricData };
        }

        // Use a transaction to ensure the integrity of related records
        const result = await prisma.$transaction(async (prisma) => {

            // Create the new endBreak record
            const endBreak = await prisma.endBreak.create({
                data: {
                    breakMethod,
                    ...breakData,
                    location,
                    staffId,
                    // startBreakId: existingStartBreak.id, 
                },
            });

            // Create the breakRecord entry             
            const endBreakRecord = await prisma.breakRecord.create({
                data: {
                    staffId: staffId,
                    endBreakId: endBreak.id, // Reference the newly created endBreak ID
                    breakDate: new Date(),   // Use the current date as breakDate
                },
            });


            return { endBreak, endBreakRecord };
        });

        return res.status(201).json(result); // Return the created records
    } catch (error) {
        console.error("Error:", error);

        // Check for Zod validation errors
        if (error instanceof ZodError) {
            return res.status(400).json({ errors: error.errors });
        }

        // Handle other errors
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

module.exports = { createStartBreak, createEndBreak, getAllStartBreaks, getStartBreakByStaffId, getAllEndBreaks, getEndBreakByStaffId, getBreakRecordByStaffId };

