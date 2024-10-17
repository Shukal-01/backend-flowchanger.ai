const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { multipleStaffBankDetailSchema } = require("../../utils/validations.js");

// fetch all attendence automation rule 
const fetchAllStaffBankDetails = async (req, res) => {
    try {
        const allStaffBankDetails = await prisma.bankDetails.findMany();
        res.status(200).json({
            success: true,
            message: "Fetch all staff bank details successfully",
            data: allStaffBankDetails
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            error: "Failed to fetch all staff bank details"
        });
    }
}

// updated automation rule for single or multiple staff
const addAndUpdateBankDetailsForStaffs = async (req, res) => {
    const multiple_staff_bank_accounts = req.body;

    try {
        const validateMultipleStaffBankDetails = multipleStaffBankDetailSchema.safeParse(req.body);
        if (!validateMultipleStaffBankDetails.success) {
            return res.status(400).json({
                success: false,
                error: "Invalid staff multiple bank details format or length provided",
            })
        }

        // Prepare the promises for updating or creating bank details for
        const multipleStaffBankDetailsPromise = multiple_staff_bank_accounts.map(async ({ staff_id, bank_name, account_number, account_holder_name, branch_name, ifsc_code }) => {
            return await prisma.bankDetails.upsert({
                where: { staffId: staff_id }, // Unique identifier for the automation rule for specific staff member
                update: {
                    bank_name: bank_name,
                    account_number: account_number,
                    account_holder_name: account_holder_name,
                    branch_name: branch_name,
                    ifsc_code: ifsc_code
                },
                create: {
                    staffId: staff_id,
                    bank_name: bank_name,
                    account_number: account_number,
                    account_holder_name: account_holder_name,
                    branch_name: branch_name,
                    ifsc_code: ifsc_code
                }
            });
        });

        // Wait for all updates to complete
        const multiStaffpleBankDetailRes = await Promise.all(multipleStaffBankDetailsPromise);

        // Send a success response
        res.status(200).json({
            success: true,
            message: "multiple staff bank details created or updated for staffIds successfully.",
            data: multiStaffpleBankDetailRes,
        });
    } catch (error) {
        console.error("Error in creating or updating automation rules for staffIds:", error);
        res.status(500).json({
            success: false,
            error: "Failed to create or update automation rules for staffIds: " + error.message,
        });
    }
};

module.exports = {
    fetchAllStaffBankDetails,
    addAndUpdateBankDetailsForStaffs,
};
