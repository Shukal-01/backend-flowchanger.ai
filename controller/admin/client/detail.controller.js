const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { clientSchema, idSchema } = require("../../../utils/validations.js");

const createClient = async (req, res) => {
  const validation = clientSchema.safeParse(req.body);

  if (!validation.success) {
    return res.status(400).json({
      error: "Invalid data format",
      issues: validation.error.format(),
    });
  }

  const {
    email,
    company,
    vat_number,
    phone,
    website,
    groups,
    currency,
    default_language,
    address,
    country,
    state,
    city,
    zip_code,
    status,
  } = validation.data;
  try {
    const newClient = await prisma.user.create({
      data: {
        email: req.body.email,
        role: "CLIENT",
        is_verified: false,
        mobile: phone,
        name: req.body.name,

        clientDetails: {
          create: {
            company,
            vat_number,
            website,
            groups,
            currency,
            default_language,
            address,
            country,
            state,
            city,
            zip_code,
            status,
          },
        },
      },
      include: { clientDetails: true },
    });

    res.status(201).json(newClient);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Failed to create client",
      details: error.message,
    });
  }
};

const fetchAllClients = async (req, res) => {
  try {
    const clients = await prisma.user.findMany({
      where: {
        role: "CLIENT",
      },
      include: {
        clientDetails: true,
      },
    });

    return res.status(200).json({
      status: true,
      data: clients,
      message: "Fetched all client data successfully",
    });
  } catch (error) {
    console.error("Error fetching all clients:", error);
    return res.status(500).json({
      status: false,
      message: "An error occurred while fetching all clients: " + error.message,
    });
  }
};

const updateSpecificClient = async (req, res) => {
  const { id } = req.params;
  const {
    company,
    vat_number,
    website,
    groups,
    currency,
    default_language,
    address,
    country,
    state,
    city,
    zip_code,
    status,
  } = req.body;

  try {
    const validateId = idSchema.safeParse(id);
    const validateNewClientData = clientSchema.safeParse(req.body);

    if (!validateNewClientData.success || !validateId.success) {
      console.log(validateNewClientData, validateId);
      return res.status(400).json({
        success: false,
        message: "Invalid updated client data or id provided",
      });
    }

    const updatedClient = await prisma.clientDetails.update({
      where: { id },
      data: {
        company,
        vat_number,
        website,
        groups,
        currency,
        default_language,
        address,
        country,
        state,
        city,
        zip_code,
        status,
      },
      include: {
        user: {
          select: {
            email: true,
            is_verified: true,
          },
        },
      },
    });

    return res.status(200).json({
      status: true,
      data: updatedClient,
      message: "Client updated successfully",
    });
  } catch (error) {
    console.error("Error updating client:", error);
    return res.status(500).json({
      status: false,
      message: "An error occurred while updating the client: " + error.message,
    });
  }
};

const changeStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  try {
    await prisma.clientDetails.update({
      where: { id },
      data: { status },
    });

    return res.status(200).json({
      status: true,
      message: "Client status updated successfully",
    });
  } catch (error) {
    console.error("Error updating client status:", error);
    return res.status(500).json({
      status: false,
      message: "An error occurred while updating the client status",
    });
  }
};

const deleteSpecificClient = async (req, res) => {
  const { id } = req.params;

  try {
    const validateId = idSchema.safeParse(id);
    if (!validateId.success) {
      return res.status(400).json({
        success: false,
        message: "Invalid id provided",
      });
    }

    const client = await prisma.clientDetails.findUnique({
      where: { id },
      select: { userId: true },
    });

    if (!client) {
      return res.status(404).json({
        status: false,
        message: "Client not found",
      });
    }

    await prisma.clientDetails.delete({ where: { id } });
    await prisma.user.delete({ where: { id: client.userId } });

    return res.status(200).json({
      status: true,
      message: `Client with id ${id} and associated user deleted successfully`,
    });
  } catch (error) {
    console.error("Error deleting client:", error);
    return res.status(500).json({
      status: false,
      message: "An error occurred while deleting the client",
    });
  }
};

const fetchClientInfoSpecificID = async (req, res) => {
  const { id } = req.params;

  try {
    const validateId = idSchema.safeParse(id);
    if (!validateId.success) {
      return res.status(400).json({
        success: false,
        message: "Invalid id provided",
      });
    }

    const client = await prisma.clientDetails.findUnique({
      where: { id },
      include: {
        user: {
          select: {
            email: true,
            is_verified: true,
          },
        },
      },
    });

    if (!client) {
      return res.status(404).json({
        status: false,
        message: "Client not found",
      });
    }

    return res.status(200).json({
      status: true,
      data: client,
      message: `Client details for id ${id} fetched successfully`,
    });
  } catch (error) {
    console.error("Error fetching client by ID:", error);
    return res.status(500).json({
      status: false,
      message: "An error occurred while fetching the client details",
    });
  }
};

module.exports = {
  createClient,
  fetchAllClients,
  updateSpecificClient,
  deleteSpecificClient,
  fetchClientInfoSpecificID,
  changeStatus,
};
