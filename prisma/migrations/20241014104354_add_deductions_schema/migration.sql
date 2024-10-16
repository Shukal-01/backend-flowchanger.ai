/*
  Warnings:

  - Made the column `salaryId` on table `Deductions` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Deductions" DROP CONSTRAINT "Deductions_salaryId_fkey";

-- AlterTable
ALTER TABLE "Deductions" ALTER COLUMN "salaryId" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "Deductions" ADD CONSTRAINT "Deductions_salaryId_fkey" FOREIGN KEY ("salaryId") REFERENCES "SalaryDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
