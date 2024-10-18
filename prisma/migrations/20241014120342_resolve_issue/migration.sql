/*
  Warnings:

  - You are about to drop the column `earlyLeavePolicyId` on the `PanaltyOvertimeDetails` table. All the data in the column will be lost.
  - You are about to drop the column `lateComingPolicyId` on the `PanaltyOvertimeDetails` table. All the data in the column will be lost.
  - You are about to drop the column `overtimePolicyId` on the `PanaltyOvertimeDetails` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[staffId]` on the table `PanaltyOvertimeDetails` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "PanaltyOvertimeDetails" DROP COLUMN "earlyLeavePolicyId",
DROP COLUMN "lateComingPolicyId",
DROP COLUMN "overtimePolicyId";

-- CreateIndex
CREATE UNIQUE INDEX "PanaltyOvertimeDetails_staffId_key" ON "PanaltyOvertimeDetails"("staffId");
