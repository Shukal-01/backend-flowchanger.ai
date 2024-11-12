const multer = require("multer");
const path = require("path");
const { v4: uuidv4 } = require("uuid");
const cloudinary = require("cloudinary").v2;
const fs = require("fs");
require("dotenv").config();

// Cloudinary configuration
cloudinary.config({
  cloud_name: process.env.CLOUD_NAME,
  api_key: process.env.CLOUD_API_KEY,
  api_secret: process.env.CLOUD_API_SECRET,
});

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads"); // Local storage path
  },
  filename: (req, file, cb) => {
    const uniqueFilename = `${Date.now()}-${uuidv4()}`;
    req.savedFilename = uniqueFilename;
    cb(null, uniqueFilename);
  },
});

const fileFilter = (req, file, cb) => {
  const allowedTypes = ["image/jpeg", "image/png", "image/jpg"];
  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error("Only .jpeg, .jpg, and .png formats allowed!"), false);
  }
};

// Function to create Multer instance
const upload = () =>
  multer({
    storage,
    limits: { fileSize: 1024 * 1024 * 10 }, // Limit file size to 10MB
    fileFilter,
  });

// Middleware to handle Cloudinary upload
const uploadAndSaveToCloudinary = (fieldName) => (req, res, next) => {
  upload().single(fieldName)(req, res, async (err) => {
    if (err) {
      return res.status(400).send(err.message);
    }

    let folderName = "Default_Folder";
    if (req.route.path.includes("in")) folderName = "Punch_In_Images";
    else if (req.route.path.includes("start"))
      folderName = "Start_Break_Images";
    else if (req.route.path.includes("end")) folderName = "End_Break_Images";
    else if (req.route.path.includes("out")) folderName = "Punch_Out_Images";
    else if (req.route.path.includes("verify"))
      folderName = "Background_Verification_Images";
    else if (req.route.path.includes("work-entry"))
      folderName = "Work_Entry_Images";
    else if (req.route.path.includes("project-files"))
      folderName = "Project_File_Images";

    if (req.file) {
      try {
        const cloudinaryResult = await cloudinary.uploader.upload(
          req.file.path,
          {
            folder: folderName,
            public_id: req.savedFilename,
          }
        );

        req.imageUrl = cloudinaryResult.secure_url;
        fs.unlinkSync(req.file.path); // Delete local file
      } catch (uploadError) {
        return res
          .status(500)
          .json({ error: "Cloudinary upload failed", details: uploadError });
      }
    }

    next();
  });
};

module.exports = { uploadAndSaveToCloudinary };
