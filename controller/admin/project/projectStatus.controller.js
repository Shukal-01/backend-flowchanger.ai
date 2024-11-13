const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const app = express();
const { ZodError } = require("zod");
const { projectStatusSchema } = require("../../../utils/validations.js");

app.use(express.json());

const projectStatus = async (req, res) => {
    const { project_name, project_color, default_filter, project_order, can_changed } = req.body;

    // Validate the request data using projectStatusSchema
    const validationResult = projectStatusSchema.safeParse({
        project_name,
        project_color,
        project_order,
        default_filter,
        can_changed
    });

    // If validation fails, return a 400 error with validation issues
    if (!validationResult.success) {
        return res.status(400).json({
            status: false,
            message: "Invalid request data",
            error: validationResult.error.issues.map(issue => issue.message) // Map to get user-friendly messages
        });
    }

    try {
        // Ensure can_changed is treated as an array of non-null values
        const isArrayChangedValue = Array.isArray(validationResult.data.can_changed)
            ? validationResult.data.can_changed.filter(item => item != null)
            : [validationResult.data.can_changed].filter(item => item != null);

        const addProjectStatus = await prisma.projectStatus.create({
            data: {
                project_name: validationResult.data.project_name,
                project_color: validationResult.data.project_color,
                project_order: validationResult.data.project_order,
                default_filter: !!validationResult.data.default_filter, // Convert to boolean
                can_changed: isArrayChangedValue
            }
        });

        return res.status(201).json({
            status: true,
            message: "Project Status Added Successfully!",
            data: addProjectStatus
        });
    } catch (error) {
        console.error("Error adding project status:", error); // Log the error for debugging
        return res.status(500).json({
            status: false,
            message: "Something went wrong!"
        });
    }
};


// get project status
const getProjectStatus = async (req, res) => {
    try {
        const projectStatus = await prisma.projectStatus.findMany({});
        return res.status(201).json({ status: true, message: "Project Status Get Successfully!", data: projectStatus });
    } catch (error) {
        console.error("Error adding project status:", error); // Log the error for debugging
        return res.status(500).json({ status: false, message: "Something went wrong!" });
    }
};

// update project status
const updateProjectStatus = async (req, res) => {
    try {
        const { id } = req.params;
        const { project_name, project_color, project_order, default_filter, can_changed } = req.body;

        // Validate the request data using projectStatusSchema
        const validationResult = projectStatusSchema.safeParse({
            project_name,
            project_color,
            project_order,
            default_filter,
            can_changed
        });

        // If validation fails, return a 400 error with validation issues
        if (!validationResult.success) {
            return res.status(400).json({
                status: false,
                message: "Invalid request data",
                error: validationResult.error.issues.map(issue => issue.message) // Map to get user-friendly messages
            });
        }

        // Ensure can_changed is treated as an array of non-null values
        const isArrayChangedValue = Array.isArray(validationResult.data.can_changed)
            ? validationResult.data.can_changed.filter(item => item != null)
            : [validationResult.data.can_changed].filter(item => item != null);

        const updateProjectStatus = await prisma.projectStatus.update({
            where: {
                id: id
            },
            data: {
                project_name: validationResult.data.project_name,
                project_color: validationResult.data.project_color,
                project_order: validationResult.data.project_order,
                default_filter: !!validationResult.data.default_filter, // Convert to boolean
                can_changed: isArrayChangedValue
            }
        });

        return res.status(201).json({
            status: true,
            message: "Project Status Updated Successfully!",
            data: updateProjectStatus
        });
    } catch (error) {
        console.error("Error adding project status:", error); // Log the error for debugging
        return res.status(500).json({
            status: false,
            message: "Something went wrong!"
        });
    }
};

const searchProjectStatusByName = async (req, res) => {
    try {
        const { project_name } = req.query;
        const SearchProjectStatus = await prisma.projectStatus.findMany({
            where: {
                project_name: {
                    contains: project_name,
                    mode: "insensitive",
                },
            },
        });
        res.status(200).json(projects);
    } catch (error) {
        console.error('Error fetching projects:', error);
        res.status(500).json({ message: 'Internal server error' });
    }
};

module.exports = {
    projectStatus,
    getProjectStatus,
    updateProjectStatus,
    searchProjectStatusByName
};