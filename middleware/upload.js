// middleware/multerConfig.js
const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './uploads'); // Define where to store the images
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname)); // File naming convention
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

const upload = multer({
    storage,
    limits: { fileSize: 1024 * 1024 * 10 }, // Limit file size to 5MB
    fileFilter,
});

module.exports = upload; 