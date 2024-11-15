const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

exports.updatePunchRecordStatus = async (req, res) => {
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
