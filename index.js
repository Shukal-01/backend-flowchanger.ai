require("dotenv").config();
const express = require('express');
const rootRouter = require("./router/routes"); 
const cors = require("cors");
const app = express();
const upload = require('./middleware/upload.js');
// const {addProjectFiles} = require('./controller/admin/project/projectFiles.controller.js');
const bodyParser = require('body-parser');

const PORT = process.env.PORT || 3000;
app.use(
  cors({
    origin: "*",
  })
);

app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));

app.use(express.json());
app.use(express.static('public'));
app.use("/api/",rootRouter);


app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});




