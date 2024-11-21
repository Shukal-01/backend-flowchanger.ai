const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const allStaffAttendanceByDate = async (req, res) => {
    try {
        const { type, date } = req.query;

        if (type === "day") {
            const [day, month, year] = date.split('/').map(Number);
            const requestedDate = new Date(year, month - 1, day);
            const startOfDay = new Date(requestedDate.setHours(0, 0, 0, 0));
            const endOfDay = new Date(startOfDay.getTime() + 86400000);
            // Get the current date to ensure no future dates are handled
            const currentDate = new Date();
            console.log(currentDate)
            currentDate.setHours(0, 0, 0, 0); // Reset time for comparison

            // Check if requested date is in the future
            if (requestedDate > currentDate) {
                return res.status(400).json({
                    message: `The requested date (${day}/${month}/${year}) is a future date. No entries are available for future dates.`,
                });
            }

            // Fetch all staff details
            const staffList = await prisma.staffDetails.findMany({
                select: {
                    id: true,
                    date_of_joining: true,
                },
            });

            const eligibleStaff = staffList.filter(staff => {
                const joiningDate = new Date(staff.date_of_joining);
                return requestedDate >= joiningDate; // Only include staff who joined on or before the requested date
            });

            // If no eligible staff, return appropriate message
            if (eligibleStaff.length === 0) {
                return res.status(404).json({
                    message: `No staff available for the requested date (${day}/${month}/${year}) as all have joining dates after this date.`,
                });
            }

            const records = [];
            for (const staff of eligibleStaff) {
                const { id, date_of_joining } = staff;
                const joiningDate = new Date(date_of_joining);

                // Check if the requested date is before the staff's date of joining
                if (requestedDate < joiningDate) {
                    return res.status(400).json({
                        message: `The requested date (${day}/${month}/${year}) is before the joining date of staff ID ${id}. No entry will be created.`,
                    });
                }

                // Check for existing punch record for the staff on the requested date
                let punchRecord = await prisma.punchRecords.findFirst({
                    where: {
                        staffId: id,
                        punchDate: {
                            gte: startOfDay,
                            lt: endOfDay,
                        },
                    },
                    include: {
                        punchIn: true,
                        punchOut: true,
                        staff: {
                            include: {
                                User: true,
                                Fine: true,
                                Overtime: true,
                            },
                        },
                    },
                });

                // If no record exists, create one
                if (!punchRecord) {
                    punchRecord = await prisma.punchRecords.create({
                        data: {
                            staff: {
                                connect: {
                                    id: id,
                                },
                            },
                            punchDate: startOfDay,
                            // entryDate: `${day.toString().padStart(2, '0')}/${month.toString().padStart(2, '0')}/${year}`,
                            status: 'ABSENT',
                        },
                    });
                }
                records.push({
                    staffId: id,
                    punchRecord,
                });
            }

            return res.status(200).json({
                message: `Punch records fetched successfully for the requested date (${day}/${month}/${year}).`,
                records,
            });
        } else {
            return res.status(400).json({ message: "Invalid type. Only 'day' is supported." });
        }
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: "Failed to fetch staff punch records." });
    }
};
// single staff Attendance get

const getSingleStaffAttendance = async (req, res) => {
    try {
        const { id } = req.params;
        const { type, date } = req.query;

        const staff = await prisma.staffDetails.findFirst({
            where: { id: id },
            select: {
                id: true,
                date_of_joining: true,
            },
        });

        const { date_of_joining } = staff;
        let records = [];
        let entryCount = 0;
        let createdCount = 0;

        // Get the current date to check for future date
        const currentDate = new Date();
        currentDate.setHours(0, 0, 0, 0); // Reset time for comparison

        if (type === "day") {
            const [day, month, year] = date.split('/').map(Number);
            const requestedDate = new Date(year, month - 1, day); // Parse requested date

            // Check if requested date is in the future
            if (requestedDate > currentDate) {
                return res.status(400).json({
                    message: `The requested date (${day}/${month}/${year}) is a future date. No entries are available for future dates.`,
                });
            }

            const startDate = new Date(date_of_joining); // Staff's date of joining
            if (requestedDate < startDate) {
                return res.status(400).json({
                    message: `The requested date (${day}/${month}/${year}) is before the joining date of staff ID ${id}. No entry will be created.`,
                });
            }

            const startOfDay = new Date(requestedDate.setHours(0, 0, 0, 0)); // Start of requested date
            const endOfDay = new Date(startOfDay.getTime() + 86400000); // End of requested date

            // Find punch record for the requested date along with punchIn and punchOut details
            let punchRecord = await prisma.punchRecords.findFirst({
                where: {
                    staffId: id,
                    punchDate: {
                        gte: startOfDay,
                        lt: endOfDay,
                    },
                },
                include: {
                    punchIn: true,   // Include punchIn details
                    punchOut: true,  // Include punchOut details                    
                    staff: {
                        include: {
                            User: true,
                            Fine: true,
                            Overtime: true,
                        },
                    }

                },
            });

            if (!punchRecord) {
                // Create a new record if it doesn't exist
                punchRecord = await prisma.punchRecords.create({
                    data: {
                        staff: {
                            connect: {
                                id: id,
                            },
                        },
                        punchDate: startOfDay,
                        status: 'ABSENT',
                    },
                });
                createdCount++;
                return res.status(200).json({
                    message: 'Attendance record fetched successfully',
                    attendanceRecord: punchRecord,
                });
            } else {
                return res.status(200).json({
                    message: 'Attendance record fetched successfully for the requested date.',
                    attendanceRecord: punchRecord,
                });
            }
        }
        else if (type === "month") {
            const [month, year] = date.split('/').map(Number);
            const startMonth = new Date(year, month - 1, 1);
            const endMonth = new Date(year, month, 0);
            const startDate = new Date(date_of_joining);

            // Check if the requested month is in the future
            if (startMonth > currentDate) {
                return res.status(400).json({
                    message: `The requested month (${month}/${year}) is in the future. No entries are available for future months.`,
                });
            }

            // Check if the requested month is before the joining month
            if (startMonth < new Date(startDate.getFullYear(), startDate.getMonth(), 1)) {
                return res.status(400).json({
                    message: `This month data not found as it is before the staff joining date.`,
                });
            }

            for (let day = 1; day <= endMonth.getDate(); day++) {
                const currentDate = new Date(year, month - 1, day);

                // Skip days before the joining date
                if (currentDate < startDate) {
                    continue;
                }

                // Check if the current date is in the future
                if (currentDate > currentDate) {
                    return res.status(400).json({
                        message: `The requested date (${day}/${month}/${year}) is in the future. No entries are available for future dates.`,
                    });
                }

                let punchRecord = await prisma.punchRecords.findFirst({
                    where: {
                        staffId: id,
                        punchDate: {
                            gte: currentDate,
                            lt: new Date(currentDate.getTime() + 86400000),
                        },
                    },
                    include: {
                        punchIn: true,   // Include punchIn details
                        punchOut: true,  // Include punchOut details    
                        fine: true,
                        Overtime: true,
                        staff: {
                            include: {
                                User: true,
                            },
                        }
                    },
                });

                if (!punchRecord) {
                    // If no record exists, create it
                    punchRecord = await prisma.punchRecords.create({
                        data: {
                            staff: {
                                connect: {
                                    id: id,
                                },
                            },
                            punchDate: currentDate,
                            status: 'ABSENT',
                        },
                    });
                    createdCount++;
                }
                records.push(punchRecord); // Add record to the records array
            }

            entryCount = records.length;

            return res.status(200).json({
                message: `Attendance records for this month fetched successfully.`,
                attendanceRecords: records,
            });
        }

    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Attendance not fetched', error: error.message });
    }
};



const updatePunchRecordStatus = async (req, res) => {
    const { id } = req.params;
    const { status } = req.body;

    const validStatuses = ["ABSENT", "PRESENT", "HALFDAY", "PAIDLEAVE"];

    if (!validStatuses.includes(status)) {
        return res.status(400).json({
            error:
                "Invalid status. Valid statuses are ABSENT, PRESENT, HALFDAY, PAIDLEAVE.",
        });
    }

    try {
        const updatedPunchRecord = await prisma.punchRecords.update({
            where: { id },
            data: { status: status, isApproved: true },
        });

        res.status(200).json({
            message: "Punch record status updated successfully",
            updatedPunchRecord,
        });
    } catch (error) {
        console.error("Error updating punch record:", error);
        res.status(500).json({ error: "Failed to update punch record status" });
    }
};


module.exports = {
    allStaffAttendanceByDate,
    updatePunchRecordStatus,
    getSingleStaffAttendance,
};
