const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { attendenceAutomationRuleSchema } = require("../../../utils/validations.js");

// fetch all attendence automation rule 
const fetchAllStaftAutomationAttendence = async (req, res) => {
    try {
        const allStaffWithAttendenceRules = await prisma.attendanceAutomationRule.findMany({

        });
        res.status(200).json({
            success: true,
            message: "Fetch all automation rules for staff successfully",
            data: allStaffWithAttendenceRules
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            error: "Failed to fetch all automation rules for staff"
        });
    }
}

// updated automation rule for single or multiple staff
const addAndUpdateAutomationRuleForStaffs = async (req, res) => {
    const { staff_ids, automation_rules = {} } = req.body;

    const {
        auto_absent,
        present_on_punch,
        auto_half_day,
        mandatory_half_day,
        mandatory_full_day
    } = automation_rules;

    try {

        const validateAutomationRule = attendenceAutomationRuleSchema.safeParse(req.body);
        if (!validateAutomationRule.success) {
            return res.status(400).json({
                success: false,
                error: "Invalid automation rule format or length provided of staffIds",
            })
        }

        // Prepare the promises for updating or creating automation rules
        const updatePromises = staff_ids.map(async (staff_id) => {
            return await prisma.attendanceAutomationRule.upsert({
                where: { staffId: staff_id }, // Unique identifier for the automation rule for specific staff member
                update: {
                    auto_absent: auto_absent || false,
                    present_on_punch: present_on_punch || false,
                    auto_half_day: auto_half_day,
                    manadatory_half_day: mandatory_half_day,
                    manadatory_full_day: mandatory_full_day
                },
                create: {
                    staffId: staff_id, // Creating connection to specific staff member 
                    auto_absent: auto_absent || false,
                    present_on_punch: present_on_punch || false,
                    auto_half_day: auto_half_day,
                    manadatory_half_day: mandatory_half_day,
                    manadatory_full_day: mandatory_full_day
                }
            });
        });

        // Wait for all updates to complete
        const updatedAutomationRules = await Promise.all(updatePromises);

        // Send a success response
        res.status(200).json({
            success: true,
            message: "Attendance automation rules created or updated for staffIds successfully.",
            data: updatedAutomationRules,
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
    fetchAllStaftAutomationAttendence,
    addAndUpdateAutomationRuleForStaffs,
};
