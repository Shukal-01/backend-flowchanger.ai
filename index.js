require("dotenv").config();
const express = require("express");
const app = express();
const cors = require("cors");
const path = require("path");
const rootRouter = require("./routes/routes");
const PORT = process.env.PORT || 8000;

app.use(
  cors({
    origin: "*",
  })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));

app.use("/api/", rootRouter);


app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
