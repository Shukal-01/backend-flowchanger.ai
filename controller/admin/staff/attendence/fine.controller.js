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

  // Validate input data
  const validationResult = FineSchema.safeParse({
    staffId,
    lateEntryFineAmount,
    lateEntryAmount,
    excessBreakFineAmount,
    excessBreakAmount,
    earlyOutFineAmount,
    earlyOutAmount,
    totalAmount,
    shiftIds,
  });

  if (!validationResult.success) {
    return res.status(400).json({ error: validationResult.error });
  }

  try {
    // Set 'today' and 'tomorrow' for date range
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);

    // Find or create punch record for today
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

    // Find existing fine record for the punch record
    let existingFine = await prisma.fine.findFirst({
      where: {
        punchRecordId: existingPunchRecord.id,
      },
    });

    let fine;
    if (existingFine) {
      // Update the existing fine record
      fine = await prisma.fine.update({
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
    } else {
      // Create a new fine record
      fine = await prisma.fine.create({
        data: {
          staffId: validationResult.data.staffId,
          lateEntryFineAmount: validationResult.data.lateEntryFineAmount,
          lateEntryAmount: validationResult.data.lateEntryAmount,
          excessBreakFineAmount: validationResult.data.excessBreakFineAmount,
          excessBreakAmount: validationResult.data.excessBreakAmount,
          earlyOutFineAmount: validationResult.data.earlyOutFineAmount,
          earlyOutAmount: validationResult.data.earlyOutAmount,
          totalAmount: validationResult.data.totalAmount,
          shiftIds: validationResult.data.shiftIds,
          punchRecordId: existingPunchRecord.id,
        },
      });
    }

    res.status(200).json(fine);
  } catch (error) {
    console.error("Error adding or updating fine:", error);
    res.status(500).json({ error: "Internal Server Error: " + error.message });
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

const updateFine = async (req, res) => {
  const { id } = req.params;
  const {
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
    const fine = await prisma.fine.update({
      where: {
        id: id,
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

    res.status(200).json(fine);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to update fine" });
  }
};

module.exports = { addFineData, getFinesByDate, updateFine };
