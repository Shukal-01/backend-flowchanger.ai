const express = require("express");
const app = express();
const routeRoutes = require("./routes/routes.js");
const cors = require("cors");
const dotenv = require("dotenv");
// const helmet = require('helmet');
dotenv.config()

// app.use(helmet());
app.use(cors({
    origin: process.env.CORS_ORIGIN,
    credentials: true
}))

// Middleware for parsing JSON and form data
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/", routeRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
})