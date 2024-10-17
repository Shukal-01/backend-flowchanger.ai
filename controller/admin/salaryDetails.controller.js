const express = require('express');
const { PrismaClient } = require('@prisma/client');
const { param } = require('../../router/routes');

const app = express();
const prisma = new PrismaClient();

app.use(express.json());
const addOrUpdateSalaryDetails = async (req, res) => {
    try {
        const {
            effective_date, salary_type, ctc_amount, basic, hra,
            dearness_allowance, employer_pf, employer_esi, employer_lwf,
            employee_pf, employee_esi, professional_tax, tds, employee_lwf, staffId
        } = req.body;

        const formattedEffectiveDate = new Date(effective_date);

        // Check if a record with the same staffId and effective_date exists
        const existingSalaryDetails = await prisma.salaryDetails.findFirst({
            where: {
                staffId: staffId,
                effective_date: formattedEffectiveDate
            }
        });
        if (existingSalaryDetails) {
            // Update the existing record for the same effective date
            const updatedSalaryDetails = await prisma.salaryDetails.update({
                where: { id: existingSalaryDetails.id },
                data: {
                    salary_type: salary_type || existingSalaryDetails.salary_type,
                    ctc_amount: parseFloat(ctc_amount) || existingSalaryDetails.ctc_amount,
                    basic: parseFloat(basic) || existingSalaryDetails.basic,
                    hra: parseFloat(hra) || existingSalaryDetails.hra,
                    dearness_allowance: parseFloat(dearness_allowance) || existingSalaryDetails.dearness_allowance,
                    employer_pf: parseFloat(employer_pf) || existingSalaryDetails.employer_pf,
                    employer_esi: parseFloat(employer_esi) || existingSalaryDetails.employer_esi,
                    employer_lwf: parseFloat(employer_lwf) || existingSalaryDetails.employer_lwf,
                    employee_pf: parseFloat(employee_pf) || existingSalaryDetails.employee_pf,
                    employee_esi: parseFloat(employee_esi) || existingSalaryDetails.employee_esi,
                    professional_tax: parseFloat(professional_tax) || existingSalaryDetails.professional_tax,
                    employee_lwf: parseFloat(employee_lwf) || existingSalaryDetails.employee_lwf,
                    tds: parseFloat(tds) || existingSalaryDetails.tds
                }
            });
            res.status(200).json({ success: true, message: "Salary details updated successfully", data: updatedSalaryDetails });
        } else {
            // Create a new record if the effective date has changed
            const newSalaryDetails = await prisma.salaryDetails.create({
                data: {
                    effective_date: formattedEffectiveDate,
                    salary_type: salary_type || null,
                    ctc_amount: parseFloat(ctc_amount) || null,
                    basic: parseFloat(basic) || null,
                    hra: parseFloat(hra) || null,
                    dearness_allowance: parseFloat(dearness_allowance) || null,
                    employer_pf: parseFloat(employer_pf) || null,
                    employer_esi: parseFloat(employer_esi) || null,
                    employer_lwf: parseFloat(employer_lwf) || null,
                    employee_pf: parseFloat(employee_pf) || null,
                    employee_esi: parseFloat(employee_esi) || null,
                    professional_tax: parseFloat(professional_tax) || null,
                    employee_lwf: parseFloat(employee_lwf) || null,
                    tds: parseFloat(tds) || null,
                    staffId: staffId
                }
            });
            res.status(201).json({ success: true, message: "Salary details added successfully", data: newSalaryDetails });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({ success: false, message: "Error adding or updating salary details", error: error.message });
    }
};



// Salary Data Fetch By Id:

const getSalaryDetailsById = async (req, res) => {
    const { id } = req.params;
    try {
        const getById = await prisma.salaryDetails.findUnique({
            where: { id },
        });
        return res.status(200).json({ status: 200, message: "Get Salaary Data By ID!", data: getById });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ status: 500, message: "Failed To get Salary Data By ID!" });
    }
}

// Salary Details Fetch All Data:

const getAllSalaryData = async (req, res) => {
    try {
        const salaryData = await prisma.salaryDetails.findMany({});
        if (salaryData.length === 0) {
            return res.status(404).json({ status: 404, message: "No salary data found.", data: [] });
        }
        return res.status(200).json({ status: 200, message: "Successfully retrieved all salary data.", data: salaryData });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ status: 500, message: "An error occurred while fetching salary data.", error: error.message });
    }
};

// Update Salary Data

const updateSalaryData = async (req, res) => {
    const { id } = req.params;
    const {
        effective_date,
        salary_type,
        ctc_amount,
        basic,
        hra,
        dearness_allowance,
        employer_pf,
        employer_esi,
        employer_lwf,
        employee_pf,
        employee_esi,
        professional_tax,
        employee_lwf,
        tds
    } = req.body;
    try {
        const update = await prisma.salaryDetails.update({
            where: { id },
            data: {
                effective_date: new Date(effective_date),
                salary_type,
                ctc_amount,
                basic,
                hra,
                dearness_allowance,
                employer_pf,
                employer_esi,
                employer_lwf,
                employee_pf,
                employee_esi,
                professional_tax,
                employee_lwf,
                tds
            }
        });
        return res.status(200).json({ status: 200, message: "Salary Data Succesfully Updated!", data: update });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ status: 500, message: "This Data (" + id + ") ID Not Found!" });
    }
}

// Delete Salary Data Record By ID

const deleteSalaryRecord = async (req, res) => {
    const { id } = req.params;
    try {
        const deleteRecord = await prisma.salaryDetails.delete({
            where: { id }
        });
        return res.status(200).json({ status: 200, message: "Salary Record Deleted Successfully!", data: deleteRecord });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ status: 500, message: "This Data (" + id + ") ID Not Found!" });
    }
}

// ------------------------------
// Deductions API
// --------------------------------

const deductions = async (req, res) => {
    try {
        // Destructure headers, calculation, and amount from req.body
        const { heads, calculation, amount } = req.body;
        const addDeductions = await prisma.deductions.create({
            data: {
                heads,
                calculation,
                amount
            }
        });

        res.status(200).json({ success: true, message: 'Deductions added successfully', data: addDeductions });
    } catch (error) {
        console.log(error);
        res.status(500).json({ success: false, message: 'Error adding deductions', error: error.message });
    }
};

// Get All Deductions Data

const getAllDeductions = async (req, res) => {
    const { id } = req.params;
    try {
        const getDeductions = await prisma.deductions.findMany({});
        return res.status(200).json({ status: 200, message: "Get All Deductions!", data: getDeductions });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ status: 500, message: "Deduction Not Found This Id (" + id });
    }
}

// Get Deductions By Id

const getDeductionsById = async (req, res) => {
    const { id } = req.params;
    try {
        const getDeductionsById = await prisma.deductions.findUnique({
            where: { id },
        });
        return res.status(200).json({ status: 200, message: "Get Deductions By ID", data: getDeductionsById });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ status: 500, message: "Deductions Not Found" });
    }
}

// Update Deductions By ID

const updateDeductions = async (req, res) => {
    const { heads, calculation, amount } = req.body;
    const { id } = req.params;
    try {
        const update = await prisma.deductions.update({
            where: { id },
            data: {
                heads, calculation, amount
            }
        });
        return res.status(200).json({ status: 200, message: "Deductions Successfully Updated!" });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ status: 500, message: "Deductions Not Found (" + id });
    }
}

const deleteDeductions = async (req, res) => {
    const { id } = req.params;
    try {
        const deletedData = await prisma.deductions.delete({
            where: { id },
        });
        return res.status(200).json({ status: 200, message: "Deduction Deleted From This ID (" + id + ")" });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ status: 500, message: "Deduction Not Found From This Id (" + id + ")" });
    }
}

module.exports = { addOrUpdateSalaryDetails, deductions, getAllSalaryData, updateSalaryData, getSalaryDetailsById, deleteSalaryRecord, getAllDeductions, updateDeductions, getDeductionsById, deleteDeductions };
