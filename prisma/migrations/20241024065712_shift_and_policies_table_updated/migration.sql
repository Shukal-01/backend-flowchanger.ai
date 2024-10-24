/*
  Warnings:

  - The `status` column on the `Client` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `panaltyOvertimeDetailId` on the `EarlyLeavePolicy` table. All the data in the column will be lost.
  - You are about to drop the column `panaltyOvertimeDetailId` on the `LateComingPolicy` table. All the data in the column will be lost.
  - You are about to drop the column `panaltyOvertimeDetailId` on the `OvertimePolicy` table. All the data in the column will be lost.
  - You are about to drop the column `fixedId` on the `Shifts` table. All the data in the column will be lost.
  - You are about to drop the column `flexibleId` on the `Shifts` table. All the data in the column will be lost.
  - You are about to drop the column `punchInTime` on the `Shifts` table. All the data in the column will be lost.
  - You are about to drop the column `punchOutTime` on the `Shifts` table. All the data in the column will be lost.
  - You are about to drop the `PanaltyOvertimeDetails` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `day` to the `FixedShift` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dateTime` to the `FlexibleShift` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "EarlyLeavePolicy" DROP CONSTRAINT "EarlyLeavePolicy_panaltyOvertimeDetailId_fkey";

-- DropForeignKey
ALTER TABLE "LateComingPolicy" DROP CONSTRAINT "LateComingPolicy_panaltyOvertimeDetailId_fkey";

-- DropForeignKey
ALTER TABLE "OvertimePolicy" DROP CONSTRAINT "OvertimePolicy_panaltyOvertimeDetailId_fkey";

-- DropForeignKey
ALTER TABLE "PanaltyOvertimeDetails" DROP CONSTRAINT "PanaltyOvertimeDetails_staffId_fkey";

-- DropForeignKey
ALTER TABLE "Shifts" DROP CONSTRAINT "Shifts_fixedId_fkey";

-- DropForeignKey
ALTER TABLE "Shifts" DROP CONSTRAINT "Shifts_flexibleId_fkey";

-- DropIndex
DROP INDEX "EarlyLeavePolicy_panaltyOvertimeDetailId_key";

-- DropIndex
DROP INDEX "LateComingPolicy_panaltyOvertimeDetailId_key";

-- DropIndex
DROP INDEX "OvertimePolicy_panaltyOvertimeDetailId_key";

-- AlterTable
ALTER TABLE "Client" DROP COLUMN "status",
ADD COLUMN     "status" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "EarlyLeavePolicy" DROP COLUMN "panaltyOvertimeDetailId",
ADD COLUMN     "staffId" TEXT;

-- AlterTable
ALTER TABLE "FixedShift" ADD COLUMN     "day" TEXT NOT NULL,
ADD COLUMN     "shiftId" TEXT;

-- AlterTable
ALTER TABLE "FlexibleShift" ADD COLUMN     "dateTime" TEXT NOT NULL,
ADD COLUMN     "shiftId" TEXT;

-- AlterTable
ALTER TABLE "LateComingPolicy" DROP COLUMN "panaltyOvertimeDetailId",
ADD COLUMN     "staffId" TEXT;

-- AlterTable
ALTER TABLE "OvertimePolicy" DROP COLUMN "panaltyOvertimeDetailId",
ADD COLUMN     "staffId" TEXT;

-- AlterTable
ALTER TABLE "Shifts" DROP COLUMN "fixedId",
DROP COLUMN "flexibleId",
DROP COLUMN "punchInTime",
DROP COLUMN "punchOutTime",
ADD COLUMN     "allowPunchInHours" INTEGER,
ADD COLUMN     "allowPunchInMinutes" INTEGER;

-- DropTable
DROP TABLE "PanaltyOvertimeDetails";

-- DropEnum
DROP TYPE "StatusType";

-- AddForeignKey
ALTER TABLE "EarlyLeavePolicy" ADD CONSTRAINT "EarlyLeavePolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LateComingPolicy" ADD CONSTRAINT "LateComingPolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OvertimePolicy" ADD CONSTRAINT "OvertimePolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FixedShift" ADD CONSTRAINT "FixedShift_shiftId_fkey" FOREIGN KEY ("shiftId") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FlexibleShift" ADD CONSTRAINT "FlexibleShift_shiftId_fkey" FOREIGN KEY ("shiftId") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
