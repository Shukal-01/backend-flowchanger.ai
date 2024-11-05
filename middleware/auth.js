require("dotenv").config();
const jwt = require("jsonwebtoken");

const authorizationMiddleware = (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
      return res
        .status(401)
        .json({ error: "No token provided or invalid format" });
    }

    const token = authHeader.startsWith("Bearer ")
      ? authHeader.split(" ")[1]
      : authHeader;
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
    req.userId = decodedToken.userId; // Assuming `userId` is in the token payload
    next();
  } catch (error) {
    res.status(401).json({
      error: "Invalid token or authorization failed",
    });
  }
};

module.exports = authorizationMiddleware;
