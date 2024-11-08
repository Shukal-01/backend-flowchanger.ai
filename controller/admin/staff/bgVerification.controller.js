
const { PrismaClient } = require("@prisma/client");
const { staffBackgroundVerificationSchema } = require("../../../utils/validations");
const prisma = new PrismaClient();

const getNewFields = (verificationType, data, verificationFile) => {
    let newFields = {};
    switch (verificationType) {
        case 'aadhaar':
            newFields = {
                aadhaar_number: data.aadhaar_number,
                aadhaar_file: JSON.stringify(verificationFile),
            };
            break;

        case 'pan':
            newFields = {
                pan_number: data.pan_number,
                pan_file: JSON.stringify(verificationFile),
            };
            break;

        case 'uan':
            newFields = {
                uan_number: data.uan_number,
                uan_file: JSON.stringify(verificationFile),
            };
            break;

        case 'driving_license':
            newFields = {
                driving_license_number: data.driving_license_number,
                driving_license_file: JSON.stringify(verificationFile),
            };
            break;

        case 'address':
            newFields = {
                current_address: data.current_address,
                permanent_address: data.permanent_address,
                address_file: JSON.stringify(verificationFile),
            };
            break;

        case 'face':
            newFields = {
                face_file: JSON.stringify(verificationFile),
            };
            break;

        default:
            throw new Error("Invalid verification type");
    }
    return newFields;
};

// Function to handle the fetch all staff background verification
const fetchAllStaffBgVerification = async (req, res) => {
    try {
        const { id } = req.params;
        // Ensure that the staff_id is an integer
        const staffBgVerifyData = await prisma.StaffBackgroundVerification.findFirst({
            where: {
                staffId: id
            }
        });
        // If no data found, return 404 response
        if (!staffBgVerifyData) {
            return res.status(404).json({
                status: false,
                message: `No verification data found for staff with id ${id}`,
            });
        }

        // Return the verification data
        return res.status(200).json({
            status: true,
            message: `fetch verification data for staffId=${id}`,
            data: staffBgVerifyData,
        });

    } catch (error) {
        // Send appropriate error response
        return res.status(500).json({
            status: false,
            message: `Error fetching verification data : ${error.message}`,
        });
    }
};

// Function to handle update  staff background verification
const updateStaffBgVerifcation = async (req, res) => {
    try {

        const { id, verificationType } = req.params;
        const verificationData = req.body;

        const verificationFile = req.file;


        // Collect the new fields based on verification type
        let staffVerificationFields = getNewFields(verificationType, verificationData, verificationFile);

        const validateStaffVerificationFields = staffBackgroundVerificationSchema.safeParse(staffVerificationFields);
        if (!validateStaffVerificationFields.success) {
            return res.status(400).json({
                success: false,
                error: "Invalid staff background verification format or length provided",
            })
        }
        // Create a new verification record in the database
        const newStaffVerification = await prisma.StaffBackgroundVerification.upsert({
            where: {
                staffId: id,
            },
            update: {
                ...staffVerificationFields, // Update with the new fields if the record already exists
            },
            create: {
                ...staffVerificationFields, // Create a new record if it doesn't exist
                staffId: id,
            },
        });

        // Return success response
        res.status(201).json({
            status: true,
            message: `update and create verification staff verification data for staffId=${id}`,
            data: newStaffVerification,
        });
    } catch (error) {
        res.status(500).json({
            status: false,
            message: `error in create and update staff verification data : ${error.message}`,
        });
    }
};

// Export the functions staff background verification controller
module.exports = { fetchAllStaffBgVerification, updateStaffBgVerifcation }