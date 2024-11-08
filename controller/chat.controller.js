const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const getOneOnOneChat = async (req, res) => {
  const { id } = req.params;

  try {
    if (!id) {
      return res.status(400).json({ error: "User ID is required" });
    }

    console.log(id, req.userId);

    const user1 = await prisma.user.findFirst({ where: { id } });
    const user2 = await prisma.user.findFirst({ where: { id: req.userId } });
    if (!user1 || !user2) {
      return res.status(404).json({ message: "One or both users not found" });
    }
    let chatRoom = await prisma.chatRoom.findFirst({
      where: {
        isGroup: false,
        users: {
          every: {
            OR: [{ id }, { id: req.userId }],
          },
        },
      },
      include: {
        messages: {
          include: {
            sender: {
              select: { id: true, name: true },
            },
          },
          orderBy: { timestamp: "asc" },
        },
        users: {
          select: { id: true, name: true },
        },
      },
    });

    if (!chatRoom) {
      chatRoom = await prisma.chatRoom.create({
        data: {
          isGroup: false,
          users: {
            connect: [{ id }, { id: req.userId }],
          },
        },
        include: {
          messages: {
            include: {
              sender: {
                select: { id: true, name: true },
              },
            },
          },
          users: {
            select: { id: true, name: true },
          },
        },
      });
    }

    chatRoom.userId = req.userId;
    res.status(200).json(chatRoom);
  } catch (error) {
    console.error("Error fetching or creating one-on-one chat:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

module.exports = { getOneOnOneChat };
