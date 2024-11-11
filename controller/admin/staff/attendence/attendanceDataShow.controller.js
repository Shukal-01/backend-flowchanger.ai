const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { attendenceAutomationRuleSchema } = require("../../../../utils/validations.js");
