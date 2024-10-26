const express = require("express");
const shiftRouter = express.Router();
const { createShift, getAllShift, getShiftById, updateShift, getFixedShifts, createFixedShift, getFlexibleShifts, createFlexibleShift, updateMultipleShifts } = require("../../controller/admin/shift.controller");

shiftRouter.post("/", createShift);
shiftRouter.get("/", getAllShift);
shiftRouter.get("/:id", getShiftById);
shiftRouter.put("/:id", updateShift);
shiftRouter.put("/update-multiple-shifts", updateMultipleShifts)
shiftRouter.get("/fixed-shift", getFixedShifts);
shiftRouter.post("/fixed-shift", createFixedShift);
shiftRouter.post("/flexible-shift", createFlexibleShift);
shiftRouter.get("/flexible-shift", getFlexibleShifts);


module.exports = shiftRouter