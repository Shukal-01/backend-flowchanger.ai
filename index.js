require("dotenv").config();
const express = require("express");
const http = require("http");
const cors = require("cors");
const socketIo = require("socket.io");
const rootRouter = require("./router/routes");
const jwt = require("jsonwebtoken");
// const path = require("path");

const app = express();
// const _dirname = path.dirname("")
// const buildpath = path.join(_dirname, "../frontend-flowchanger.ai/build")
// app.use(express.static(buildpath))

// app.get('*', (req, res) => {
//   res.sendFile(path.join(buildpath, 'index.html'));
// });
const PORT = process.env.PORT || 5000;
// const PORT = 5000;
app.use(
  cors({
    origin: "*",
  })
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));

app.use("/api/", rootRouter);

const server = http.createServer(app);

const io = socketIo(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST", "PUT", "DELETE"],
  },
});

io.on("connection", (socket) => {
  console.log("New client connected:", socket.id);

  socket.on("setup", ({ token }) => {
    try {
      const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
      const id = decodedToken.userId;
      console.log("id:", id);
      socket.join(id);
    } catch (error) {
      console.log(error);
    }
  });

  socket.on("join_room", (roomId) => {
    console.log("User joined room:", roomId);
    socket.join(roomId);
  });

  socket.on("send_message", (data) => {
    console.log("receive_message", data);
    const { room, users, message } = data;
    users.forEach((user) => {
      if (user.id !== message.sender.id) {
        console.log(user.id);
        socket.in(user.id).emit("message_received", message);
      }
    });
  });

  socket.on("message", (data) => {
    console.log("Received message:", data);
    io.emit("message", data);
  });

  socket.on("disconnect", () => {
    console.log("Client disconnected:", socket.id);
  });
});


server.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
