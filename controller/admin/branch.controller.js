const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { ZodError } = require("zod");
const { BranchSchema } = require("../../utils/validations");

const createBranch = async (req, res) => {
  try {
    const { branchName } = req.body;

    const branchResult = BranchSchema.safeParse({
      branchName,
    });
    const branch = await prisma.branch.create({
      data: branchResult.data,
    });
    res.status(201).json(branch);
  } catch (error) {
    if (error instanceof ZodError) {
      res.status(400).json({ message: error.message });
    } else {
      console.log(error);
      res.status(500).json({ message: "Failed to create branch" });
    }
  }
};

const getAllBranch = async (req, res) => {
  try {
    const branches = await prisma.branch.findMany({
      include: {
        StaffDetails: true,
      },
    });
    res.status(200).json(branches);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch branches" });
  }
};

const deleteBranch = async (req, res) => {
  try {
    const { id } = req.params;
    const deletedBranch = await prisma.branch.delete({
      where: { id: id },
    });
    res
      .status(200)
      .json({ message: "Branch deleted successfully", deletedBranch });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Failed to delete branch" });
  }
};

const updateBranch = async (req, res) => {
  try {
    const { id } = req.params;
    const { branchName } = req.body;

    const branchResult = BranchSchema.safeParse({
      branchName,
    });

    const updatedBranch = await prisma.branch.update({
      where: { id: id },
      data: { branchName: branchResult.data.branchName },
    });

    res
      .status(200)
      .json({ message: "Branch updated successfully", updatedBranch });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Failed to update branch" });
  }
};

module.exports = { createBranch, getAllBranch, deleteBranch, updateBranch };
