const { PrismaClient } = require("@prisma/client");
const {
  leavePolicySchema,
  bulkLeavePolicySchema,
} = require("../../../utils/validations");
const { z } = require("zod");
const prisma = new PrismaClient();

exports.createLeavePolicy = async (req, res) => {
  try {
    const staffId = req.params.id;

    const parsedData = leavePolicySchema.parse({
      ...req.body,
      staffId,
    });

    const leavePolicy = await prisma.leavePolicy.create({
      data: {
        staffId: parsedData.staffId,
        name: parsedData.name,
        allowed_leaves: parsedData.allowed_leaves,
        carry_forward_leaves: parsedData.carry_forward_leaves,
        policy_type: parsedData.policy_type,
        leaveBalance: {
          create: {
            staffId: parsedData.staffId,
            balance: parsedData.allowed_leaves,
            used: 0,
          },
        },
      },
      include: {
        leaveBalance: true,
      },
    });

    res.status(201).json(leavePolicy);
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: error.errors });
    }
    console.error("Error creating leave policy:", error);
    res.status(500).json({ error: "Failed to create leave policy" });
  }
};

exports.getLeavePoliciesByStaff = async (req, res) => {
  try {
    const { staffId } = req.params;

    const leavePolicies = await prisma.leavePolicy.findMany({
      where: { staffId },
      include: { leaveBalance: true },
    });

    if (!leavePolicies.length) {
      return res
        .status(404)
        .json({ error: "No leave policies found for this staff" });
    }

    res.status(200).json(leavePolicies);
  } catch (error) {
    console.error("Error fetching leave policies:", error);
    res.status(500).json({ error: "Failed to fetch leave policies" });
  }
};

exports.updateLeavePolicy = async (req, res) => {
  try {
    const { id } = req.params;

    const parsedData = leavePolicySchema
      .omit({ staffId: true })
      .parse(req.body);

    const updatedPolicy = await prisma.leavePolicy.update({
      where: { id },
      data: {
        name: parsedData.name,
        allowed_leaves: parsedData.allowed_leaves,
        carry_forward_leaves: parsedData.carry_forward_leaves,
        policy_type: parsedData.policy_type,
        leaveBalance: {
          update: {
            balance: parsedData.allowed_leaves,
          },
        },
      },
      include: { leaveBalance: true },
    });

    res.status(200).json(updatedPolicy);
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: error.errors });
    }
    console.error("Error updating leave policy:", error);
    res.status(500).json({ error: "Failed to update leave policy" });
  }
};

exports.deleteLeavePolicy = async (req, res) => {
  try {
    const { id } = req.params;

    await prisma.leavePolicy.delete({
      where: { id },
    });

    res.status(200).json({ message: "Leave policy deleted successfully" });
  } catch (error) {
    console.error("Error deleting leave policy:", error);
    res.status(500).json({ error: "Failed to delete leave policy" });
  }
};

exports.createBulkLeavePolicy = async (req, res) => {
  try {
    console.log(req.body);
    const parsedData = bulkLeavePolicySchema.parse(req.body);

    for (const staffId of req.body.staffIds) {
      await prisma.leavePolicy.create({
        data: {
          staffId: staffId,
          name: parsedData.name,
          allowed_leaves: parsedData.allowed_leaves,
          carry_forward_leaves: parsedData.carry_forward_leaves,
          policy_type: parsedData.policy_type,
          leaveBalance: {
            create: {
              staffId: staffId,
              balance: parsedData.allowed_leaves,
              used: 0,
            },
          },
        },
        include: { leaveBalance: true },
      });
    }

    res.status(201).json({
      message: "Leave policies created successfully",
    });
  } catch (error) {
    console.log(error);
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: error.errors });
    }

    console.error("Error creating leave policies:", error);
    res.status(500).json({ error: "Failed to create leave policies" });
  }
};
