const express = require('express');
const { PrismaClient } = require('@prisma/client');
const multer = require('multer');
require('dotenv').config();
const path = require('path');
const bcrypt = require('bcrypt');
const nodemailer = require('nodemailer');

const prisma = new PrismaClient();

// Nodemailer transporter configuration
const transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true,
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
    }
});

// Multer storage configuration
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({
    storage,
    fileFilter: (req, file, cb) => {
        const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];
        if (allowedTypes.includes(file.mimetype)) {
            cb(null, true);
        } else {
            cb(new Error("Invalid file type, only JPEG, JPG, and PNG are allowed!"), false);
        }
    }
}).fields([
    { name: 'profile_image', maxCount: 1 },
    { name: 'company_logo', maxCount: 1 }
]);

// OTP generation function
const generateOTP = () => Math.floor(100000 + Math.random() * 900000).toString();

// OTP sending function
const sendOtp = async (email, otp) => {
    const mailOptions = {
        from: process.env.EMAIL_USER,
        to: email,
        subject: 'Your OTP Code',
        html: `
        <div style="background-color:#f2f2f2;padding:20px;font-family:sans-serif;text-align:center;">
            <h2>Your OTP Code</h2>
            <p>Your OTP code is: <strong>${otp}</strong></p>
            <p>This OTP will expire in 5 minutes.</p>
        </div>
        `
    };

    try {
        await transporter.sendMail(mailOptions);
    } catch (error) {
        console.error("Error sending OTP:", error);
        throw new Error("Failed to send OTP.");
    }
};

// Signup function (with OTP)
const adminSignup = async (req, res) => {
    upload(req, res, async function (err) {
        if (err instanceof multer.MulterError || err) {
            return res.status(400).json({ status: 400, message: err.message });
        }

        const { email, first_name, last_name, mobile, time_formate, time_zone, date_formate, week_formate, package_id, company_name, password, Cpassword } = req.body;

        if (!email || !password) {
            return res.status(400).json({ status: 400, message: "Email and password are required." });
        }

        let findUser;
        try {
            findUser = await prisma.admin.findUnique({ where: { email } });
        } catch (error) {
            console.error("Error finding user:", error);
            return res.status(500).json({ status: 500, message: "Internal server error." });
        }

        if (findUser) {
            return res.status(400).json({ status: 400, message: "Email already exists!" });
        }

        if (password !== Cpassword) {
            return res.status(400).json({ status: 400, message: "Passwords do not match!" });
        }

        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        try {
            // Generate OTP and its expiration time
            const otp = generateOTP(); // Generate OTP once
            const otpExpiresAt = new Date();
            otpExpiresAt.setMinutes(otpExpiresAt.getMinutes() + 5); // OTP expires in 5 minutes

            // Create user with OTP and expiration time
            const newUser = await prisma.admin.create({
                data: {
                    email,
                    first_name,
                    last_name,
                    mobile,
                    time_zone,
                    time_formate: String(time_formate),
                    date_formate: String(date_formate),
                    week_formate: String(week_formate),
                    package_id,
                    company_name,
                    password: hashedPassword,
                    is_verified: false, // User created but not verified yet
                    otp: parseInt(otp), // Store the OTP in the database   
                    otpExpiresAt // Store expiration time
                }
            });

            // Send the same OTP to the user's email
            await sendOtp(email, otp); // Pass the generated OTP to send it via email

            // Redirect to OTP verification page
            return res.redirect('/redirectAfterDelay.html'); // Redirect to OTP page
        } catch (error) {
            console.error("Error creating user:", error);
            return res.status(500).json({ status: 500, message: "Failed to create user." });
        }
    });
};





const verifyOTP = async (req, res) => {    
    const email = req.email; // Email ko access karen
    const { otp } = req.body;

    if (!otp) {
        return res.status(400).json({ status: 400, message: "OTP is required." });
    }

    try {        
        const user = await prisma.admin.findUnique({
            where: { email },
        });

        if (!user) {
            return res.status(404).json({ status: 404, message: "User not found." });
        }        
        if (user.otp === parseInt(otp) && user.otpExpiresAt > new Date()) {            
            await prisma.admin.update({
                where: { email },
                data: {
                    is_verified: true,                    
                },
            });
            return res.status(200).json({ status: 200, message: "OTP verified successfully." });
        } else {
            return res.status(400).json({ status: 400, message: "Invalid or expired OTP." });
        }
    } catch (error) {
        console.error("Error during OTP verification:", error); // Error ko log karen
        return res.status(500).json({ status: 500, message: "Internal server error." });
    }
};









// Login API
const adminLogin = async (req, res) => {
    const { email, password } = req.body;    
    if (!email || !password) {
        return res.status(400).json({ status: 400, message: "Email and password are required for login." });
    }
    try {        
        const admin = await prisma.admin.findUnique({ where: { email } });        
        if (!admin) {
            return res.status(401).json({ status: 401, message: "Invalid email." });
        }        
        const isPasswordMatch = await bcrypt.compare(password, admin.password);
        if (!isPasswordMatch) {
            return res.status(401).json({ status: 401, message: "Invalid password." });
        }
        return res.status(200).json({ status: 200, message: "Login successful!" });
    } catch (error) {
        console.error("Login error:", error);
        return res.status(500).json({ status: 500, message: "Internal server error." });
    }
};

module.exports = { adminSignup, verifyOTP, adminLogin };
