const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const addOvertimeData = async (req, res) => {
    const {
        staffId,
        earlyCommingEntryAmount,
        earlyEntryAmount,
        lateOutOvertimeAmount,
        lateOutAmount,
        totalAmount,
        shiftIds,
    } = req.body;

    try {
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const tomorrow = new Date(today);
        tomorrow.setDate(today.getDate() + 1);

        let existingPunchRecord = await prisma.punchRecords.findFirst({
            where: {
                punchDate: {
                    gte: today,
                    lt: tomorrow,
                },
            },
        });

        if (!existingPunchRecord) {
            // If no punch record exists, create a new one with the formattedDate and set status as ABSENT
            existingPunchRecord = await prisma.punchRecords.create({
                data: {
                    staffId: staffId,
                    status: "ABSENT",
                },
            });
        }

        // Check if an overtime record exists for the given punchRecordId
        let existingOvertime = await prisma.overtime.findFirst({
            where: {
                punchRecordId: existingPunchRecord.id,  // Match by punchRecordId
            },
        });

        if (existingOvertime) {
            // If overtime record exists, update it with new data
            const overtime = await prisma.overtime.update({
                where: {
                    id: existingOvertime.id,  // Use the existing overtime's ID to update
                },
                data: {
                    earlyCommingEntryAmount,
                    earlyEntryAmount,
                    lateOutOvertimeAmount,
                    lateOutAmount,
                    totalAmount,
                    shiftIds,
                    punchRecordId: existingPunchRecord.id,  // Link overtime to the punch record
                },
            });

            // Respond with the updated overtime record
            res.status(200).json(overtime);
        } else {
            // If no overtime record exists, create one
            const overtime = await prisma.overtime.create({
                data: {
                    staffId,
                    earlyCommingEntryAmount,
                    earlyEntryAmount,
                    lateOutOvertimeAmount,
                    lateOutAmount,
                    totalAmount,
                    shiftIds,
                    punchRecordId: existingPunchRecord.id,  // Link overtime to the punch record
                },
            });

            // Respond with the created overtime record
            res.status(201).json(overtime);
        }
    } catch (error) {
        console.error("Error adding or updating overtime:", error);
        res.status(500).json({ message: "Failed to add or update overtime" + error.message });
    }
};

module.exports = { addOvertimeData };
