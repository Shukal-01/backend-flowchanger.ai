const { Router } = require("express");
const {
    addFineData, updateMultipleFineData,
    getFinesByDate,
    updateFine,
} = require("../../controller/admin/staff/attendence/fine.controller.js");

const FineRouter = Router();

FineRouter.post("/create", addFineData);
staffAttendanceRouter.put("/", updateMultipleFineData)
FineRouter.get("/", getFinesByDate);
FineRouter.put("/:id", updateFine);

module.exports = FineRouter;
