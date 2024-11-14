const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const addFineData = async (req, res) => {
  // Destructure the request body
  const {
    lateEntryFineAmount,
    lateEntryAmount,
    excessBreakFineAmount,
    excessBreakAmount,
    earlyOutFineAmount,
    earlyOutAmount,
    totalAmount,
    shiftIds,
    punchRecordId,
  } = req.body;

  try {
    // Create a new Fine record
    const fine = await prisma.fine.create({
      data: {
        lateEntryFineAmount,
        lateEntryAmount,
        excessBreakFineAmount,
        excessBreakAmount,
        earlyOutFineAmount,
        earlyOutAmount,
        totalAmount,
        shiftIds,
        punchRecordId,
      },
    });

    res.status(201).json(fine); // Return the created fine record
  } catch (error) {
    console.error("Error adding fine:", error);
    res.status(500).json({ error: "Error adding fine record" });
  }
};

module.exports = { addFineData };
