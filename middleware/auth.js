require("dotenv").config();
const jwt = require("jsonwebtoken");

const authorizationMiddleware = (req, res, next) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
    const userId = decodedToken.userId;
    req.userId = userId;
    next();
  } catch {
    res.status(401).json({
      error: new Error("Invalid Request!"),
    });
  }
};

module.exports = authorizationMiddleware;