const express = require("express");
const shiftRouter = express.Router();
const { createShift, getAllShift, getShiftById, updateShift, getFixedShifts, createFixedShift, getFlexibleShifts, createFlexibleShift, updateMultipleShifts } = require("../../controller/admin/shift.controller");

shiftRouter.post("/create", createShift);
shiftRouter.get("/", getAllShift);  
shiftRouter.get("/:id", getShiftById);
shiftRouter.put("/update/:id", updateShift);
shiftRouter.put("/updateMultipleShifts", updateMultipleShifts)
shiftRouter.get("/getFixedShift", getFixedShifts);
shiftRouter.post("/createFixedShift", createFixedShift);
shiftRouter.post("/createFlexibleShift", createFlexibleShift);
shiftRouter.get("/getFlexibleShift", getFlexibleShifts);


module.exports = shiftRouter