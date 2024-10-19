require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();
const path = require("path");
const rootRouter = require("./router/routes");
const PORT = process.env.PORT || 8000;

app.use(
  cors({
    origin: "*",
  })
);

app.use(express.json());
app.use(express.static("public"));
app.use("/api/", rootRouter);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
