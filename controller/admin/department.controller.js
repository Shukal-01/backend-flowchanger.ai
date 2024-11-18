const express = require("express");
const { PrismaClient } = require("@prisma/client");
const { ZodError } = require("zod");
const { DepartmentSchema } = require("../../utils/validations");
const prisma = new PrismaClient();

const addDepartment = async (req, res) => {
  try {
    const { departmentName } = req.body;
    // Validate the taskTypeName using TaskTypeSchema
    const validationResult = DepartmentSchema.safeParse({
      departmentName,
    });
    const addNewDepartment = await prisma.department.create({
      data: {
        department_name: validationResult.data.departmentName,
      },
    });
    res.status(200).json({
      success: true,
      message: "Department Add Successfully",
      data: addNewDepartment,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      success: false,
      message: "Failed to adding department",
      error: error.message,
    });
  }
};

// Update Department

const updateDepartment = async (req, res) => {
  const { id } = req.params;
  try {
    const { departmentName } = req.body;
    const validationResult = DepartmentSchema.safeParse({
      departmentName,
    });

    await prisma.department.update({
      where: {
        id,
      },
      data: {
        department_name: validationResult.data.departmentName,
      },
    });
    return res.status(200).json({
      status: true,
      message: "Department Name Successfully Updated!(" + id + ")",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      message: "Failed to update department",
      error: error.code,
    });
  }
};

// Fetch All Department

const fetchDepartment = async (req, res) => {
  const department = await prisma.department.findMany({});
  try {
    if (department.length === 0) {
      return res
        .status(400)
        .json({ message: "Department not found!" });
    }
    return res.json({ status: 200, message: "Fetch Department Successfully!", data: department });
  } catch { }
};

// Delete Department By Id

const deleteDepartment = async (req, res) => {
  const { id } = req.params;
  try {
    await prisma.department.delete({
      where: {
        id,
      },
    });
    return res.status(200).json({
      status: true,
      message: "Department Deleted Successfully!(" + id + ")",
    });
  } catch (error) {
    return res.status(500).json({
      status: false,
      message: "Failed to delete department",
      error: error.code,
    });
  }
};

// Show Department By Id

const showDepartment = async (req, res) => {
  const { id } = req.params;
  try {
    const showDepartment = await prisma.department.findUnique({
      where: {
        id,
      },
    });
    if (!showDepartment) {
      return res
        .status(404)
        .json({ status: false, message: "Department not found!" });
    }
    return res.status(200).json({
      status: true,
      message: "Department Show By ID!(" + id + ")",
      data: showDepartment,
    });
  } catch (error) {
    return res.status(500).json({
      status: false,
      message: "Failed to show department",
      error: error.message,
    });
  }
};

// Search Department Query............................
const searchDepartmentByName = async (req, res) => {
  try {
    const { department_name } = req.query;
    const SearchDepartment = await prisma.department.findMany({
      where: {
        department_name: {
          contains: department_name,
          mode: "insensitive",
        },
      },
    });
    return res.status(201).json(SearchDepartment);
  } catch (error) {
    console.error("Error adding department:", error);
    return res.status(500).json({ status: false, message: "Failed to search department by name!" + error.message });
  }
};

// Export all modules by default
module.exports = {
  addDepartment,
  updateDepartment,
  fetchDepartment,
  deleteDepartment,
  showDepartment,
  searchDepartmentByName
};
