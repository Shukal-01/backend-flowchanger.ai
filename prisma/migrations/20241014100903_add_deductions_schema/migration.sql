-- DropForeignKey
ALTER TABLE "Deductions" DROP CONSTRAINT "Deductions_salaryId_fkey";

-- AlterTable
ALTER TABLE "Deductions" ALTER COLUMN "salaryId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Deductions" ADD CONSTRAINT "Deductions_salaryId_fkey" FOREIGN KEY ("salaryId") REFERENCES "SalaryDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;
