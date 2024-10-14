const express = require("express");
const rootRouter = require("./router/routes.js")
const { config } = require("dotenv");

config();

const app = express();
const PORT = process.env.PORT || 8000;

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use("/api", rootRouter);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`)
});
