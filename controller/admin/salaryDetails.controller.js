const express = require('express');
const { PrismaClient } = require('@prisma/client');
const { param } = require('../../router/routes');

const app = express();
const prisma = new PrismaClient();

app.use(express.json());

const addSalaryDetails = async (req, res) => {
    try {
        const {
            effective_date,
            salary_type,
            ctc_amount,
            basic,
            employer_lwf,
            // hra,
            // dearness_Allowance,
            // employer_PF,
            // employer_ESI,
            // employee_PF,
            // employee_ESI,
            employee_lwf,
            professional_tax,
            tds
        } = req.body;

        // Calculate default values based on basic salary
        const hra = basic * 0.4;
        const dearness_allowance = basic * 0.12;
        const employer_pf = basic * 0.12;
        const employer_esi = basic * 0.0325;
        const employee_pf = basic * 0.12;
        const employee_esi = basic * 0.0075;
        const newSalaryDetails = await prisma.salaryDetails.create({
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

        res.status(200).json({ success: true, message: 'Salary Details added successfully', data: newSalaryDetails });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Error adding salary details', error: error.message });
    }
};

// Salary Data Fetch By Id:

const getSalaryDetailsById = async (req,res) => {
    const {id} = req.params;
    try{
        const getById = await prisma.salaryDetails.findUnique({
            where:{id},            
        });
        return res.status(200).json({status:200,message:"Get Salaary Data By ID!", data:getById});
    }catch(error){
        return res.status(500).json({status:500, message:"Failed To get Salary Data By ID!"});
    }
}

// Salary Details Fetch All Data:

const getAllSalaryData = async (req, res) => {
    try {
        const salaryData = await prisma.salaryDetails.findMany({});        
        if (salaryData.length === 0) {
            return res.status(404).json({status: 404,message: "No salary data found.",data: []});
        }
        return res.status(200).json({status: 200,message: "Successfully retrieved all salary data.",data: salaryData});
    } catch (error) {        
        return res.status(500).json({status: 500,message: "An error occurred while fetching salary data.",error: error.message });
    }
};

// Update Salary Data

const updateSalaryData = async(req, res) => {
    const {id} = req.params;
    const{
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
    }=req.body;
    try{
        const update = await prisma.salaryDetails.update({
            where: { id },
            data:{
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
        return res.status(200).json({status:200, message:"Salary Data Succesfully Updated!",data:update});
    }catch(error){
        return res.status(500).json({status:500, message:"This Data (" + id + ") ID Not Found!"});
    }
}

// Delete Salary Data Record By ID

const deleteSalaryRecord = async(req,res)=>{
    const {id} = req.params;
    try{
        const deleteRecord = await prisma.salaryDetails.delete({
            where:{id}
        });
        return res.status(200).json({status:200,message:"Salary Record Deleted Successfully!",data:deleteRecord});
    }catch(error){
        return res.status(500).json({status:500,message:"This Data (" +id+ ") ID Not Found!"});
    }
}

// ------------------------------
// Deductions API
// --------------------------------

const deductions = async (req, res) => {
    try {
        // Destructure headers, calculation, and amount from req.body
        const {heads,calculation,amount} = req.body;                
        const addDeductions = await prisma.deductions.create({
            data: {
                heads,
                calculation,
                amount
            }
        });

        res.status(200).json({
            success: true,
            message: 'Deductions added successfully',
            data: addDeductions
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Error adding deductions',
            error: error.message
        });
    }
};

// Get All Deductions Data

const getAllDeductions = async(req,res) => {
    const {id} = req.params;
    try{
        const getDeductions = await prisma.deductions.findMany({});
        return res.status(200).json({status:200,message:"Get All Deductions!",data:getDeductions});
    }catch(error){
        return res.status(500).json({status:500,message:"Deduction Not Found This Id (" + id});
    }
}

// Get Deductions By Id

const getDeductionsById = async(req,res) => {
    const {id} = req.params;
    try{
        const getDeductionsById = await prisma.deductions.findUnique({
            where: {id},
        });
        return res.status(200).json({status:200,message:"Get Deductions By ID",data:getDeductionsById});
    }catch(error){
        return res.status(500).json({status:500,message:"Deductions Not Found"});
    }
}

// Update Deductions By ID

const updateDeductions = async(req,res) => {
    const{heads,calculation,amount}=req.body;
    const {id} = req.params;
    try{        
        const update = await prisma.deductions.update({
            where: {id},
            data:{
                heads,calculation,amount
            }            
        });
        return res.status(200).json({status:200,message:"Deductions Successfully Updated!"});
    }catch(error){
        return res.status(500).json({status:500,message:"Deductions Not Found (" + id});
    }
}

const deleteDeductions = async(req,res)=> {
    const {id} = req.params;
    try{
        const deletedData = await prisma.deductions.delete({
            where:{id},
        });
        return res.status(200).json({status:200,message:"Deduction Deleted From This ID (" +id+ ")"});
    }catch(error){
        return res.status(500).json({status:500,message:"Deduction Not Found From This Id (" +id+ ")"});
    }
}

module.exports = { addSalaryDetails, deductions,getAllSalaryData,updateSalaryData,getSalaryDetailsById,deleteSalaryRecord ,getAllDeductions, updateDeductions, getDeductionsById,deleteDeductions};
