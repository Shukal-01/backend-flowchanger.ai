/*
  Warnings:

  - You are about to drop the `FixedShiftShifts` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "FixedShiftShifts" DROP CONSTRAINT "FixedShiftShifts_fixedShiftId_fkey";

-- DropForeignKey
ALTER TABLE "FixedShiftShifts" DROP CONSTRAINT "FixedShiftShifts_shiftId_fkey";

-- DropTable
DROP TABLE "FixedShiftShifts";
