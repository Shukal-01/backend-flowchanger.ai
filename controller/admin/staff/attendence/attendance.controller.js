const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const attendanceRecords = async (req, res) => {
  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);

    // Fetch all staff records
    const allStaff = await prisma.staffDetails.findMany();

    // Loop through each staff and check if a punch record exists for today
    for (const staff of allStaff) {
      let existingPunchRecord = await prisma.punchRecords.findFirst({
        where: {
          staffId: staff.id,
          punchDate: {
            gte: today, // Greater than or equal to today's date (00:00:00)
            lt: tomorrow, // Less than tomorrow's date (00:00:00)
          },
        },
      });

      if (!existingPunchRecord) {
        // If no record exists, create a new punch record for this staff
        await prisma.punchRecords.create({
          data: {
            staffId: staff.id,
            punchDate: today, // Set the current date for punch record
            status: "ABSENT", // Default status (can be changed later)
          },
        });

        // console.log(`Punch record created for staff ${staff.id} on ${today.toISOString()}`);
      } else {
        // console.log(`Punch record already exists for staff ${staff.id} on ${today.toISOString()}`);
      }
    }

    // Fetch all punch records for today to return
    const punchRecords = await prisma.punchRecords.findMany({
      where: {
        punchDate: {
          gte: today,
          lt: tomorrow,
        },
      },
    });

    // Send the list of punch records as a response
    res.status(200).json(punchRecords);
  } catch (error) {
    console.error("Error processing punch records:", error);
    // Send error response
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
