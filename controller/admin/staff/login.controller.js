require("dotenv").config();
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

// function to match staff MPin
const matchStaffLoginOTP = async (req, res) => {
  const { mobile, login_otp } = req.body;
  try {
    const staff = await prisma.user.findFirst({
      where: { mobile: mobile },
    });
    console.log(staff.mobile);
    if (!staff) {
      return res.status(404).json({ message: "Staff member not found" });
    }

    if (staff.otp === login_otp) {
      const token = jwt.sign({ userId: staff.id }, process.env.JWT_SECRET);
      return res.status(200).json({ message: "OTP matched", token: token });
    } else {
      return res.status(400).json({ message: "OTP not matched" });
    }
    /// send token,
  } catch (error) {
    res.status(500).json({ message: "Failed", error: error.message });
  }
};

module.exports = { matchStaffLoginOTP };
