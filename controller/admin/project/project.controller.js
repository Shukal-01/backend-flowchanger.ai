const express = require("express");
const { PrismaClient } = require("@prisma/client");
const { sendProjectCreatedMail } = require("../../../utils/mailer");
const { ZodError } = require("zod");
const { projectSchema } = require("../../../utils/validations.js");
const app = express();
const prisma = new PrismaClient();

const addProject = async (req, res) => {
  const {
    staffId,
    project_name,
    customerId,
    billing_type,
    status,
    total_rate,
    start_date,
    deadline,
    description,
    tags,
    estimated_hours,
    send_mail
  } = req.body;
  console.log(req.body)
  // Validate request body using projectSchema
  const validationResult = projectSchema.safeParse({
    staffId,
    project_name,
    customerId,
    billing_type,
    status,
    total_rate,
    start_date,
    deadline,
    description,
    tags,
    estimated_hours,
    send_mail
  });

  // If validation fails, return a 400 error with validation issues
  if (!validationResult.success) {
    console.log(validationResult.error)
    return res.status(400).json({
      msg: "Invalid request data",
      errors: validationResult.error.issues.map(issue => issue.message)
    });
  }

  try {
    const client = await prisma.clientDetails.findUnique({
      where: {
        id: customerId
      },
      include: {
        user: true
      }
    });

    console.log(client, customerId)
    if (!client) {
      return res.status(404).json({ msg: "Client not found" });
    }
    const createdProject = await prisma.project.create({
      data: {
        project_name: validationResult.data.project_name,
        customerId: validationResult.data.customerId,
        staffId: {
          connect: validationResult.data.staffId.map(id => ({ id }))
        },
        billing_type: validationResult.data.billing_type,
        status: validationResult.data.status,
        total_rate: validationResult.data.total_rate,
        start_date: validationResult.data.start_date,
        deadline: validationResult.data.deadline,
        description: validationResult.data.description,
        tags: validationResult.data.tags,
        estimated_hours: validationResult.data.estimated_hours,
        send_mail: validationResult.data.send_mail
      },
      include: {
        staffId: true
      },
    });

    console.log(client);
    await sendProjectCreatedMail(client.user.email, project_name);

    return res.status(201).json({
      msg: "Project Created Successfully",
      data: createdProject,
    });

  } catch (error) {
    console.error("FAiled creating project:", error.message);

    if (error.code === "P2002") {
      return res.status(400).json({ msg: "Duplicate entry", error: error.meta.target });
    }
    return res.status(500).json({ msg: "Error creating project", error: error.message });
  }
};

// Fetch All Project Query............................

const getProject = async (req, res) => {
  // const ProjectID = req.params.id;      
  try {
    const Projects = await prisma.project.findMany({
      include: {
        TaskDetail: true,
      }
    });
    return res.status(200).json({ message: "Project fetched successfully", data: Projects });
  } catch (error) {
    return res.status(500).json({ message: "failed to get projects" + error.message });
  }
}

// Show By ID Project Query............................

const showProject = async (req, res) => {
  if (req.params.id === "search-projectByName") {
    return SearchingProjectsByName(req, res);
  }
  try {

    const ProjectID = req.params.id;
    const Projects = await prisma.project.findMany({
      where: {
        id: ProjectID,
      },
    });
    return res.status(200).json({ message: "Project fetched ById successfully", data: Projects });
  } catch (error) {
    return res.status(500).json({ message: "failed to get projects" + error.message });
  }
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
    return res.status(200).json({ message: "Project deleted successfully!", deletedProject });
  } catch (error) {
    if (error.code) {
      return res.status(500).json({ message: "Failed to delete project" + error.message });
    }
  }
}


// Project Update Query............................

const updateProject = async (req, res) => {
  const projectID = req.params.id;
  try {
    const {
      staffId,
      project_name,
      customerId,
      billing_type,
      status,
      total_rate,
      start_date,
      deadline,
      description,
      tags,
      estimated_hours,
      send_mail
    } = req.body;

    // Validate request body using projectSchema
    const validationResult = projectSchema.safeParse({
      staffId,
      project_name,
      customerId,
      billing_type,
      status,
      total_rate,
      start_date,
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
        customerId: validationResult.data.customerId,
        staffId: {
          connect: validationResult.data.staffId.map(id => ({ id }))
        },
        billing_type: validationResult.data.billing_type,
        status: validationResult.data.status,
        total_rate: validationResult.data.total_rate,
        start_date: validationResult.data.start_date,
        deadline: validationResult.data.deadline,
        description: validationResult.data.description,
        tags: validationResult.data.tags,
        estimated_hours: validationResult.data.estimated_hours,
        send_mail: validationResult.data.send_mail
      },
      include: {
        staffId: true
      },
    })
    return res.status(200).json({ message: "Project updated successfully!" });
  } catch (error) {
    if (error.code) {
      return res.status(400).json({ message: "Failed to update project!" + error.message });
    }
  }

}

// Search Project Query............................

const SearchingProjectsByName = async (req, res) => {
  const { project_name } = req.query;
  console.log(project_name);
  try {
    const projects = await prisma.project.findMany({
      where: {
        project_name: {
          contains: project_name,
          mode: 'insensitive',
        },
      },
    });
    res.status(200).json(projects);
  } catch (error) {
    console.error('Failed to fetch projects', error.message);
    res.status(500).json({ message: 'Failed to search projects' + error.message });
  }
};


module.exports = { addProject, updateProject, deleteProject, showProject, getProject, SearchingProjectsByName }