const express = require('express');
const multer = require('multer');
const upload = require('../../../middleware/upload.js');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();
const app = express();

// Add Project Files Query
const addProjectFiles = async (req, res) => {
    const { projectId, last_activity, total_comments, visible_to_customer, uploaded_by } = req.body;
    const file_name = req.imageUrl;
    const file_type = req.file.mimetype;
    const date_uploaded = new Date();

    // console.log(file_name, file_type, date_uploaded);

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

        return res.status(201).json({ msg: "File uploaded successfully", file: newFilesData, });
    } catch (error) {
        console.error("Failed to creating project file:", error);
        return res.status(500).json({ msg: "Failed to creating project file", error: error.message });
    }
};

// Get All Project Files
const getAllProjectFiles = async (req, res) => {
    const ProjectsFiles = await prisma.projectFiles.findMany({});
    try {
        return res.status(200).json({ message: "Project files fetched successfully", data: ProjectsFiles });
    } catch (error) {
        return res.status(500).json({ message: "failed to get project files" + error.message });
    }
}

// Update Project Files
const updateProjectFiles = async (req, res) => {
    const { id } = req.params;
    try {
        const { projectId, last_activity, total_comments, visible_to_customer, uploaded_by } = req.body;

        const file_name = req.imageUrl;
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
        return res.status(200).json({ message: "Project files updated successfully!", data: updatedProjects });
    } catch (error) {
        console.error("Failed updating project:", error.message);
        return res.status(400).json({ message: "Project update failed!" });
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
        return res.status(200).json({ message: "Project files deleted successfully!", data: deletedProjectFiles });
    } catch (error) {
        if (error.code) {
            return res.status(404).json({ message: "Project files not found!" + error.message });
        }
    }
}


module.exports = { addProjectFiles, getAllProjectFiles, updateProjectFiles, deleteProjectFiles };
