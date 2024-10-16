const { PrismaClient } = require("@prisma/client");
const {
  createLeaveRequestSchema,
  updateLeaveRequestSchema,
} = require("../../../utils/validations");
const prisma = new PrismaClient();

const getAllLeaveRequests = async (req, res) => {
  try {
    const leaveRequests = await prisma.leaveRequest.findMany({
      include: { staff: true, leavePolicy: true },
    });
    res.json(leaveRequests);
  } catch (error) {
    res.status(500).json({ error: "Unable to retrieve leave requests" });
  }
};

const getLeaveRequestById = async (req, res) => {
  const { id } = req.params;
  try {
    const leaveRequest = await prisma.leaveRequest.findUnique({
      where: { id },
      include: { staff: true, leavePolicy: true },
    });
    if (!leaveRequest)
      return res.status(404).json({ error: "Leave request not found" });
    res.json(leaveRequest);
  } catch (error) {
    res.status(500).json({ error: "Unable to retrieve leave request" });
  }
};

const createLeaveRequest = async (req, res) => {
  const staffId = req.params.id;
  try {
    const { leaveTypeId, request_date, start_date, end_date, status } =
      createLeaveRequestSchema.parse({
        ...req.body,
        staffId,
      });

    const newLeaveRequest = await prisma.leaveRequest.create({
      data: {
        staffId,
        leaveTypeId,
        request_date,
        start_date,
        end_date,
        status,
      },
    });

    res.status(201).json(newLeaveRequest);
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: error.errors });
    }
    console.log(error);
    res.status(500).json({ error: "Unable to create leave request" });
  }
};

const updateLeaveRequest = async (req, res) => {
  const { id } = req.params;
  try {
    const { status } = updateLeaveRequestSchema.parse(req.body);

    const updatedLeaveRequest = await prisma.leaveRequest.update({
      where: { id },
      data: { status, ...req.body },
    });

    res.json(updatedLeaveRequest);
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: error.errors });
    }
    res.status(500).json({ error: "Unable to update leave request" });
  }
};

const deleteLeaveRequest = async (req, res) => {
  const { id } = req.params;
  try {
    await prisma.leaveRequest.delete({ where: { id } });
    res.json({ message: "Leave request deleted" });
  } catch (error) {
    res.status(500).json({ error: "Unable to delete leave request" });
  }
};

module.exports = {
  getAllLeaveRequests,
  getLeaveRequestById,
  createLeaveRequest,
  updateLeaveRequest,
  deleteLeaveRequest,
};
