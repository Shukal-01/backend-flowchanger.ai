const { Router } = require("express");
const {
  addFineData,
  getFinesByDate,
  updateFine,
} = require("../../controller/admin/staff/attendence/fine.controller.js");

const FineRouter = Router();

FineRouter.post("/create", addFineData);
FineRouter.get("/", getFinesByDate);
FineRouter.put("/:id", updateFine);

module.exports = FineRouter;
