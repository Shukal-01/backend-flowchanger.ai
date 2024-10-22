const express = require('express');
const { PrismaClient } = require('@prisma/client');

const app = express();
const prisma = new PrismaClient();

// Add Project Query............................

const addProject = async (req, res) => {
    const { 
        clientId,
        project_name,   
        customer,  
        billing_type,   
        status,         
        total_rate,     
        start_Date,  
        department,        
        deadline,   
        description, 
        tags,   
        estimated_hours
    } = req.body;

    try {
        const createdProject = await prisma.project.create({
            data: {
                clientId,
                project_name,   
                customer,
                billing_type,   
                status,         
                total_rate,     
                start_Date,  
                department,        
                deadline,   
                description,  
                tags,   
                estimated_hours                  
            },
        });

        return res.json({ status: 200, data: createdProject, msg: "Project Created Successfully" });
    } catch (error) {
        console.error("Error creating project:", error);

        if (error.code === "P2002") { 
            return res.status(400).json({ status: 400, msg: "Duplicate entry", error: error.meta.target });
        }

        return res.status(500).json({ status: 500, msg: "Error creating project", error: error.message });
    }
};




// Fetch All Project Query............................

 const getProject = async(req, res) => {
    // const ProjectID = req.params.id;      
        const Projects = await prisma.project.findMany({});
        try{
            if(Projects.length === 0){
                return res.status(400).json({status:400, message:"users not found!"});
            }
            return res.json({status:200, data:Projects});
        } catch{}                   
}

// Show By ID Project Query............................

 const showProject = async(req, res) => {
    const ProjectID = req.params.id;      
        const Projects = await prisma.project.findMany({
            where:{
                id:ProjectID,
            },
        });
        try{
            if(Projects.length === 0){
                return res.status(400).json({status:400, message:"Project not found!"});
            }
            return res.json({status:200, data:Projects});
        } catch{}                   
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

 const updateProject = async(req, res) => {
    const projectID = req.params.id;      
    try{
        const {
            clientId,
            project_name,   
            customer,  
            billing_type,   
            status,         
            total_rate,     
            start_Date,  
            department,        
            deadline,   
            description, 
            tags,   
            estimated_hours
        } = req.body;  
              
        await prisma.project.update({
            where:{
                id:projectID,
            },
            data:{
                clientId,
                project_name,   
                customer,  
                billing_type,   
                status,         
                total_rate,     
                start_Date,  
                department,        
                deadline,   
                description, 
                tags,   
                estimated_hours
            },
        })
        return res.json({status:200, message:"Project updated successfully!"});
    } catch (error){
            if(error.code){
                return res.status(400).json({status:400, message:"Project not found!"});
            }            
    }
    
}


module.exports = {addProject, updateProject, deleteProject, showProject, getProject}