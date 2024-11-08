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

const upload = multer({
  storage,
  limits: { fileSize: 1024 * 1024 * 10 }, // Limit file size to 10MB
  fileFilter,
}).single("photoUrl");

// Middleware to handle Cloudinary upload
const uploadAndSaveToCloudinary = (req, res, next) => {
  upload(req, res, async (err) => {
    if (err) {
      return res.status(400).send(err.message);
    }
    // console.log(req.file)
    // Define folder name based on route or controller
    let folderName = "Default_Folder"; // default folder
    // console.log(req.route.path)
    if (req.route.path.includes("in")) {
      folderName = "Punch_In_Images";
    } else if (req.route.path.includes("start")) {
      folderName = "Start_Break_Images";
    }
    else if (req.route.path.includes("end")) {
      folderName = "End_Break_Images";
    }
    else if (req.route.path.includes("out")) {
      folderName = "Punch_Out_Images";
    }
    else if (req.route.path.includes("out")) {
      folderName = "Punch_Out_Images";
    }

    if (req.file) {
      try {
        // Upload to Cloudinary
        const cloudinaryResult = await cloudinary.uploader.upload(req.file.path, {
          folder: folderName, // Optional folder in Cloudinary
          public_id: req.savedFilename,
        });
        console.log(cloudinaryResult);

        // Set Cloudinary URL in request for database storage
        req.file.cloudinaryUrl = cloudinaryResult.secure_url;
        console.log(req.file.cloudinaryUrl);
        // Optionally, delete the file from local storage after uploading to Cloudinary
        fs.unlinkSync(req.file.path);
      } catch (uploadError) {
        return res.status(500).json({ error: "Cloudinary upload failed", details: uploadError });
      }
    }

    next();
  });
};

module.exports = { uploadAndSaveToCloudinary };
