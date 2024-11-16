/*
  Warnings:

  - You are about to drop the `_FixedShiftShifts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ShiftFlexibleShift` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_FixedShiftShifts" DROP CONSTRAINT "_FixedShiftShifts_A_fkey";

-- DropForeignKey
ALTER TABLE "_FixedShiftShifts" DROP CONSTRAINT "_FixedShiftShifts_B_fkey";

-- DropForeignKey
ALTER TABLE "_ShiftFlexibleShift" DROP CONSTRAINT "_ShiftFlexibleShift_A_fkey";

-- DropForeignKey
ALTER TABLE "_ShiftFlexibleShift" DROP CONSTRAINT "_ShiftFlexibleShift_B_fkey";

-- DropTable
DROP TABLE "_FixedShiftShifts";

-- DropTable
DROP TABLE "_ShiftFlexibleShift";

-- CreateTable
CREATE TABLE "_FixedShiftToShifts" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_FlexibleShiftToShifts" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_FixedShiftToShifts_AB_unique" ON "_FixedShiftToShifts"("A", "B");

-- CreateIndex
CREATE INDEX "_FixedShiftToShifts_B_index" ON "_FixedShiftToShifts"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_FlexibleShiftToShifts_AB_unique" ON "_FlexibleShiftToShifts"("A", "B");

-- CreateIndex
CREATE INDEX "_FlexibleShiftToShifts_B_index" ON "_FlexibleShiftToShifts"("B");

-- AddForeignKey
ALTER TABLE "_FixedShiftToShifts" ADD CONSTRAINT "_FixedShiftToShifts_A_fkey" FOREIGN KEY ("A") REFERENCES "FixedShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FixedShiftToShifts" ADD CONSTRAINT "_FixedShiftToShifts_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FlexibleShiftToShifts" ADD CONSTRAINT "_FlexibleShiftToShifts_A_fkey" FOREIGN KEY ("A") REFERENCES "FlexibleShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FlexibleShiftToShifts" ADD CONSTRAINT "_FlexibleShiftToShifts_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
