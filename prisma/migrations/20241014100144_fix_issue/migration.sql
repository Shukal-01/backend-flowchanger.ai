/*
  Warnings:

  - A unique constraint covering the columns `[panaltyOvertimeDetailId]` on the table `EarlyLeavePolicy` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[panaltyOvertimeDetailId]` on the table `LateComingPolicy` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[panaltyOvertimeDetailId]` on the table `OvertimePolicy` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "EarlyLeavePolicy" DROP CONSTRAINT "EarlyLeavePolicy_panaltyOvertimeDetailId_fkey";

-- DropForeignKey
ALTER TABLE "LateComingPolicy" DROP CONSTRAINT "LateComingPolicy_panaltyOvertimeDetailId_fkey";

-- DropForeignKey
ALTER TABLE "OvertimePolicy" DROP CONSTRAINT "OvertimePolicy_panaltyOvertimeDetailId_fkey";

-- AlterTable
ALTER TABLE "EarlyLeavePolicy" ALTER COLUMN "panaltyOvertimeDetailId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "LateComingPolicy" ALTER COLUMN "panaltyOvertimeDetailId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "OvertimePolicy" ALTER COLUMN "panaltyOvertimeDetailId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "PanaltyOvertimeDetails" ADD COLUMN     "earlyLeavePolicyId" TEXT,
ADD COLUMN     "lateComingPolicyId" TEXT,
ADD COLUMN     "overtimePolicyId" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "EarlyLeavePolicy_panaltyOvertimeDetailId_key" ON "EarlyLeavePolicy"("panaltyOvertimeDetailId");

-- CreateIndex
CREATE UNIQUE INDEX "LateComingPolicy_panaltyOvertimeDetailId_key" ON "LateComingPolicy"("panaltyOvertimeDetailId");

-- CreateIndex
CREATE UNIQUE INDEX "OvertimePolicy_panaltyOvertimeDetailId_key" ON "OvertimePolicy"("panaltyOvertimeDetailId");

-- AddForeignKey
ALTER TABLE "EarlyLeavePolicy" ADD CONSTRAINT "EarlyLeavePolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LateComingPolicy" ADD CONSTRAINT "LateComingPolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OvertimePolicy" ADD CONSTRAINT "OvertimePolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;
