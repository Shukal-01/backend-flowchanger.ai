const express = require("express");
const shiftRouter = express.Router();
const { createShift, getAllShift, getShiftById, updateShift, getFixedShifts, createFixedShift, getFlexibleShifts, createFlexibleShift, updateMultipleShifts, updateFixedShifts, updateFlexibleShift } = require("../../controller/admin/shift.controller");

shiftRouter.get("/fixed-shift", getFixedShifts);
shiftRouter.post("/fixed-shift", createFixedShift);
shiftRouter.put("/fixed-shift/update", updateFixedShifts);
shiftRouter.post("/flexible-shift", createFlexibleShift);
shiftRouter.get("/flexible-shift", getFlexibleShifts);
shiftRouter.put("/flexible-shift/update", updateFlexibleShift)
shiftRouter.post("/", createShift);
shiftRouter.get("/", getAllShift);
shiftRouter.get("/:id", getShiftById);
shiftRouter.put("/:id", updateShift);
shiftRouter.put("/update-multiple-shifts", updateMultipleShifts)


module.exports = shiftRouter