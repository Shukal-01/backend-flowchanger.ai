const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const attendanceRecords = async (req, res) => {
  try {
    const { date } = req.params;

    const filter = {};

    let startDate, endDate;
    const currentDate = new Date();
    currentDate.setHours(0, 0, 0, 0);

    if (date) {
      filter.punchDate = {
        gte: new Date(date),
        lt: new Date(date).getDate() + 1,
      };
    } else {
      startDate = currentDate;
    }
    startDate.setHours(0, 0, 0, 0);
    endDate = new Date(startDate);
    endDate.setDate(startDate.getDate() + 1);
    const allStaff = await prisma.staffDetails.findMany();
    const existingPunchRecords = await prisma.punchRecords.findMany({
      where: {
        punchDate: {
          gte: startDate,
          lt: endDate,
        },
      },
      orderBy: {
        punchDate: "asc",
      },
    });
    const existingStaffIds = existingPunchRecords.map(
      (record) => record.staffId
    );
    const missingStaff = allStaff.filter(
      (staff) => !existingStaffIds.includes(staff.id)
    );
    for (const staff of missingStaff) {
      await prisma.punchRecords.create({
        data: {
          staffId: staff.id,
          punchDate: startDate,
          status: "ABSENT",
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
        punchDate: "asc",
      },
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
