/*
  Warnings:

  - You are about to drop the `deductions` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "deductions" DROP CONSTRAINT "deductions_salaryId_fkey";

-- DropTable
DROP TABLE "deductions";

-- CreateTable
CREATE TABLE "Deductions" (
    "id" TEXT NOT NULL,
    "salaryId" TEXT NOT NULL,
    "heads" TEXT[],
    "calculation" TEXT[],
    "amount" TEXT[],

    CONSTRAINT "Deductions_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Deductions" ADD CONSTRAINT "Deductions_salaryId_fkey" FOREIGN KEY ("salaryId") REFERENCES "SalaryDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
