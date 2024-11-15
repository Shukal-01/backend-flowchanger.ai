const { PrismaClient } = require("@prisma/client");
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
        // Ensure 'today' is set to 00:00:00 for comparison purposes
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const tomorrow = new Date(today);
        tomorrow.setDate(today.getDate() + 1);

        // Find the punch record for the staffId for today's date
        let existingPunchRecord = await prisma.punchRecords.findFirst({
            where: {
                punchDate: {
                    gte: today,
                    lt: tomorrow,
                },
            },
        });

        // If no punch record exists for today, create a new record with status 'ABSENT'
        if (!existingPunchRecord) {
            existingPunchRecord = await prisma.punchRecords.create({
                data: {
                    staffId: staffId,
                    status: "ABSENT",
                },
            });
        }

        // Check if a fine record exists for the given punchRecordId
        let existingFine = await prisma.fine.findFirst({
            where: {
                punchRecordId: existingPunchRecord.id
            },
        });

        if (existingFine) {
            // If fine record exists, update it with new data
            const fine = await prisma.fine.update({
                where: {
                    id: existingFine.id,  // Use the existing fine's ID to update
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
                    punchRecordId: existingPunchRecord.id,
                },
            });

            // Respond with the updated fine record
            res.status(200).json(fine);
        } else {
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
            res.status(200).json(fine);
        }
    } catch (error) {
        console.error("Error adding or updating fine:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
};

module.exports = { addFineData };
