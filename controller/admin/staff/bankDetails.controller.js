const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

exports.createBankDetails = async (req, res) => {
  try {
    const { bank_name, account_number, branch_name, ifsc_code } = req.body;
    const { id } = req.params;
    console.log(id);
    const newBankDetails = await prisma.bankDetails.create({
      data: {
        staffId: id,
        bank_name,
        account_number,
        branch_name,
        ifsc_code,
      },
    });
    res.status(201).json(newBankDetails);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to create bank details" });
  }
};

exports.getAllBankDetails = async (req, res) => {
  try {
    const bankDetails = await prisma.bankDetails.findMany();
    res.status(200).json(bankDetails);
  } catch (error) {
    console.log(error);

    res.status(500).json({ error: "Failed to fetch bank details" });
  }
};

exports.getBankDetailsByStaffId = async (req, res) => {
  const { staffId } = req.params;
  console.log(staffId);

  try {
    const bankDetails = await prisma.bankDetails.findMany({
      where: { staffId },
    });

    if (!bankDetails || bankDetails.length === 0) {
      return res.status(404).json({ error: "Bank details not found" });
    }

    res.status(200).json(bankDetails);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch bank details" });
  }
};

exports.updateBankDetails = async (req, res) => {
  const { id } = req.params;
  const { bank_name, account_number, branch_name, ifsc_code } = req.body;
  try {
    const updatedBankDetails = await prisma.bankDetails.update({
      where: { id },
      data: { bank_name, account_number, branch_name, ifsc_code },
    });
    res.status(200).json(updatedBankDetails);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to update bank details" });
  }
};

// Delete bank details by ID
exports.deleteBankDetails = async (req, res) => {
  const { id } = req.params;
  try {
    await prisma.bankDetails.delete({
      where: { id },
    });
    res.status(200).json({ message: "Bank details deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete bank details" });
  }
};
