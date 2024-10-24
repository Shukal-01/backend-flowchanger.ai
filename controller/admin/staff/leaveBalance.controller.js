const { PrismaClient } = require("@prisma/client");
const {
  createLeaveBalanceSchema,
  updateLeaveBalanceSchema,
} = require("../../../utils/validations");
const { z } = require("zod");
const prisma = new PrismaClient();

const getAllLeaveBalances = async (req, res) => {
  try {
    const leaveBalances = await prisma.leaveBalance.findMany({
      include: { staff: true, leavePolicy: true },
    });
    res.json(leaveBalances);
  } catch (error) {
    res.status(500).json({ error: "Unable to retrieve leave balances" });
  }
};

const getLeaveBalanceById = async (req, res) => {
  const { id } = req.params;
  try {
    const leaveBalance = await prisma.leaveBalance.findUnique({
      where: { id },
      include: { staff: true, leavePolicy: true },
    });
    if (!leaveBalance)
      return res.status(404).json({ error: "Leave balance not found" });
    res.json(leaveBalance);
  } catch (error) {
    res.status(500).json({ error: "Unable to retrieve leave balance" });
  }
};

const createLeaveBalance = async (req, res) => {
  try {
    const leaveTypeId = req.params.id;

    const { staffId, balance, used } = createLeaveBalanceSchema.parse({
      ...req.body,
      leaveTypeId,
    });

    const newLeaveBalance = await prisma.leaveBalance.create({
      data: {
        staffId,
        leaveTypeId,
        balance,
        used,
      },
    });

    res.status(201).json(newLeaveBalance);
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: error.errors });
    }
    res.status(500).json({ error: "Unable to create leave balance" });
  }
};

const updateLeaveBalance = async (req, res) => {
  const { id } = req.params;
  try {
    const { balance, used } = updateLeaveBalanceSchema.parse(req.body);

    const updatedLeaveBalance = await prisma.leaveBalance.update({
      where: { id },
      data: { balance, used },
    });

    res.json(updatedLeaveBalance);
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: error.errors });
    }
    res.status(500).json({ error: "Unable to update leave balance" });
  }
};

const deleteLeaveBalance = async (req, res) => {
  const { id } = req.params;
  try {
    await prisma.leaveBalance.delete({ where: { id } });
    res.json({ message: "Leave balance deleted" });
  } catch (error) {
    res.status(500).json({ error: "Unable to delete leave balance" });
  }
};

module.exports = {
  getAllLeaveBalances,
  getLeaveBalanceById,
  createLeaveBalance,
  updateLeaveBalance,
  deleteLeaveBalance,
};
