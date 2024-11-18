const { Router } = require("express");
const {
  addFineData,
  getFinesByDate,
} = require("../../controller/admin/staff/attendence/fine.controller.js");

const FineRouter = Router();

FineRouter.post("/create", addFineData);
FineRouter.get("/", getFinesByDate);

module.exports = FineRouter;
