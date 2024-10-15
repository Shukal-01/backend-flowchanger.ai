// router/registetrLogin.router.js

const express = require('express');
const adminRouter = express.Router();
const authenticateUser = require('../../middleware/auth');
const adminController = require("../../controller/admin/registerLogin.controller");

adminRouter.post('/', adminController.adminSignup)
adminRouter.post('/verify-otp', authenticateUser, adminController.verifyOTP);
adminRouter.get('/login', adminController.adminLogin)

module.exports = adminRouter;