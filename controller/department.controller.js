import express from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

// Add Department

export const addDepartment = async (req, res) => {
    try {
        const { departmentName } = req.body;
        const addNewDepartment = await prisma.department.create({
            data: {
                department_name: departmentName
            },
        });
        res.status(200).json({ success: true, message: "Department added successfully", data: addNewDepartment });
    } catch (error) {
        res.status(500).json({ success: false, message: "Error adding department", error: error.message });
    }
};

// Update Department

export const updateDepartment = async (req, res) => {
    const { id } = req.params;
    try {
        const { departmentName } = req.body;
        await prisma.department.update({
            where: {
                id
            },
            data: {
                department_name: departmentName,
            }
        });
        return res.status(200).json({ status: true, message: "Department Data Successfully Updated!("+ id +")"   })
    } catch (error) {
        return res.status(500).json({ status: false, message: "Something Went Wrong!", error: error.code })
    }
}


export const fetchDepartment = async(req, res) => {    
        const department = await prisma.department.findMany({});
        try{
            if(department.length === 0){
                return res.status(400).json({status:400, message:"Department not found!"});
            }
            return res.json({status:200, data:department});
        } catch{}                   
}

export const deleteDepartment = async (req, res) => {
    const { id } = req.params;
    try {        
        await prisma.department.delete({
            where: {
                id
            },
        });
        return res.status(200).json({ status: true, message: "Department Deleted Successfully!(" + id + ")" })
    } catch (error) {
        return res.status(500).json({ status: false, message: "Something Went Wrong!", error: error.code })
    }
}

export const showDepartment = async (req, res) => {
    const { id } = req.params;
    try {        
        const showdepartment = await prisma.department.findUnique({
            where: {
                id
            }
        });        
        if (!showdepartment) {
            return res.status(404).json({ status: false, message: "Department not found!" });
        }        
        return res.status(200).json({status: true,message: "Department Show By ID!("+ id + ")" ,data: showdepartment});
    } catch (error) {        
        return res.status(500).json({status: false,message: "Something went wrong!",error: error.message});
    }
};

