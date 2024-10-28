require("dotenv").config();
const { PrismaClient } = require("@prisma/client");
const multer = require("multer");
const path = require("path");
const bcrypt = require("bcrypt");
const nodemailer = require("nodemailer");
const jwt = require("jsonwebtoken");
const prisma = new PrismaClient();

const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 465,
  secure: true,
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, "uploads/"),
  filename: (req, file, cb) =>
    cb(null, Date.now() + path.extname(file.originalname)),
});

const upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const allowedTypes = ["image/jpeg", "image/jpg", "image/png"];
    allowedTypes.includes(file.mimetype)
      ? cb(null, true)
      : cb(new Error("Invalid file type."));
  },
}).fields([
  { name: "profile_image", maxCount: 1 },
  { name: "company_logo", maxCount: 1 },
]);

const generateOTP = () =>
  Math.floor(100000 + Math.random() * 900000).toString();

const sendOtp = async (email, otp) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: email,
    subject: "Your OTP Code",
    html: `<div><h2>Your OTP Code</h2><p>Code: <strong>${otp}</strong></p></div>`,
  };
  await transporter.sendMail(mailOptions);
};

const adminSignup = async (req, res) => {
  try {
    const {
      email,
      password,
      first_name,
      last_name,
      mobile,
      company_name,
      company_logo,
    } = req.body;
    if (!email || !password)
      return res.status(400).json({ message: "Email and password required." });

    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser)
      return res.status(400).json({ message: "Email already exists." });

    const hashedPassword = await bcrypt.hash(password, 10);
    const otp = generateOTP();
    const otpExpiresAt = new Date(Date.now() + 5 * 60 * 1000);

    const newUser = await prisma.user.create({
      data: {
        email,
        password: hashedPassword,
        name: first_name + last_name,
        mobile,
        role: "ADMIN",
        otp: parseInt(otp),
        otpExpiresAt,
      },
    });

    await sendOtp(email, otp);
    res
      .status(201)
      .json({ message: "OTP sent to your email for verification." });
  } catch (error) {
    console.error("Error in adminSignup:", error);
    res.status(500).json({ message: "Internal server error." });
  }
};

const googleSignup = async (req, res) => {
  try {
    const { email, name, mobile } = req.body;
    if (!email)
      return res.status(400).json({ message: "Email and password required." });

    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser)
      return res.status(400).json({ message: "Email already exists." });

    const newUser = await prisma.user.create({
      data: {
        email,
        name,
        mobile,
        role: "ADMIN",
        is_verified: true,
      },
    });

    res
      .status(201)
      .json({ message: "OTP sent to your email for verification." });
  } catch (error) {
    console.error("Error in adminSignup:", error);
    res.status(500).json({ message: "Internal server error." });
  }
};

const verifyOTP = async (req, res) => {
  try {
    const { otp, email } = req.body;
    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) return res.status(404).json({ message: "User not found." });

    if (user.otp === parseInt(otp) && user.otpExpiresAt > new Date()) {
      await prisma.user.update({
        where: { email },
        data: { is_verified: true },
      });
      return res.status(200).json({ message: "OTP verified successfully." });
    } else {
      return res.status(400).json({ message: "Invalid or expired OTP." });
    }
  } catch (error) {
    console.error("Error during OTP verification:", error);
    res.status(500).json({ message: "Internal server error." });
  }
};

const updateAdmin = async (req, res) => {
  try {
    upload(req, res, async (err) => {
      if (err) return res.status(400).json({ message: err.message });

      const {
        email,
        mobile,
        company_name,
        package_id,
        time_format, // Added new fields
        time_zone, // Added new fields
        date_format, // Added new fields
        week_format, // Added new fields
      } = req.body;

      // Step 1: Find the user by email
      const user = await prisma.user.findUnique({
        where: { email },
        include: { adminDetails: true },
      });
      if (!user) return res.status(404).json({ message: "Admin not found." });

      // Step 2: Handle file uploads (profile_image and company_logo)
      const profileImage = req.files?.profile_image
        ? req.files.profile_image[0].filename
        : null;
      const companyLogo = req.files?.company_logo
        ? req.files.company_logo[0].filename
        : null;

      // Step 3: Update the User and AdminDetails
      const updatedUser = await prisma.user.update({
        where: { email },
        data: {
          mobile: mobile || user.mobile,
          adminDetails: {
            upsert: {
              create: {
                company_name: company_name,
                package_id: package_id,
                profile_image: profileImage,
                company_logo: companyLogo,
                time_format: time_format,
                time_zone: time_zone,
                date_format: date_format,
                week_format: week_format,
              },
              update: {
                company_name: company_name,
                package_id: package_id,
                profile_image: profileImage,
                company_logo: companyLogo,
                time_format: time_format,
                time_zone: time_zone,
                date_format: date_format,
                week_format: week_format,
              },
            },
          },
        },
      });

      // Step 4: Generate a new JWT token
      const token = jwt.sign({ id: updatedUser.id }, process.env.JWT_SECRET);

      // Step 5: Send the response with success message and token
      res.status(200).json({ message: "Admin updated successfully.", token });
    });
  } catch (error) {
    console.error("Error in updateAdmin:", error);
    res.status(500).json({ message: "Failed to update admin details." });
  }
};

const adminLogin = async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) return res.status(401).json({ message: "Invalid email." });

    const isPasswordMatch = await bcrypt.compare(password, user.password);
    if (!isPasswordMatch)
      return res.status(401).json({ message: "Invalid password." });

    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET);
    res.status(200).json({ message: "Login successful!", token });
  } catch (error) {
    console.error("Login error:", error);
    res.status(500).json({ message: "Internal server error." });
  }
};

module.exports = { adminSignup, verifyOTP, adminLogin, updateAdmin };
