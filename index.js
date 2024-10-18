require("dotenv").config();
const express = require('express');
const rootRouter = require("./router/routes"); 
const cors = require("cors");
const app = express();
const upload = require('./middleware/upload.js');
const {addProjectFiles} = require('./controller/admin/client/projectFiles.controller.js');

const PORT = process.env.PORT || 3000;
app.use(
  cors({
    origin: "*",
  })
);


app.use(express.json());
app.use(express.static('public'));
app.use("/api/",rootRouter);


app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});




