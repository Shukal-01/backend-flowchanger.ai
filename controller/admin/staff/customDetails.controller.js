const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const customFieldDetails = async (req, res) => {
  try {
    const { id, staffId, field_name, field_value } = req.body;

    let newCustomDetails;

    if (id) {
      // Pehle check karo ki given id ke sath koi record hai ya nahi
      const existingCustomField = await prisma.customDetails.findFirst({
        where: {
          id: id,
        },
      });

      if (existingCustomField) {
        // Agar record milta hai, to usko update karo
        newCustomDetails = await prisma.customDetails.update({
          where: {
            id: id,
          },
          data: {
            staffId,
            field_name,
            field_value,
          },
        });
        res
          .status(200)
          .json({
            message: "Custom field updated successfully",
            data: newCustomDetails,
          });
      } else {
        // Agar id milti nahi hai, to naya record create karo
        newCustomDetails = await prisma.customDetails.create({
          data: {
            staffId,
            field_name,
            field_value,
          },
        });
        res
          .status(201)
          .json({
            message: "Custom field created successfully",
            data: newCustomDetails,
          });
      }
    } else {
      // Agar id nahi di gayi hai to naya record create karo
      newCustomDetails = await prisma.customDetails.create({
        data: {
          staffId,
          field_name,
          field_value,
        },
      });
      res
        .status(201)
        .json({
          message: "Custom field created successfully",
          data: newCustomDetails,
        });
    }
  } catch (error) {
    console.error("Error processing custom field:", error);
    res
      .status(500)
      .json({
        message: "Failed to process custom details!",
        error: error.message,
      });
  }
};

// Get All Custom Fields
const getAllCustomFields = async (req, res) => {
  try {
    const customDetails = await prisma.customDetails.findMany({});
    res.status(200).json(customDetails);
  } catch (error) {
    console.log(error);
    res
      .status(500)
      .json({
        error: "Failed to fetch custom details",
        details: error.message,
      });
  }
};

// update custom fields by id
const updateCustomFields = async (req, res) => {
  const { id } = req.params;
  const { staffId, field_name, field_value } = req.body;
  try {
    const update = await prisma.customDetails.update({
      where: { id },
      data: {
        staffId,
        field_name,
        field_value,
      },
    });
    return res
      .status(200)
      .json({ status: 200, message: "custom fields Successfully Updated!" });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "custom fields Not Found (" + id + ")" });
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
      return res
        .status(400)
        .json({
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
      return res
        .status(200)
        .json({
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
    return res
      .status(500)
      .json({
        status: 500,
        message: "failed to delete this (" + id + ") custom id!",
      });
  }
};

module.exports = {
  customFieldDetails,
  getAllCustomFields,
  getCustomFieldById,
  deleteCustomFields,
  updateCustomFields,
};
