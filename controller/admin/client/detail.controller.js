const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { clientSchema, idSchema } = require("../../../utils/validations.js");

const addNewClient = async (req, res) => {
    try {
        const {
            company, vat_number, phone, website, groups, currency,
            default_language, address, country, state, city, zip_code, status
        } = req.body;

        const validateNewClientData = clientSchema.safeParse(req.body);
        if (!validateNewClientData.success) {
            return res.status(400).json({
                success: false,
                message: "Invalid new client data provided",
            })
        }
        const newClient = await prisma.client.create({
            data: {
                status,
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
            },
        });

        return res.status(201).json({
            status: true,
            data: newClient,
            message: "New client created successfully"
        });
    } catch (error) {
        console.error("Error creating client:", error);
        return res.status(500).json({ status: false, message: "An error occurred while creating clients." + error.message });
    }
};

const fetchAllClients = async (req, res) => {
    try {
        const clients = await prisma.client.findMany();
        if (!clients) {
            return res.status(404).json({ status: false, message: "No client found!" });
        }
        return res.status(200).json({ status: true, data: clients, message: "Fetch all client data successfully" });
    } catch (error) {
        console.error("Error in fetching all clients data:", error);
        return res.status(500).json({ status: false, message: "An error occurred while fetching all clients." + error.message });
    }
};

const updateSpecificClient = async (req, res) => {
    const { id } = req.params;
    const {
        company, vat_number, phone, website, groups, currency,
        default_language, address, country, state, city, zip_code, status
    } = req.body;
    try {
        const validateId = idSchema.safeParse(id);
        const validateNewClientData = clientSchema.safeParse(req.body);
        if (!validateNewClientData.success || !validateId.success) {
            return res.status(400).json({
                success: false,
                message: "Invalid updated client data and id provided",
            })
        }
        const findClient = await prisma.client.findUnique({
            where: {
                id: id,
            },
        });
        if (!findClient) {
            return res.status(404).json({ status: false, message: "Client not found!" });
        }
        const updatedClient = await prisma.client.update({
            where: {
                id: id
            },
            data: {
                status: status,
                company: company,
                vat_number: vat_number,
                phone: phone,
                website: website,
                groups: [...findClient.groups, ...groups],
                currency: [...findClient.currency, ...currency],
                default_language: [...findClient.default_language, ...default_language],
                address: address,
                country: country,
                state: state,
                city: city,
                zip_code: zip_code
            },
        })
        return res.json({ status: true, data: updatedClient, message: "client updated successfully!" });
    } catch (error) {
        console.log("Error in updating client:", error);
        return res.status(500).json({ status: false, message: "An error occurred while updating the client." });
    }
}

const deleteSpecificClient = async (req, res) => {
    const id = req.params.id;


    try {
        const validateId = idSchema.safeParse(id);
        if (!validateId.success) {
            return res.status(400).json({
                success: false,
                message: "Invalid id provided",
            })
        }
        const findClient = await prisma.client.findUnique({
            where: {
                id: id,
            },
        });
        if (!findClient) {
            return res.status(404).json({ status: false, message: "Client not found!" });
        }
        await prisma.client.delete({
            where: { id: id },
        });
        return res.status(200).json({ status: true, message: "Client of id:" + id + "deleted successfully!" });
    } catch (error) {
        console.error("Error deleting customer:", error);
        if (error.code === 'P2025') {
            return res.status(404).json({ status: 404, message: "Customer not found!" });
        }
        return res.status(500).json({ status: false, message: "An error occurred while deleting the client." });
    }
};

const fetchClientInfoSpecificID = async (req, res) => {
    const id = req.params.id;

    try {
        const validateId = idSchema.safeParse(id);
        if (!validateId.success) {
            return res.status(400).json({
                success: false,
                message: "Invalid id provided",
            })
        }
        const client = await prisma.client.findUnique({
            where: { id: id },
        });
        if (!client) {
            return res.status(404).json({ status: false, message: "Client not found!" });
        }
        return res.status(200).json({ status: true, data: client, message: "Client Detail of " + id + " fetched successfully" });
    } catch (error) {
        console.error("Error fetching speciific client of id:" + id + " ", error);
        return res.status(500).json({ status: false, message: "An error occurred while fetching the specific client" });
    }
};

module.exports = { addNewClient, fetchAllClients, deleteSpecificClient, updateSpecificClient, fetchClientInfoSpecificID }