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
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);

    let existingPunchRecord = await prisma.punchRecords.findFirst({
      where: {
        staffId: staffId,
        punchDate: {
          gte: today,
          lt: tomorrow,
        },
      },
    });

    if (!existingPunchRecord) {
      existingPunchRecord = await prisma.punchRecords.create({
        data: {
          staffId: staffId,
          status: "ABSENT",
        },
      });
    }

    let existingFine = await prisma.fine.findFirst({
      where: {
        punchRecordId: existingPunchRecord.id,
      },
    });

    if (existingFine) {
      const fine = await prisma.fine.update({
        where: {
          id: existingFine.id,
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

      res.status(200).json(fine);
    } else {
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

const getFinesByDate = async (req, res) => {
  try {
    const { date } = req.query;

    if (!date) {
      return res.status(400).json({ message: "Date is required" });
    }

    const fineDate = new Date(date);

    if (isNaN(fineDate.getTime())) {
      return res.status(400).json({ message: "Invalid date format" });
    }

    const fines = await prisma.fine.findMany({
      where: {
        createdAt: {
          gte: fineDate,
          lt: new Date(fineDate.getTime() + 24 * 60 * 60 * 1000),
        },
      },
      include: {
        staff: true,
        shiftDetails: true,
        punchRecord: {
          include: {
            punchIn: true,
            punchOut: true,
          },
        },
      },
    });

    return res.status(200).json({
      message: "Fines fetched successfully",
      fines: fines,
    });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ message: "An error occurred while fetching the fines" });
  }
};

module.exports = { addFineData, getFinesByDate };
