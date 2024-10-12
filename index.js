const express = require("express");
const { PrismaClient } = require("@prisma/client");
const rootRouter = require("./router/routes");
const prisma = new PrismaClient();
const app = express();
require("dotenv").config();

app.use(express.json());

app.use("/", rootRouter);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
