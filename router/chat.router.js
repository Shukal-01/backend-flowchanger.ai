const express = require("express");
const authorizationMiddleware = require("../middleware/auth");
const { getOneOnOneChat } = require("../controller/chat.controller");
const ChatRouter = express.Router();

ChatRouter.get("/:id", authorizationMiddleware, getOneOnOneChat);

module.exports = ChatRouter;
