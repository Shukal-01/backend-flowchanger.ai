const express = require('express');
const rootRouter = require("./router/routes"); 
const app = express();

const PORT = process.env.PORT || 8000;

// Middleware - use only once
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Use rootRouter for all routes
app.use(rootRouter);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
