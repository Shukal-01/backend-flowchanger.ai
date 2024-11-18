const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const PunchInSchema = require("../../utils/validations").PunchInSchema;
const { ZodError } = require("zod");
const {
  PunchOutSchema,
  PunchRecordsSchema,
  salaryDetailsSchema,
} = require("../../utils/validations");
const { connect } = require("../../router/chat.router");
const { parseTime } = require("../../utils/helper");

async function createPunchIn(req, res) {
  try {
    const { punchInMethod, biometricData, qrCodeValue, location } = req.body;

    const photoUrl = req.imageUrl ?? "null";

    const user = await prisma.user.findFirst({
      where: { id: req.userId, role: "STAFF" },
      include: {
        staffDetails: {
          include: {
            FixedShift: { include: { shifts: true } },
            FlexibleShift: { include: { shifts: true } },
            SalaryDetails: true,
          },
        },
      },
    });

    if (!user) {
      return res.status(404).send("User not found");
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tom = new Date(today);
    tom.setDate(today.getDate() + 1);

    const existingPunchRecord = await prisma.punchRecords.findFirst({
      where: {
        staffId: user.staffDetails.id,
        punchDate: {
          gte: today,
          lt: tom,
        },
      },
    });

    if (existingPunchRecord && existingPunchRecord.punchInId) {
      return res.status(400).send("Punch in already created");
    }

    if (
      !user.staffDetails.FlexibleShift.length &&
      !user.staffDetails.FixedShift.length
    ) {
      console.log("No shift found");
      return res.status(404).send("No shift found");
    }

    const currentDay = today
      .toLocaleString("en-US", { weekday: "short" })
      .toUpperCase();

    const shiftType = user.staffDetails.FixedShift.length
      ? "FIXED"
      : "FLEXIBLE";

    let shift;
    let start;
    let end;

    if (shiftType === "FIXED") {
      shift = user.staffDetails.FixedShift.find(
        (sh) => sh.day.toUpperCase() === currentDay
      );
      console.log(shift);

      if (shift.length == 0) {
        return res.status(404).send("No shift found");
      }

      start = parseTime(shift.shifts[0].shiftStartTime);
      end = parseTime(shift.shifts[shift.shifts.length - 1].shiftEndTime);
    }

    if (shiftType === "FLEXIBLE") {
      shift = await prisma.flexibleShift.findFirst({
        where: {
          staffId: user.staffDetails.id,
          dateTime: { gt: today, lte: tom },
        },
        include: { shifts: true },
      });

      if (shift === null || shift.weekOff === true) {
        return res.status(400).json({ error: "Today is a week off." });
      }
      start = parseTime(shift.shifts[0].shiftStartTime);
      end = parseTime(shift.shifts[shift.shifts.length - 1].shiftEndTime);

      shift = shift.shifts[0];
    }

    PunchInSchema.parse({
      punchInMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
      location,
    });

    let punchInData = { punchInMethod, location };

    if (punchInMethod === "PHOTOCLICK") {
      punchInData.photoUrl = photoUrl;
    } else if (punchInMethod === "QRSCAN") {
      punchInData.qrCodeValue = qrCodeValue;
    } else if (punchInMethod === "BIOMETRIC") {
      punchInData.biometricData = biometricData;
    }

    const salary =
      user.staffDetails.SalaryDetails[
        user.staffDetails.SalaryDetails.length - 1
      ]?.ctc_amount ?? 10000;

    console.log(salary);

    const currTime = new Date();
    let shiftStartTime = new Date(currTime);
    shiftStartTime.setHours(start.hours, start.minutes, 0);

    let shiftEndTime = new Date(currTime);
    shiftEndTime.setHours(end.hours, end.minutes, 0);

    if (currTime > shiftStartTime) {
      const lateMinutes = Math.max(
        0,
        Math.floor((currTime - shiftStartTime) / (1000 * 60))
      );
      console.log(
        "start time",
        shiftStartTime,
        "currTime",
        currTime,
        "end time",
        shiftEndTime,
        "---",
        shiftEndTime - shiftStartTime / (1000 * 60)
      );
      const totalWorkingMinutes = Math.floor(
        (shiftEndTime - shiftStartTime) / (1000 * 60)
      );

      const daysInMonth = new Date(
        currTime.getFullYear(),
        currTime.getMonth() + 1,
        0
      ).getDate();

      const dailySalary = salary / daysInMonth;
      const salaryPerMinute = dailySalary / totalWorkingMinutes;
      const fine = lateMinutes * salaryPerMinute;

      const punchIn = await prisma.punchIn.create({
        data: {
          punchInMethod,
          ...punchInData,
          location,
        },
      });

      const punchRecord = await prisma.punchRecords.upsert({
        where: {
          staffId_punchDate: {
            staffId: user.staffDetails.id,
            punchDate: today,
          },
        },
        create: {
          punchIn: { connect: { id: punchIn.id } },
          staff: { connect: { id: user.staffDetails.id } },
          status: "PRESENT",
        },
        update: {
          punchIn: { connect: { id: punchIn.id } },
          staff: { connect: { id: user.staffDetails.id } },
          status: "PRESENT",
        },
      });

      if (fine > 0) {
        const fineRecord = await prisma.fine.create({
          data: {
            lateEntryAmount: parseFloat(fine.toFixed(2)),
            punchRecord: { connect: { id: punchRecord.id } },
            staff: { connect: { id: user.staffDetails.id } },
          },
        });
      }

      return res.status(201).json({
        punchIn,
        punchRecord,
      });
    } else {
      const punchIn = await prisma.punchIn.create({
        data: {
          punchInMethod,
          ...punchInData,
          location,
        },
      });

      const punchRecord = await prisma.punchRecords.upsert({
        where: {
          staffId_punchDate: {
            staffId: user.staffDetails.id,
            punchDate: today,
          },
        },
        create: {
          punchIn: { connect: { id: punchIn.id } },
          staff: { connect: { id: user.staffDetails.id } },
          status: "PRESENT",
        },
        update: {
          punchIn: { connect: { id: punchIn.id } },
          staff: { connect: { id: user.staffDetails.id } },
          status: "PRESENT",
        },
      });

      return res.status(201).json(punchIn, punchRecord);
    }
  } catch (error) {
    console.log(error);
    if (error instanceof ZodError) {
      return res.status(400).json({ errors: error.errors });
    }

    return res
      .status(500)
      .json({ error: "Failed to create punch-in" + error.message });
  }
}

async function getAllPunchIn(req, res) {
  try {
    const records = await prisma.punchIn.findMany({
      include: {
        punchRecords: true,
      },
    });
    return res.status(200).json(records);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ error: "Failed to retrieve punch-in records" });
  }
}

async function createPunchOut(req, res) {
  try {
    const { punchOutMethod, biometricData, qrCodeValue, location } = req.body;

    const photoUrl = req.imageUrl ?? "null";

    const user = await prisma.user.findFirst({
      where: { id: req.userId, role: "STAFF" },
      include: {
        staffDetails: {
          include: {
            FixedShift: { include: { shifts: true } },
            FlexibleShift: { include: { shifts: true } },
            SalaryDetails: true,
          },
        },
      },
    });

    if (!user) {
      return res.status(404).send("User not found");
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tom = new Date(today);
    tom.setDate(today.getDate() + 1);

    const existingPunchRecord = await prisma.punchRecords.findFirst({
      where: {
        staffId: user.staffDetails.id,
        punchDate: {
          gte: today,
          lt: tom,
        },
      },
    });

    if (!existingPunchRecord || !existingPunchRecord.punchInId) {
      return res.status(400).send("No punch-in found for today");
    }

    if (existingPunchRecord.punchOutId) {
      return res.status(400).send("Punch-out already exists");
    }
    if (
      !user.staffDetails.FlexibleShift.length &&
      !user.staffDetails.FixedShift.length
    ) {
      return res.status(404).send("No shift found");
    }

    const currentDay = today
      .toLocaleString("en-US", { weekday: "short" })
      .toUpperCase();

    const shiftType = user.staffDetails.FixedShift.length
      ? "FIXED"
      : "FLEXIBLE";

    let shift;
    let start;
    let end;

    if (shiftType === "FIXED") {
      shift = user.staffDetails.FixedShift.find(
        (sh) => sh.day.toUpperCase() === currentDay
      )?.shifts[0];

      if (shift.length === 0) {
        return res.status(404).send("No shift found");
      }
    }

    if (shiftType === "FLEXIBLE") {
      shift = await prisma.flexibleShift.findFirst({
        where: {
          staffId: user.staffDetails.id,
          dateTime: { gt: today, lte: tom },
        },
        include: { shifts: true },
      });

      if (shift === null || shift.weekOff === true) {
        return res.status(400).json({ error: "Today is a week off." });
      }
      start = parseTime(shift.shifts[0].shiftStartTime);
      end = parseTime(shift.shifts[shift.shifts.length - 1].shiftEndTime);

      shift = shift.shifts[0];
    }

    PunchOutSchema.parse({
      punchOutMethod,
      biometricData,
      qrCodeValue,
      photoUrl,
      location,
    });

    let punchOutData = { punchOutMethod, location };

    if (punchOutMethod === "PHOTOCLICK") {
      punchOutData.photoUrl = photoUrl;
    } else if (punchOutMethod === "QRSCAN") {
      punchOutData.qrCodeValue = qrCodeValue;
    } else if (punchOutMethod === "BIOMETRIC") {
      punchOutData.biometricData = biometricData;
    }

    const salary =
      user.staffDetails.SalaryDetails[
        user.staffDetails.SalaryDetails.length - 1
      ]?.ctc_amount ?? 10000;

    const currTime = new Date();
    let shiftStartTime = new Date(currTime);
    shiftStartTime.setHours(start.hours, start.minutes, 0);
    let shiftEndTime = new Date(currTime);
    shiftEndTime.setHours(end.hours, end.minutes, 0);

    if (currTime < shiftEndTime) {
      const earlyMinutes = Math.max(
        0,
        Math.floor((shiftEndTime - currTime) / (1000 * 60))
      );
      console.log(
        "scheduled end time",
        shiftEndTime,
        "currTime",
        currTime,
        "---",
        shiftEndTime - currTime / (1000 * 60)
      );

      const totalWorkingMinutes = Math.floor(
        (shiftEndTime - shiftStartTime) / (1000 * 60)
      );

      const daysInMonth = new Date(
        currTime.getFullYear(),
        currTime.getMonth() + 1,
        0
      ).getDate();

      const dailySalary = salary / daysInMonth;
      const salaryPerMinute = dailySalary / totalWorkingMinutes;
      const fine = earlyMinutes * salaryPerMinute;

      const punchOut = await prisma.punchOut.create({
        data: {
          punchOutMethod,
          ...punchOutData,
          location,
        },
      });

      const punchRecord = await prisma.punchRecords.update({
        where: { id: existingPunchRecord.id },
        data: {
          punchOut: { connect: { id: punchOut.id } },
        },
      });

      if (fine > 0) {
        const fineRecord = await prisma.fine.findFirst({
          where: {
            punchRecordId: existingPunchRecord.id,
          },
        });
        if (!fineRecord) {
          await prisma.fine.create({
            data: {
              earlyOutFineAmount: parseFloat(fine.toFixed(2)),
              punchRecord: { connect: { id: punchRecord.id } },
              staff: { connect: { id: user.id } },
            },
          });
        } else {
          await prisma.fine.update({
            where: { id: fineRecord.id },
            data: {
              earlyOutFineAmount: parseFloat(fine.toFixed(2)),
            },
          });
        }
      }

      return res.status(201).json({
        punchOut,
        punchRecord,
        fineRecord,
      });
    } else {
      const punchOut = await prisma.punchOut.create({
        data: {
          punchOutMethod,
          ...punchOutData,
          location,
        },
      });

      const punchRecord = await prisma.punchRecords.update({
        where: { id: existingPunchRecord.id },
        data: {
          punchOut: { connect: { id: punchOut.id } },
          status: "PRESENT",
        },
      });

      return res.status(201).json(punchOut, punchRecord);
    }
  } catch (error) {
    console.log(error);
    if (error instanceof ZodError) {
      return res.status(400).json({ errors: error.errors });
    }

    return res
      .status(500)
      .json({ error: "Failed to create punch-out" + error.message });
  }
}

async function getAllPunchOut(req, res) {
  try {
    const records = await prisma.punchOut.findMany({
      include: {
        punchRecords: true,
      },
    });
    return res.status(200).json(records);
  } catch (error) {
    console.log(error);
    return res
      .status(500)
      .json({ error: "Failed to retrieve punch-out records" });
  }
}

async function getPunchRecordById(req, res) {
  try {
    const { staffId } = req.params;
    const punchRecords = await prisma.punchRecords.findMany({
      where: {
        staffId,
      },
      include: {
        fine: true,
        overtime: true,
      },
    });
    res.status(200).json(punchRecords);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch punch-in" });
  }
}

async function getPunchRecords(req, res) {
  try {
    const { month, year } = req.query; // Month and Year are passed as query params

    // Initialize the date range filter
    let filter = {};

    // If both month and year are provided, apply the date range filter
    if (month && year) {
      const startDate = new Date(year, month - 1, 1); // Start of the month
      const endDate = new Date(year, month, 0); // End of the month

      filter.punchDate = {
        gte: startDate,
        lt: endDate,
      };
    }

    // Fetch the punch records based on the filter
    const punchRecords = await prisma.punchRecords.findMany({
      where: filter,
      include: {
        punchIn: true,
        punchOut: true,
        staff: true, // Include staff details
      },
    });

    // If no records are found, return a message
    if (punchRecords.length === 0) {
      return res.status(200).json({
        message:
          month && year
            ? `No punch records found for ${month}-${year}.`
            : "No punch records found.",
      });
    }

    // Calculate the totals for each status
    let totalLeave = 0;
    let totalPresent = 0;
    let totalAbsent = 0;
    let totalHalfDay = 0;

    // Iterate over punch records to calculate the totals
    punchRecords.forEach((record) => {
      switch (record.status) {
        case "LEAVE":
          totalLeave++;
          break;
        case "PRESENT":
          totalPresent++;
          break;
        case "ABSENT":
          totalAbsent++;
          break;
        case "HALF_DAY":
          totalHalfDay++;
          break;
        default:
          break;
      }
    });

    // Return the calculated results along with the punch records
    return res.status(200).json({
      status: 200,
      message: `Punch records${month && year ? ` for ${month}-${year}` : ""}`,
      data: punchRecords,
      totals: {
        totalLeave,
        totalPresent,
        totalAbsent,
        totalHalfDay,
      },
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to fetch punch records" });
  }
}

module.exports = {
  createPunchIn,
  getAllPunchIn,
  createPunchOut,
  getAllPunchOut,
  getPunchRecords,
  getPunchRecordById,
};
