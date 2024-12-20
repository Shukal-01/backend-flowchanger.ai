const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { clientSchema, idSchema } = require("../../../utils/validations.js");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");


const searchClientByCompanyOrVatNumber = async (req, res) => {
  const { company, vat_number } = req.query;

  try {
    const whereDataArray = {
      user: {
        role: "CLIENT",
      },
    };
    if (company) {
      whereDataArray.company = {
        contains: company,
        mode: "insensitive",
      };
    }

    if (vat_number) {
      whereDataArray.vat_number = {
        contains: vat_number,
        mode: "insensitive",
      };
    }

    const clients = await prisma.clientDetails.findMany({
      where: whereDataArray,
      include: {
        user: true,
      },
    });

    return res.status(200).json(clients);
  } catch (error) {
    console.error("Failed Searching client:", error.message);
    return res.status(500).json({
      status: false,
      message: "Failed Searching client!",
      error: error.message,
    });
  }
};

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
        password: req.body.password ? await bcrypt.hash(req.body.password, 10) : "",
      },
    });
    const clientDetails = await prisma.clientDetails.create({
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
        userId: newClient.id,
      },
    });

    res.status(201).json(clientDetails);
  } catch (error) {
    console.error(error);
    res.status(500).json({
      error: "Failed to create client" + error.message,
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

    return res.status(200).json(clients);
  } catch (error) {
    console.error("Failed fetching all clients:", error);
    return res.status(500).json({
      status: false,
      message: "Failed fetching all clients: " + error.message,
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
    // Check if the clientDetails with the provided id exists
    const client = await prisma.clientDetails.findUnique({
      where: { id: id },
    });

    if (!client) {
      return res.json({
        status: false,
        message: "Client not found.",
      });
    }

    // Proceed with the update if the client exists
    const updatedClient = await prisma.clientDetails.update({
      where: { id: parseInt(id) },
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
    console.error("Failed updating client:", error.message);
    return res.status(500).json({
      status: false,
      message: "Failed updating the client: " + error.message,
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
    console.error("Failed updating client status:", error.message);
    return res.status(500).json({
      status: false,
      message: "Failed the client status" + error.message,
    });
  }
};

const deleteSpecificClient = async (req, res) => {
  const { id } = req.params;
  if (id === "bulk") {
    return deleteBulkClient(req, res);
  }
  else {

    try {
      const validateId = idSchema.safeParse(id);
      if (!validateId.success) {
        return res.status(400).json({
          message: "Invalid id provided",
        });
      }

      const client = await prisma.clientDetails.findUnique({
        where: { id },
        select: { userId: true },
      });

      if (!client) {
        return res.status(404).json({
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
      console.error("Failed deleting client:", error.message);
      return res.status(500).json({
        message: "Failed while deleting the client" + error.message,
      });
    }
  }
};
const deleteBulkClient = async (req, res) => {
  const ids = req.body; // expecting an array of client UUIDs

  try {
    // Validate the array of IDs
    if (!Array.isArray(ids) || ids.length === 0) {
      return res.status(400).json({
        message: "Invalid Id provided",
      });
    }

    // Validate each ID individually using idSchema
    for (const id of ids) {
      const validateId = idSchema.safeParse(id);
      if (!validateId.success) {
        return res.status(400).json({
          message: `Invalid ID provided: ${id}`,
        });
      }
    }

    // Retrieve clients to get associated userIds
    const clients = await prisma.clientDetails.findMany({
      where: { userId: { in: ids } },
      select: { id: true, userId: true },
    });

    if (clients.length === 0) {
      return res.status(404).json({
        message: "Client not found",
      });
    }

    // Extract client and user IDs for deletion
    const clientIds = clients.map(client => client.id);
    const userIds = clients.map(client => client.userId);

    // Delete clients and associated users in bulk
    await prisma.clientDetails.deleteMany({
      where: { id: { in: clientIds } },
    });
    await prisma.user.deleteMany({
      where: { id: { in: userIds } },
    });

    return res.status(200).json({
      success: true,
      message: "Clients and associated users deleted successfully",
    });
  } catch (error) {
    console.error("Failed deleting clients:", error.message);
    return res.status(500).json({
      success: false,
      message: "Failed while deleting the clients: " + error.message,
    });
  }
};


const fetchClientInfoSpecificID = async (req, res) => {
  const { id } = req.params;

  try {
    const validateId = idSchema.safeParse(id);
    if (!validateId.success) {
      return res.status(400).json({
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
        message: "Client not found",
      });
    }

    return res.status(200).json({
      data: client,
      message: `Client details for id ${id} fetched successfully`,
    });
  } catch (error) {
    console.error("Failed fetching client :", error.message);
    return res.status(500).json({
      message: "Failed while fetching the client details" + error.message,
    });
  }
};

const loginClient = (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({
      status: false,
      message: "Email and password are required",
    });
  }

  prisma.user
    .findUnique({
      where: { email, role: "CLIENT" },
    })
    .then((user) => {
      if (!user) {
        return res.status(404).json({
          message: "Client not found",
        });
      }
      const isPasswordMatch = bcrypt.compareSync(password, user.password);
      if (!isPasswordMatch) {
        return res.status(401).json({
          message: "Invalid password" + error.message,
        });
      }
      const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET);
      return res.status(200).json({
        message: "Login successful",
        token,
      });
    })
    .catch((error) => {
      console.error("Error during login:", error.message);
      return res.status(500).json({
        message: "Error during login",
      });
    });
};

module.exports = {
  createClient,
  fetchAllClients,
  updateSpecificClient,
  deleteSpecificClient,
  fetchClientInfoSpecificID,
  changeStatus,
  loginClient,
  searchClientByCompanyOrVatNumber
};
