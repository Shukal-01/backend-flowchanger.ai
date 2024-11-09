const express = require('express');
const departmentRouter = express.Router();
const departmentController = require("../../controller/admin/department.controller");

departmentRouter.post('/', departmentController.addDepartment)
departmentRouter.get('/search', departmentController.searchDepartmentByName)
departmentRouter.put('/:id', departmentController.updateDepartment)
departmentRouter.get('/', departmentController.fetchDepartment)
departmentRouter.delete('/:id', departmentController.deleteDepartment)
departmentRouter.get('/:id', departmentController.showDepartment)

module.exports = departmentRouter;