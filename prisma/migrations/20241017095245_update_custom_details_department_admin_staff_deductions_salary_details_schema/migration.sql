/*
  Warnings:

  - Added the required column `staffId` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SalaryDetails" ADD COLUMN     "staffId" TEXT NOT NULL,
ALTER COLUMN "effective_date" DROP NOT NULL,
ALTER COLUMN "salary_type" DROP NOT NULL,
ALTER COLUMN "ctc_amount" DROP NOT NULL,
ALTER COLUMN "basic" DROP NOT NULL,
ALTER COLUMN "hra" DROP NOT NULL,
ALTER COLUMN "dearness_allowance" DROP NOT NULL,
ALTER COLUMN "employer_pf" DROP NOT NULL,
ALTER COLUMN "employer_esi" DROP NOT NULL,
ALTER COLUMN "employer_lwf" DROP NOT NULL,
ALTER COLUMN "employee_pf" DROP NOT NULL,
ALTER COLUMN "employee_esi" DROP NOT NULL,
ALTER COLUMN "professional_tax" DROP NOT NULL,
ALTER COLUMN "employee_lwf" DROP NOT NULL,
ALTER COLUMN "tds" DROP NOT NULL,
ALTER COLUMN "created_at" DROP NOT NULL,
ALTER COLUMN "updated_at" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "SalaryDetails" ADD CONSTRAINT "SalaryDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
