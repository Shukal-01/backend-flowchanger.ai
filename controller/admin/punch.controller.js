const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const PunchInSchema = require('../../utils/validations').PunchInSchema;
const { ZodError } = require('zod');

async function createPunchIn(req, res) {
    try {
        const { punchInMethod, biometricData, qrCodeValue, staffId, punchInTime, punchInDate } = req.body;
        // const photoUrl = JSON.stringify(req.file);
        const photoUrl = String(req.file);
        if (!req.file) {
            return res.status(400).send('No file uploaded.');
        }

        // Validate input using zod schema
        PunchInSchema.parse({ staffId, punchInMethod, biometricData, qrCodeValue, photoUrl, punchInTime, punchInDate });

        let punchInData = { staffId, punchInMethod };

        // Determine the method of punch-in and set the appropriate data
        if (punchInMethod === 'PHOTOCLICK') {
            // punchInData = { ...punchInData, photoUrl: req.file.originalname };
            punchInData = { ...punchInData, photoUrl: req.savedFilename};
        } else if (punchInMethod === 'QRSCAN') {
            punchInData = { ...punchInData, qrCodeValue };
        } else if (punchInMethod === 'BIOMETRIC') {
            punchInData = { ...punchInData, biometricData };
        }
        // Create the punch-in record in the database
        const punchIn = await prisma.punchIn.create({
            data: {
                punchInMethod: punchInMethod || 'PHOTOCLICK', // default to PHOTOCLICK if not provided
                punchInTime: new Date(),
                punchInDate: new Date(),
                ...punchInData,
                staffId,
            },
        });

        return res.status(201).json(punchIn);
    } catch (error) {
        console.log(error)
        // Check if the error is from Zod validation and handle accordingly
        if (error instanceof ZodError) {
          return res.status(400).json({ errors: error.errors }); // Return detailed validation errors
        }
    
        // For any other errors, return a general error message
        return res.status(500).json({ error: "Internal Server Error" });
    }
};

module.exports = { createPunchIn };