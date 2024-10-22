const express = require("express");
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const addDepartment = async (req, res) => {
  try {
    const { departmentName } = req.body;
    const addNewDepartment = await prisma.department.create({
      data: {
        department_name: departmentName,
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
      message: "Error Adding Department",
      error: error.message,
    });
  }
};

// Update Department

const updateDepartment = async (req, res) => {
  const { id } = req.params;
  try {
    const { departmentName } = req.body;
    await prisma.department.update({
      where: {
        id,
      },
      data: {
        department_name: departmentName,
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
      message: "Something Went Wrong!",
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
        .json({ status: 400, message: "Department not found!" });
    }
    return res.json({ status: 200, data: department });
  } catch {}
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
      message: "Something Went Wrong!",
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
      message: "Something went wrong!",
      error: error.message,
    });
  }
};

// Export all modules by default
module.exports = {
  addDepartment,
  updateDepartment,
  fetchDepartment,
  deleteDepartment,
  showDepartment,
};
