const express = require('express');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const app = express();

app.use(express.json()); // Middleware to parse JSON

// Project Priority
const createProjectPriority = async (req, res) => {
    const { Priority_name, Priority_color, Priority_order, default_filter, is_hidden, can_changed } = req.body;
    try {
        // Ensure canBeChanged is an array, filter out null or undefined values
        const isArrayChangedValue = Array.isArray(can_changed)
            ? can_changed.filter(item => item != null)
            : [can_changed].filter(item => item != null);
        const isArrayHiddenValue = Array.isArray(is_hidden) ? is_hidden.filter(item => item != null) : [is_hidden].filter(item => item != null);

        const addProjectPriority = await prisma.projectPriority.create({
            data: {
                Priority_name,
                Priority_color,
                Priority_order,
                default_filter: !!default_filter,
                is_hidden: isArrayHiddenValue,
                can_changed: isArrayChangedValue,
            }
        });
        return res.status(201).json({ status: true, message: "Project Priority Added Successfully!", data: addProjectPriority });
    } catch (error) {
        console.error("Error adding project Priority:", error); // Log the error for debugging
        return res.status(500).json({ status: false, message: "Something went wrong!" });
    }
}

// get project Priority
const getProjectPriority = async (req, res) => {
    try {
        const projectPriority = await prisma.projectPriority.findMany();

        // Check if any records were found
        if (projectPriority.length === 0) {
            return res.status(404).json({ status: false, message: "No project priorities found!" });
        }

        return res.status(201).json({ status: true, message: "Project Priority retrieved successfully!", data: projectPriority });
    } catch (error) {
        console.error("Error retrieving project Priority:", error); // Log the error for debugging
        return res.status(500).json({ status: false, message: "Something went wrong!" });
    }
};

// update project Priority
const updateProjectPriority = async (req, res) => {
    const { id, Priority_name, Priority_color, Priority_order, default_filter, is_hidden, can_changed } = req.body;
    try {
        // Ensure canBeChanged is an array, filter out null or undefined values
        const isArrayChangedValue = Array.isArray(can_changed)
            ? can_changed.filter(item => item != null)
            : [can_changed].filter(item => item != null);
        const isArrayHiddenValue = Array.isArray(is_hidden) ? is_hidden.filter(item => item != null) : [is_hidden].filter(item => item != null);
        const updateProjectPriority = await prisma.projectPriority.update({
            where: { id },
            data: {
                Priority_name,
                Priority_color,
                Priority_order,
                default_filter: !!default_filter,
                is_hidden: isArrayHiddenValue,
                can_changed: isArrayChangedValue,
            }
        });
        return res.status(201).json({ status: true, message: "Project Priority Updated Successfully!", data: updateProjectPriority });
    } catch (error) {
        console.error("Error updating project Priority:", error); // Log the error for debugging
        return res.status(500).json({ status: false, message: "Something went wrong!" });
    }
}

const searchProjectPriorityByName = async (req, res) => {
    try {
        const { name } = req.query;
        const projectPriority = await prisma.projectPriority.findMany({
            where: {
                Priority_name: {
                    contains: name
                }
            }
        });
        return res.status(200).json(projectPriority);
    } catch (error) {
        console.error('Error fetching projects:', error);
        return res.status(500).json({ status: false, message: "Internal Server Error!" });
    }
};

module.exports = {
    createProjectPriority,
    getProjectPriority,
    updateProjectPriority,
    searchProjectPriorityByName
}