/*
  Warnings:

  - You are about to drop the column `earnings_amount` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `earnings_calculation` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `earnings_heads` on the `SalaryDetails` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[punchRecordId]` on the table `Fine` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Earnings" ADD COLUMN     "salaryDetailsId" TEXT;

-- AlterTable
ALTER TABLE "SalaryDetails" DROP COLUMN "earnings_amount",
DROP COLUMN "earnings_calculation",
DROP COLUMN "earnings_heads";

-- CreateIndex
CREATE UNIQUE INDEX "Fine_punchRecordId_key" ON "Fine"("punchRecordId");

-- AddForeignKey
ALTER TABLE "Deductions" ADD CONSTRAINT "Deductions_salaryDetailsId_fkey" FOREIGN KEY ("salaryDetailsId") REFERENCES "SalaryDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Earnings" ADD CONSTRAINT "Earnings_salaryDetailsId_fkey" FOREIGN KEY ("salaryDetailsId") REFERENCES "SalaryDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;
