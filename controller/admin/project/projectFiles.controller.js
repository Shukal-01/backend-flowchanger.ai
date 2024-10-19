const express = require('express');
const multer = require('multer');
const upload = require('../../../middleware/upload.js');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();
const app = express();

// Add Project Files Query
const addProjectFiles = async (req, res) => {
    const { projectId, last_activity, total_comments, visible_to_customer, uploaded_by } = req.body;
    if (!req.file) {
        return res.status(400).json({ status: 400, msg: "No file uploaded" });
    }
    const file_name = req.file.originalname;
    const file_type = req.file.mimetype;
    const date_uploaded = new Date();

    console.log(file_name, file_type, date_uploaded);

    try {
        const newFilesData = await prisma.projectFiles.create({
            data: {
                projectId,
                file_name: file_name,
                file_type: file_type,
                last_activity: last_activity || "",
                total_comments: total_comments || "",
                visible_to_customer: visible_to_customer || false,
                uploaded_by: uploaded_by || "",
                date_uploaded: date_uploaded
            },
        });

        return res.status(201).json({ status: 201, msg: "File uploaded successfully", file: newFilesData, });
    } catch (error) {
        console.error("Error creating project file:", error);
        return res.status(500).json({ status: 500, msg: "Error creating project file", error: error.message });
    }
};

// Get All Project Files
const getAllProjectFiles = async (req, res) => {
    const ProjectsFiles = await prisma.projectFiles.findMany({});
    try {
        if (ProjectsFiles.length === 0) {
            return res.status(400).json({ status: 400, message: "project files not found!" });
        }
        return res.json({ status: 200, data: ProjectsFiles });
    } catch (error) {
        return res.status(500).json({ status: 500, message: "failed to get project files" });
    }
}

// Update Project Files
const updateProjectFiles = async (req, res) => {
    const { id } = req.params;
    try {
        const { projectId, last_activity, total_comments, visible_to_customer, uploaded_by } = req.body;

        const file_name = req.file.originalname;
        const file_type = req.file.mimetype;
        const date_uploaded = new Date();
        const updatedProjects = await prisma.projectFiles.update({
            where: {
                id: id,
            },
            data: {
                projectId,
                file_name: file_name,
                file_type: file_type,
                last_activity: last_activity || "",
                total_comments: total_comments || "",
                visible_to_customer: false,
                uploaded_by: uploaded_by || "",
                date_uploaded: date_uploaded
            }
        });
        return res.json({ status: 200, message: "Project files updated successfully!", data: updatedProjects });
    } catch (error) {
        console.error("Error updating project:", error);
        return res.status(400).json({ status: 400, message: "Project files not found or update failed!" });
    }
};

// delete projects files
const deleteProjectFiles = async (req, res) => {
    const { id } = req.params;
    try {
        const deletedProjectFiles = await prisma.projectFiles.delete({
            where: {
                id: id,
            },
        });
        return res.json({ status: 200, message: "Project files deleted successfully! (" + id + ")" });
    } catch (error) {
        if (error.code) {
            return res.status(404).json({ status: 404, message: "Project files not found!" });
        }
    }
}


module.exports = { addProjectFiles, getAllProjectFiles, updateProjectFiles, deleteProjectFiles };
