
// index.js
const express = require('express');
// const session = require('express-session'); 
const rootRouter = require("./router/routes"); 
const path = require('path');
const app = express();

const PORT = process.env.PORT || 8000;

// Middleware - use only once
app.use(express.json());
app.use(express.urlencoded({ extended: false   }));


// Session configuration
// app.use(session({
//   secret: process.env.SESSION_SECRET,
//   resave: false,
//   saveUninitialized: true,
//   cookie: { secure: false, maxAge: 60000 }
// }));


app.use(express.static(path.join(__dirname, 'public')));

// Redirect to home.html when accessing the root ("/") route
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'home.html'));
});

// Use rootRouter for all routes
app.use(rootRouter);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
