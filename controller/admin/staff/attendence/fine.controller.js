const { PrismaClient } = require("@prisma/client");
const { ZodError } = require("zod");
const { FineSchema } = require("../../../../utils/validations.js");
const prisma = new PrismaClient();

const addFineData = async (req, res) => {
    const {
        staffId,
        lateEntryFineAmount,
        lateEntryAmount,
        excessBreakFineAmount,
        excessBreakAmount,
        earlyOutFineAmount,
        earlyOutAmount,
        totalAmount,
        shiftIds,
    } = req.body;

    try {
        // Check if the staffId exists in punchRecords
        const existingPunchRecord = await prisma.punchRecords.findFirst({
            where: {
                staffId: staffId,
            },
        });

        if (!existingPunchRecord) {
            // If staffId is not found in punchRecords, create a new record with status 'ABSENT'
            const newPunchRecord = await prisma.punchRecords.create({
                data: {
                    staffId: staffId,
                    status: "ABSENT",
                },
            });

            // Create a new fine record with the new punchRecordId
            const fine = await prisma.fine.create({
                data: {
                    staffId,
                    lateEntryFineAmount,
                    lateEntryAmount,
                    excessBreakFineAmount,
                    excessBreakAmount,
                    earlyOutFineAmount,
                    earlyOutAmount,
                    totalAmount,
                    shiftIds,
                    punchRecordId: newPunchRecord.id,
                },
            });

            return res.status(200).json(fine);
        }

        // Check if a fine record exists for the given punchRecordId
        const existingFine = await prisma.fine.findFirst({
            where: {
                punchRecordId: existingPunchRecord.id,
            },
        });

        if (existingFine) {
            // If fine record exists, update it with new data
            const fine = await prisma.fine.update({
                where: {
                    id: existingFine.id, // Use the existing fine's ID to update
                },
                data: {
                    lateEntryFineAmount,
                    lateEntryAmount,
                    excessBreakFineAmount,
                    excessBreakAmount,
                    earlyOutFineAmount,
                    earlyOutAmount,
                    totalAmount,
                    shiftIds,
                },
            });

            // Respond with the updated fine record
            return res.status(200).json(fine);
        }

        // If no fine record exists, create a new fine record
        const fine = await prisma.fine.create({
            data: {
                staffId,
                lateEntryFineAmount,
                lateEntryAmount,
                excessBreakFineAmount,
                excessBreakAmount,
                earlyOutFineAmount,
                earlyOutAmount,
                totalAmount,
                shiftIds,
                punchRecordId: existingPunchRecord.id,
            },
        });

        return res.status(200).json(fine);
    } catch (error) {
        console.error("Error adding or updating fine:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
};


// update multiple fine data with id

const updateMultipleFineData = async (req, res) => {
    try {
        const { fineUpdates } = req.body;

        if (!Array.isArray(fineUpdates) || fineUpdates.length === 0) {
            return res.status(400).json({ error: "Please provide valid fine updates" });
        }

        const updatePromises = fineUpdates.map((fine) =>
            prisma.fine.update({
                where: { id: fine.id },
                data: {
                    lateEntryFineAmount: fine.lateEntryFineAmount,
                    lateEntryAmount: fine.lateEntryAmount,
                    excessBreakFineAmount: fine.excessBreakFineAmount,
                    excessBreakAmount: fine.excessBreakAmount,
                    earlyOutFineAmount: fine.earlyOutFineAmount,
                    earlyOutAmount: fine.earlyOutAmount,
                    totalAmount: fine.totalAmount,
                    shiftIds: fine.shiftIds,
                },
            })
        );

        const updatedFines = await Promise.all(updatePromises);

        res.status(200).json({ message: "Fines updated successfully", data: updatedFines });
    } catch (error) {
        console.error("Error updating fine data:", error);
        res.status(500).json({ message: " please enter a valid fine id" });
    }
};
module.exports = { addFineData, updateMultipleFineData };
