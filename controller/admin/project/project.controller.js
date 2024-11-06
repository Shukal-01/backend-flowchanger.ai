const express = require('express');
const { PrismaClient } = require('@prisma/client');
const { ZodError } = require("zod");
const { projectSchema } = require("../../../utils/validations.js");
const app = express();
const prisma = new PrismaClient();

// Add Project Query............................

const addProject = async (req, res) => {
    const {
        project_name,
        customer,
        billing_type,
        status,
        total_rate,
        start_date,
        department,
        deadline,
        description,
        tags,
        estimated_hours,
        send_mail
    } = req.body;

    // Validate request body using projectSchema
    const validationResult = projectSchema.safeParse({
        project_name,
        customer,
        billing_type,
        status,
        total_rate,
        start_date,
        department,
        deadline,
        description,
        tags,
        estimated_hours,
        send_mail
    });

    // If validation fails, return a 400 error with validation issues
    if (!validationResult.success) {
        return res.status(400).json({
            status: 400,
            msg: "Invalid request data",
            errors: validationResult.error.issues.map(issue => issue.message)
        });
    }

    try {
        const createdProject = await prisma.project.create({
            data: {
                project_name: validationResult.data.project_name,
                customer: validationResult.data.customer,
                billing_type: validationResult.data.billing_type,
                status: validationResult.data.status,
                total_rate: validationResult.data.total_rate,
                start_date: validationResult.data.start_date,
                department: validationResult.data.department,
                deadline: validationResult.data.deadline,
                description: validationResult.data.description,
                tags: validationResult.data.tags,
                estimated_hours: validationResult.data.estimated_hours,
                send_mail: validationResult.data.send_mail
            }
        });

        return res.status(201).json({ status: 201, data: createdProject, msg: "Project Created Successfully" });
    } catch (error) {
        console.error("Error creating project:", error);

        if (error.code === "P2002") {
            return res.status(400).json({ status: 400, msg: "Duplicate entry", error: error.meta.target });
        }

        return res.status(500).json({ status: 500, msg: "Error creating project", error: error.message });
    }
};





// Fetch All Project Query............................

const getProject = async (req, res) => {
    // const ProjectID = req.params.id;      
    const Projects = await prisma.project.findMany({});
    try {
        if (Projects.length === 0) {
            return res.status(400).json({ status: 400, message: "users not found!" });
        }
        return res.json({ status: 200, data: Projects });
    } catch { }
}

// Show By ID Project Query............................

const showProject = async (req, res) => {
    const ProjectID = req.params.id;
    const Projects = await prisma.project.findMany({
        where: {
            id: ProjectID,
        },
    });
    try {
        if (Projects.length === 0) {
            return res.status(400).json({ status: 400, message: "Project not found!" });
        }
        return res.json({ status: 200, data: Projects });
    } catch { }
}


// Project Delete Query......................

const deleteProject = async (req, res) => {
    const projectID = req.params.id;
    try {
        const deletedProject = await prisma.project.delete({
            where: {
                id: projectID,
            },
        });
        return res.json({ status: 200, message: "Project deleted successfully!", deletedProject });
    } catch (error) {
        if (error.code) {
            return res.status(404).json({ status: 404, message: "Project not found!" });
        }
    }
}

// Project Update Query............................

const updateProject = async (req, res) => {
    const projectID = req.params.id;
    try {
        const {
            project_name,
            customer,
            billing_type,
            status,
            total_rate,
            start_date,
            department,
            deadline,
            description,
            tags,
            estimated_hours,
            send_mail
        } = req.body;
        // Validate request body using projectSchema
        const validationResult = projectSchema.safeParse({
            project_name,
            customer,
            billing_type,
            status,
            total_rate,
            start_date,
            department,
            deadline,
            description,
            tags,
            estimated_hours,
            send_mail
        });

        // If validation fails, return a 400 error with validation issues
        if (!validationResult.success) {
            return res.status(400).json({
                status: 400,
                msg: "Invalid request data",
                errors: validationResult.error.issues.map(issue => issue.message)
            });
        }
        await prisma.project.update({
            where: {
                id: projectID,
            },
            data: {
                project_name: validationResult.data.project_name,
                customer: validationResult.data.customer,
                billing_type: validationResult.data.billing_type,
                status: validationResult.data.status,
                total_rate: validationResult.data.total_rate,
                start_date: validationResult.data.start_date,
                department: validationResult.data.department,
                deadline: validationResult.data.deadline,
                description: validationResult.data.description,
                tags: validationResult.data.tags,
                estimated_hours: validationResult.data.estimated_hours,
                send_mail: validationResult.data.send_mail
            },
        })
        return res.json({ status: 200, message: "Project updated successfully!" });
    } catch (error) {
        if (error.code) {
            return res.status(400).json({ status: 400, message: "Project not found!" });
        }
    }

}


module.exports = { addProject, updateProject, deleteProject, showProject, getProject }