const express = require("express");
const { PrismaClient } = require("@prisma/client");
const { param } = require("../../router/routes");
const { ZodError } = require("zod");
const { salaryDetailsSchema, deductionsEarningsSchema } = require("../../utils/validations.js");
const app = express();
const prisma = new PrismaClient();

app.use(express.json());


const addOrUpdateSalaryDetails = async (req, res) => {
  try {
    // Validate request data
    const validation = salaryDetailsSchema.safeParse(req.body);
    if (!validation.success) {
      return res.status(400).json({
        success: false,
        message: "Validation error",
        errors: validation.error.errors,
      });
    }

    const {
      effective_date,
      salary_type,
      ctc_amount,
      employer_pf,
      employer_esi,
      employer_lwf,
      employee_pf,
      employee_esi,
      professional_tax,
      tds,
      employee_lwf,
      staffId,
    } = validation.data;

    const {
      deductions = [], // Default to empty array
      earnings = [],   // Default to empty array
    } = req.body;

    const formattedEffectiveDate = new Date(effective_date);

    // Check if a record with the same staffId and effective_date exists
    const existingSalaryDetails = await prisma.salaryDetails.findFirst({
      where: {
        staffId: staffId,
        effective_date: formattedEffectiveDate,
      },
    });

    // Process deductions
    await Promise.all(deductions.map(async (deduction) => {
      const existingDeduction = await prisma.deductions.findFirst({
        where: {
          staffId: staffId,
          heads: deduction.heads,
        },
      });

      if (existingDeduction) {
        // Update existing deduction
        await prisma.deductions.update({
          where: { id: existingDeduction.id },
          data: {
            calculation: deduction.calculation,
            amount: deduction.amount,
          },
        });
      } else {
        // Create new deduction
        await prisma.deductions.create({
          data: {
            heads: deduction.heads,
            calculation: deduction.calculation,
            amount: deduction.amount,
            staffId: staffId,
          },
        });
      }
    }));

    // Process earnings
    await Promise.all(earnings.map(async (earning) => {
      const existingEarning = await prisma.earnings.findFirst({
        where: {
          staffId: staffId,
          heads: earning.heads,
        },
      });

      if (existingEarning) {
        // Update existing earning
        await prisma.earnings.update({
          where: { id: existingEarning.id },
          data: {
            calculation: earning.calculation,
            amount: earning.amount,
          },
        });
      } else {
        // Create new earning
        await prisma.earnings.create({
          data: {
            heads: earning.heads,
            calculation: earning.calculation,
            amount: earning.amount,
            staffId: staffId,
          },
        });
      }
    }));

    if (existingSalaryDetails) {
      // Update the existing record for the same effective date
      const updatedSalaryDetails = await prisma.salaryDetails.update({
        where: { id: existingSalaryDetails.id },
        data: {
          salary_type: salary_type || existingSalaryDetails.salary_type,
          ctc_amount: parseFloat(ctc_amount) || existingSalaryDetails.ctc_amount,
          employer_pf: parseFloat(employer_pf) || existingSalaryDetails.employer_pf,
          employer_esi: parseFloat(employer_esi) || existingSalaryDetails.employer_esi,
          employer_lwf: parseFloat(employer_lwf) || existingSalaryDetails.employer_lwf,
          employee_pf: parseFloat(employee_pf) || existingSalaryDetails.employee_pf,
          employee_esi: parseFloat(employee_esi) || existingSalaryDetails.employee_esi,
          professional_tax: parseFloat(professional_tax) || existingSalaryDetails.professional_tax,
          employee_lwf: parseFloat(employee_lwf) || existingSalaryDetails.employee_lwf,
          tds: parseFloat(tds) || existingSalaryDetails.tds,
        },
      });
      res.status(200).json({
        success: true,
        message: "Salary details updated successfully",
        data: updatedSalaryDetails,
      });
    } else {
      // Create a new record if the effective date has changed
      const newSalaryDetails = await prisma.salaryDetails.create({
        data: {
          effective_date: validation.data.effective_date,
          salary_type: validation.data.salary_type || null,
          ctc_amount: parseFloat(validation.data.ctc_amount) || null,
          employer_pf: parseFloat(employer_pf) || null,
          employer_esi: parseFloat(employer_esi) || null,
          employer_lwf: parseFloat(employer_lwf) || null,
          employee_pf: parseFloat(employee_pf) || null,
          employee_esi: parseFloat(employee_esi) || null,
          professional_tax: parseFloat(professional_tax) || null,
          employee_lwf: parseFloat(employee_lwf) || null,
          tds: parseFloat(tds) || null,
          staffId: staffId,
        },
      });
      res.status(201).json({
        success: true,
        message: "Salary details added successfully",
        data: newSalaryDetails,
      });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({
      success: false,
      message: "Error adding or updating salary details",
      error: error.message,
    });
  }
};





// Salary Data Fetch By Id:

const getSalaryDetailsById = async (req, res) => {
  const { id } = req.params;
  try {
    const getById = await prisma.salaryDetails.findUnique({
      where: { id },
      include: {
        earnings: true,
        deductions: true,
      },
    });
    return res
      .status(200)
      .json({ status: 200, message: "Get Salaary Data By ID!", data: getById });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "Failed To get Salary Data By ID!" });
  }
};

// Salary Details Fetch All Data:

const getAllSalaryData = async (req, res) => {
  try {
    const earningData = await prisma.earnings.findMany();
    const deductionData = await prisma.deductions.findMany();
    const salaryData = await prisma.salaryDetails.findMany();

    // Check if there is any salary data
    if (salaryData.length === 0) {
      return res.status(404).json({
        status: 404,
        message: "No salary data found.",
        data: [],
      });
    }

    // Merging salary data with related earnings and deductions based on staffId
    const mergedData = salaryData.map((salary) => {
      const earnings = earningData.filter(
        (earning) => earning.staffId === salary.staffId
      );
      const deductions = deductionData.filter(
        (deduction) => deduction.staffId === salary.staffId
      );
      return {
        ...salary,
        earnings: earnings.length > 0 ? earnings : null,
        deductions: deductions.length > 0 ? deductions : null,
      };
    });

    // Send the merged data as the response
    return res.status(200).json({
      status: 200,
      message: "Successfully retrieved all salary data with related earnings and deductions.",
      data: mergedData,
    });
  } catch (error) {
    console.log("Error:", error);
    return res.status(500).json({
      status: 500,
      message: "An error occurred while fetching salary data.",
      error: error.message,
    });
  }
};



// Update Salary Data

const updateSalaryData = async (req, res) => {
  const { id } = req.params;

  const {
    effective_date,
    salary_type,
    ctc_amount,
    employer_pf,
    employer_esi,
    employer_lwf,
    employee_pf,
    employee_esi,
    professional_tax,
    employee_lwf,
    tds,
    earnings = [], // Array of earnings objects, default to empty array
    deductions = [], // Array of deductions objects, default to empty array
  } = req.body;

  try {
    // Update the salary details
    const updatedSalaryDetails = await prisma.salaryDetails.update({
      where: { id },
      data: {
        effective_date: new Date(effective_date),
        salary_type,
        ctc_amount: ctc_amount ? parseFloat(ctc_amount) : undefined,
        employer_pf: employer_pf ? parseFloat(employer_pf) : undefined,
        employer_esi: employer_esi ? parseFloat(employer_esi) : undefined,
        employer_lwf: employer_lwf ? parseFloat(employer_lwf) : undefined,
        employee_pf: employee_pf ? parseFloat(employee_pf) : undefined,
        employee_esi: employee_esi ? parseFloat(employee_esi) : undefined,
        professional_tax: professional_tax ? parseFloat(professional_tax) : undefined,
        employee_lwf: employee_lwf ? parseFloat(employee_lwf) : undefined,
        tds: tds ? parseFloat(tds) : undefined,
      },
    });

    const staffId = updatedSalaryDetails.staffId;

    // Update or create deductions details based on 'heads'
    await Promise.all(
      deductions.map(async (deduction) => {
        const existingDeduction = await prisma.deductions.findFirst({
          where: {
            staffId: staffId,
            heads: deduction.heads,
          },
        });

        // const salaryId = updatedSalaryDetails.id || '';

        if (existingDeduction) {
          // If deduction exists, update it
          await prisma.deductions.update({
            where: { id: existingDeduction.id },
            data: {
              calculation: deduction.calculation,
              amount: deduction.amount !== null ? parseFloat(deduction.amount) : null,
            },
          });
        } else {
          // If deduction does not exist, create a new one
          await prisma.deductions.create({
            data: {
              heads: deduction.heads,
              calculation: deduction.calculation,
              amount: deduction.amount !== null ? parseFloat(deduction.amount) : null,
              salaryId: salaryId,
              staffId: staffId,
            },
          });
        }
      })
    );

    // Update or create earnings details based on 'heads'
    await Promise.all(
      earnings.map(async (earning) => {
        const existingEarning = await prisma.earnings.findFirst({
          where: {
            staffId: staffId,
            heads: earning.heads,
          },
        });

        // const salaryId = updatedSalaryDetails.id || '';

        if (existingEarning) {
          // If earning exists, update it
          await prisma.earnings.update({
            where: { id: existingEarning.id },
            data: {
              calculation: earning.calculation,
              amount: earning.amount !== null ? parseFloat(earning.amount) : null,
            },
          });
        } else {
          // If earning does not exist, create a new one
          await prisma.earnings.create({
            data: {
              heads: earning.heads,
              calculation: earning.calculation,
              amount: earning.amount !== null ? parseFloat(earning.amount) : null,
              // salaryId: salaryId,
              staffId: staffId,
            },
          });
        }
      })
    );

    return res.json({
      status: 200,
      message: "Salary Data Successfully Updated!",
      data: { updatedSalaryDetails },
    });
  } catch (error) {
    console.error("Error updating salary data:", error);
    return res.status(500).json({
      status: 500,
      message: "Error updating salary data",
      error: error.message,
    });
  }
};





// Delete Salary Data Record By ID

const deleteSalaryRecord = async (req, res) => {
  const { id } = req.params;

  try {
    // First, retrieve the salary record to get the associated staffId
    const salaryRecord = await prisma.salaryDetails.findUnique({
      where: { id },
      select: { staffId: true }
    });
    if (!salaryRecord) {
      return res.status(404).json({
        status: 404,
        message: "Salary Record Not Found!",
      });
    }

    // Delete related earnings based on staffId
    await prisma.earnings.deleteMany({
      where: { staffId: salaryRecord.staffId },
    });

    // Delete related deductions based on staffId
    await prisma.deductions.deleteMany({
      where: { staffId: salaryRecord.staffId },
    });
    // Now delete the salary record
    const deleteRecord = await prisma.salaryDetails.delete({
      where: { id },
    });

    return res.status(200).json({
      status: 200,
      message: "Salary Record Deleted Successfully!",
      data: deleteRecord,
    });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "Error deleting record: " + error.message });
  }
};



// ------------------------------
// Deductions API
// --------------------------------

const deductions = async (req, res) => {
  try {
    const validation = deductionsEarningsSchema.safeParse(req.body);
    if (validation.error) {
      return res.status(400).json({
        success: false,
        message: validation.error.details[0].message
      })
    }
    const { staffId, heads } = validation.data;
    if (!staffId || !heads) {
      return res.status(400).json({ success: false, message: "Staff ID and heads are required." });
    }
    const deductionData = await prisma.deductions.create({
      data: {
        staffId: validation.data.staffId,
        heads: validation.data.heads
      }
    })
    return res.status(201).json({
      status: 201,
      message: "Deduction created successfully.",
      data: deductionData,
    })
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      status: 500,
      message: "Error creating deductions.",
      error: error.message,
    });
  }
}

const updateDeductions = async (req, res) => {
  try {
    const validation = deductionsEarningsSchema.safeParse(req.body);
    if (validation.error) {
      return res.status(400).json({
        success: false,
        message: validation.error.details[0].message
      })
    }
    const { headId, calculation, amount } = req.body;
    // Validate input
    if (!headId || !calculation || amount === undefined) {
      return res.status(400).json({
        success: false,
        message: "Head ID, calculation, and amount are required.",
      });
    }

    // Update the existing head entry with new calculation and amount
    const updatedHead = await prisma.deductions.update({
      where: { id: headId }, // Find by headId
      data: {
        calculation: validation.data.calculation,
        amount: parseFloat(validation.data.amount),
        deduction_month: String(new Date()),
      },
    });

    return res.status(200).json({
      status: 200,
      message: "Head updated successfully.",
      data: updatedHead,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      status: 500,
      message: "Error updating head.",
      error: error.message,
    });
  }
};

// Earnings Head Create API

const createEarningHead = async (req, res) => {
  try {
    const validation = deductionsEarningsSchema.safeParse(req.body);
    if (validation.error) {
      return res.status(400).json({
        success: false,
        message: validation.error.details[0].message
      })
    }
    // const { salaryId, heads } = req.body;
    const { staffId, heads } = req.body;

    // Validate input
    if (!staffId || !heads) {
      return res
        .status(400)
        .json({ success: false, message: "Salary ID and heads are required." });
    }

    // Create a new heads entry
    const headData = await prisma.earnings.create({
      data: {
        staffId: validation.data.staffId,
        heads: validation.data.heads,
      },
    });

    return res.status(201).json({
      status: 201,
      message: "Head created successfully.",
      data: headData,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      status: 500,
      message: "Error creating head.",
      error: error.message,
    });
  }
};

// get by id earnings 

const getEarningsById = async (req, res) => {
  const { id } = req.params;
  try {
    const getById = await prisma.earnings.findUnique({
      where: { id },
    });
    return res
      .status(200)
      .json({ status: 200, message: "Get Earnings Data By ID!", data: getById });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "Failed To get Earnings Data By ID!" });
  }
};

// get all earnings

const getAllEarningsData = async (req, res) => {
  try {
    const getAll = await prisma.earnings.findMany({});
    return res
      .status(200)
      .json({ status: 200, message: "Get All Earnings Data!", data: getAll });
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "Failed To get All Earnings Data!" });
  }
};

// Update Earning Head API

const updateEarningHead = async (req, res) => {
  try {
    const validation = deductionsEarningsSchema.safeParse(req.body);
    if (validation.error) {
      return res.status(400).json({
        success: false,
        message: validation.error.details[0].message
      })
    }
    const { headId, calculation, amount } = req.body;

    // Validate input
    if (!headId || !calculation || amount === undefined) {
      return res.status(400).json({
        success: false,
        message: "Head ID, calculation, and amount are required.",
      });
    }

    // Update the existing head entry with new calculation and amount
    const updatedHead = await prisma.earnings.update({
      where: { id: headId }, // Find by headId
      data: {
        calculation: validation.data.calculation,
        amount: parseFloat(validation.data.amount),
      },
    });

    return res.status(200).json({
      status: 200,
      message: "Head updated successfully.",
      data: updatedHead,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      status: 500,
      message: "Error updating head.",
      error: error.message,
    });
  }
};

// get deduction by id
const getDeductionById = async (req, res) => {
  const { id } = req.params;
  try {
    const getById = await prisma.deductions.findUnique({
      where: { id },
    });
    return res
      .status(200)
      .json(getById);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "Inernal Server Error" });
  }
};

// get all deductions 
const getAllDeductions = async (req, res) => {
  try {
    const getAll = await prisma.deductions.findMany();
    return res
      .status(200)
      .json(getAll);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ status: 500, message: "Internal Server Error" });
  }
};

//  delete earnings by id
const deleteEarningsByID = async (req, res) => {
  const { id } = req.params;
  // console.log(id);
  try {
    const head = await prisma.earnings.delete({
      where: { id: id },
    });
    return res.status(200).json({
      status: 200,
      message: "Head deleted successfully.",
      data: head,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      status: 500,
      message: "Internal Server Error.",
      error: error.message,
    });
  }
};

module.exports = {
  addOrUpdateSalaryDetails,
  deductions,
  getAllSalaryData,
  updateSalaryData,
  getSalaryDetailsById,
  deleteSalaryRecord,
  updateDeductions,
  createEarningHead,
  updateEarningHead,
  getEarningsById,
  getAllEarningsData,
  getDeductionById,
  getAllDeductions,
  deleteEarningsByID
};