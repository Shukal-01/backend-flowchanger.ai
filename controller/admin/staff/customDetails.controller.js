const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const customFieldDetails = async (req, res) => {
  try {
    const { staffId, field_name, field_value } = req.body;

    const newCustomDetails = await prisma.customDetails.create({
      data: {
        staffId,
        field_name,
        field_value,
      },
    });

    res.status(201).json(newCustomDetails);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to create custom details!" });
  }
};

// Get All Custom Fields

const getAllCustomfieldDetails = async (req, res) => {
  try {
    const customDetails = await prisma.customDetails.findMany({});
    res.status(200).json(customDetails);
  } catch (error) {
    console.log(error);
    res.status(500).json({
      error: "Failed to fetch custom details",
      details: error.message,
    });
  }
};

// Get Custom Fields By ID

const getCustomFieldById = async (req, res) => {
  const { id } = req.params;
  try {
    const newCustomFieldsId = await prisma.customDetails.findUnique({
      where: { id },
    });
    if (newCustomFieldsId) {
      return res.status(200).json({ status: 200, data: newCustomFieldsId });
    } else {
      return res.status(400).json({
        status: 400,
        message: "custom fields not found for this id (" + id + ")",
      });
    }
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "failed to load custom details by id!" });
  }
};

// Delete custom fields by id

const deleteCustomFields = async (req, res) => {
  const { id } = req.params;
  try {
    const deleteCustomFields = await prisma.customDetails.delete({
      where: { id },
    });
    if (deleteCustomFields) {
      return res.status(200).json({
        status: 200,
        message: "delete custom fields this id (" + id + ")",
      });
    } else {
      return res
        .status(400)
        .json({ status: 400, message: "not found this (" + id + ") id!" });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: 500,
      message: "failed to delete this (" + id + ") custom id!",
    });
  }
};

module.exports = {
  customFieldDetails,
  getAllCustomfieldDetails,
  getCustomFieldById,
  deleteCustomFields,
};
