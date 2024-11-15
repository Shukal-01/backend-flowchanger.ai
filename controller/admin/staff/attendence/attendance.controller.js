const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const attendanceRecords = async (req, res) => {
    try {
        const { date } = req.query;

        let startDate, endDate;

        if (date) {
            // Parse the provided date
            const providedDate = new Date(date);
            if (isNaN(providedDate)) {
                return res.status(400).json({ message: "Invalid date format. Use YYYY-MM-DD." });
            }
            startDate = new Date(providedDate);
            startDate.setHours(0, 0, 0, 0); // Set to start of the day
            endDate = new Date(startDate);
            endDate.setDate(startDate.getDate() + 1); // Set to end of the day
        } else {
            // Use current date if no date is provided
            startDate = new Date();
            startDate.setHours(0, 0, 0, 0);
            endDate = new Date(startDate);
            endDate.setDate(startDate.getDate() + 1);
        }

        // Fetch all staff records
        const allStaff = await prisma.staffDetails.findMany();

        // Check if there are punch records for the specified date
        const existingPunchRecords = await prisma.punchRecords.findMany({
            where: {
                punchDate: {
                    gte: startDate,
                    lt: endDate,
                },
            },
            orderBy: {
                punchDate: 'asc'
            }
        });

        // Get IDs of staff who already have records for the date
        const existingStaffIds = existingPunchRecords.map(record => record.staffId);

        // Create records for staff who do not have punch records for the date
        const missingStaff = allStaff.filter(staff => !existingStaffIds.includes(staff.id));
        for (const staff of missingStaff) {
            await prisma.punchRecords.create({
                data: {
                    staffId: staff.id,
                    punchDate: startDate,
                    status: 'ABSENT', // Default status
                },
            });
        }

        // Fetch punch records for the specified date
        const punchRecords = await prisma.punchRecords.findMany({
            where: {
                punchDate: {
                    gte: startDate,
                    lt: endDate,
                },
            },
            orderBy: {
                punchDate: 'asc'
            }
        });

        // Send the response with fetched punch records
        res.status(200).json(punchRecords);
    } catch (error) {
        console.error("Error processing punch records:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};

const updatePunchRecordStatus = async (req, res) => {
    const { id } = req.params;
    const { status } = req.body;

    const validStatuses = ["ABSENT", "PRESENT", "HALFDAY", "PAIDLEAVE"];

    if (!validStatuses.includes(status)) {
        return res.status(400).json({
            error:
                "Invalid status. Valid statuses are ABSENT, PRESENT, HALFDAY, PAIDLEAVE.",
        });
    }

    try {
        const updatedPunchRecord = await prisma.punchRecords.update({
            where: { id },
            data: { status },
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

module.exports = { attendanceRecords, updatePunchRecordStatus };
