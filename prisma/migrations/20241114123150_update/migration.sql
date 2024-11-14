/*
  Warnings:

  - You are about to drop the `_fixedshift` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_flexibleshift` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_fixedshift" DROP CONSTRAINT "_fixedshift_A_fkey";

-- DropForeignKey
ALTER TABLE "_fixedshift" DROP CONSTRAINT "_fixedshift_B_fkey";

-- DropForeignKey
ALTER TABLE "_flexibleshift" DROP CONSTRAINT "_flexibleshift_A_fkey";

-- DropForeignKey
ALTER TABLE "_flexibleshift" DROP CONSTRAINT "_flexibleshift_B_fkey";

-- DropTable
DROP TABLE "_fixedshift";

-- DropTable
DROP TABLE "_flexibleshift";

-- CreateTable
CREATE TABLE "_ShiftFixedShift" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ShiftFlexibleShift" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ShiftFixedShift_AB_unique" ON "_ShiftFixedShift"("A", "B");

-- CreateIndex
CREATE INDEX "_ShiftFixedShift_B_index" ON "_ShiftFixedShift"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ShiftFlexibleShift_AB_unique" ON "_ShiftFlexibleShift"("A", "B");

-- CreateIndex
CREATE INDEX "_ShiftFlexibleShift_B_index" ON "_ShiftFlexibleShift"("B");

-- AddForeignKey
ALTER TABLE "_ShiftFixedShift" ADD CONSTRAINT "_ShiftFixedShift_A_fkey" FOREIGN KEY ("A") REFERENCES "FixedShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ShiftFixedShift" ADD CONSTRAINT "_ShiftFixedShift_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ShiftFlexibleShift" ADD CONSTRAINT "_ShiftFlexibleShift_A_fkey" FOREIGN KEY ("A") REFERENCES "FlexibleShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ShiftFlexibleShift" ADD CONSTRAINT "_ShiftFlexibleShift_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
