/*
  Warnings:

  - You are about to drop the `_shiftId` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_shiftId" DROP CONSTRAINT "_shiftId_A_fkey";

-- DropForeignKey
ALTER TABLE "_shiftId" DROP CONSTRAINT "_shiftId_B_fkey";

-- DropTable
DROP TABLE "_shiftId";

-- CreateTable
CREATE TABLE "_shiftIds" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_shiftsId" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_shiftIds_AB_unique" ON "_shiftIds"("A", "B");

-- CreateIndex
CREATE INDEX "_shiftIds_B_index" ON "_shiftIds"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_shiftsId_AB_unique" ON "_shiftsId"("A", "B");

-- CreateIndex
CREATE INDEX "_shiftsId_B_index" ON "_shiftsId"("B");

-- AddForeignKey
ALTER TABLE "_shiftIds" ADD CONSTRAINT "_shiftIds_A_fkey" FOREIGN KEY ("A") REFERENCES "FixedShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_shiftIds" ADD CONSTRAINT "_shiftIds_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_shiftsId" ADD CONSTRAINT "_shiftsId_A_fkey" FOREIGN KEY ("A") REFERENCES "FlexibleShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_shiftsId" ADD CONSTRAINT "_shiftsId_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
