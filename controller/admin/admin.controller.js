require("dotenv").config();
const { PrismaClient } = require("@prisma/client");
const multer = require("multer");
const path = require("path");
const bcrypt = require("bcrypt");
const nodemailer = require("nodemailer");
const jwt = require("jsonwebtoken");
const prisma = new PrismaClient();
const { adminSchema } = require("../../utils/validations");

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
  destination: (req, file, cb) => {
    cb(null, "uploads/");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const allowedTypes = ["image/jpeg", "image/jpg", "image/png"];
    if (allowedTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(
        new Error("Invalid file type, only JPEG, JPG, and PNG are allowed!"),
        false
      );
    }
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
    html: `
        <div style="background-color:#f2f2f2;padding:20px;font-family:sans-serif;text-align:center;">
            <h2>Your OTP Code</h2>
            <p>Your OTP code is: <strong>${otp}</strong></p>
            <p>This OTP will expire in 5 minutes.</p>
        </div>
        `,
  };

  try {
    await transporter.sendMail(mailOptions);
  } catch (error) {
    console.error("Error sending OTP:", error);
    throw new Error("Failed to send OTP.");
  }
};

const adminSignup = async (req, res) => {
  try {
    const { email, first_name, last_name, mobile, password } = req.body;

    // Validation for email and password
    if (!email || !password) {
      return res.status(400).json({
        status: 400,
        message: "Email and password are required.",
      });
    }

    // Check if admin already exists
    const existingAdmin = await prisma.admin.findUnique({ where: { email } });
    if (existingAdmin) {
      return res.status(400).json({
        status: 400,
        message: "Email already exists!",
      });
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Generate OTP and set expiration time
    const otp = generateOTP();
    const otpExpiresAt = new Date();
    otpExpiresAt.setMinutes(otpExpiresAt.getMinutes() + 5);

    // Create the new admin entry in the database
    const newAdmin = await prisma.admin.create({
      data: {
        email,
        first_name,
        last_name,
        mobile,
        password: hashedPassword,
        otp: parseInt(otp),
        otpExpiresAt,
      },
    });

    // Send OTP via email
    await sendOtp(email, otp);

    return res.status(201).json({
      status: 201,
      message:
        "An OTP has been sent to your email. Verify your email to activate your account.",
    });
  } catch (error) {
    console.error("Unexpected Error in adminSignup:", error);
    return res.status(500).json({
      status: 500,
      message: "Internal server error occurred. Please try again later.",
    });
  }
};

// OTP Verified API
const verifyOTP = async (req, res) => {
  const { otp, email } = req.body;
  console.log("OTP:" + otp);
  console.log("email:" + email);
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
      return res
        .status(200)
        .json({ status: 200, message: "OTP verified successfully." });
    } else {
      return res
        .status(400)
        .json({ status: 400, message: "Invalid or expired OTP." });
    }
  } catch (error) {
    console.error("Error during OTP verification:", error);
    return res
      .status(500)
      .json({ status: 500, message: "Internal server error." });
  }
};

const updateAdmin = async (req, res) => {
  try {
    // Handle file uploads with multer
    upload(req, res, async (err) => {
      if (err instanceof multer.MulterError || err) {
        return res.status(400).json({ status: 400, message: err.message });
      }

      const { email } = req.body;

      // Find the admin by email
      const admin = await prisma.admin.findUnique({
        where: { email },
      });

      if (!admin) {
        return res
          .status(404)
          .json({ status: 404, message: "Admin not found." });
      }

      // Destructure the remaining fields from the request body
      const {
        time_zone,
        time_formate,
        date_formate,
        week_formate,
        package_id,
        company_name,
      } = req.body;

      // Handle file uploads, keeping the existing file if not updated
      const profileImage = req.files?.profile_image
        ? req.files.profile_image[0].filename
        : admin.profile_image;

      const companyLogo = req.files?.company_logo
        ? req.files.company_logo[0].filename
        : admin.company_logo;

      // Update the admin details in the database
      const updatedAdmin = await prisma.admin.update({
        where: { email },
        data: {
          time_zone: time_zone || admin.time_zone,
          time_formate: time_formate || admin.time_formate,
          date_formate: date_formate || admin.date_formate,
          week_formate: week_formate || admin.week_formate,
          package_id: package_id || admin.package_id,
          company_name: company_name || admin.company_name,
          profile_image: profileImage,
          company_logo: companyLogo,
        },
      });

      // Create a new token for the updated admin
      const token = jwt.sign({ id: updatedAdmin.id }, process.env.JWT_SECRET);

      return res.status(200).json({
        status: 200,
        message: "Admin details updated successfully.",
        updatedAdmin,
        token: token,
      });
    });
  } catch (error) {
    console.error("Error in updateAdmin:", error);
    return res
      .status(500)
      .json({ status: 500, message: "Failed to update admin details." });
  }
};

const adminLogin = async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({
      status: 400,
      message: "Email and password are required for login.",
    });
  }
  try {
    const admin = await prisma.admin.findUnique({ where: { email } });
    if (!admin) {
      return res.status(401).json({ status: 401, message: "Invalid email." });
    }
    const isPasswordMatch = await bcrypt.compare(password, admin.password);
    if (!isPasswordMatch) {
      return res
        .status(401)
        .json({ status: 401, message: "Invalid password." });
    }
    const token = jwt.sign({ id: admin.id }, process.env.JWT_SECRET);
    return res
      .status(200)
      .json({ status: 200, message: "Login successful!", token: token });
  } catch (error) {
    console.error("Login error:", error);
    return res
      .status(500)
      .json({ status: 500, message: "Internal server error." });
  }
};

module.exports = { adminSignup, verifyOTP, adminLogin, updateAdmin };
