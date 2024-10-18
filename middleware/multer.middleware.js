// middleware/multerConfig.js
const multer = require('multer');
const path = require('path');
const { v4: uuidv4 } = require('uuid'); // Import the UUID function

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './uploads'); // Define where to store the images
    },
    filename: (req, file, cb) => {
        // const uniqueFilename = Date.now() + path.extname(file.originalname); 
        const uniqueFilename = `${Date.now()}-${uuidv4()}${path.extname(file.originalname)}`; // Generate the unique filename with Date.now() and UUID
        req.savedFilename = uniqueFilename;
        cb(null, uniqueFilename);
        // cb(null, Date.now() + path.extname(file.originalname)); // File naming convention
    },
});

const fileFilter = (req, file, cb) => {
    const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg'];
    if (allowedTypes.includes(file.mimetype)) {
        cb(null, true);
    } else {
        cb(new Error('Only .jpeg, .jpg, and .png formats allowed!'), false);
    }
};

const Filter = (req, file, cb) => {
    const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/svg', 'application/pdf', 'text/plain'];
    if (allowedTypes.includes(file.mimetype)) {
        cb(null, true);
    } else {
        cb(new Error('Only .jpeg, .jpg, .png, .svg, .txt and .pdf formats allowed!'), false);
    }
};

const upload = multer({
    storage,
    limits: { fileSize: 1024 * 1024 * 10 }, // Limit file size to 10MB
    fileFilter,
});

const uploadFile = multer({
    storage,
    limits: { fileSize: 1024 * 1024 * 10 }, // Limit file size to 10MB
    Filter,
});

module.exports = { upload, uploadFile };
