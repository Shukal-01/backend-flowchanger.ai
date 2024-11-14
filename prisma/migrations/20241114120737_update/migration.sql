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
CREATE TABLE "_fixedshift" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_flexibleshift" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_fixedshift_AB_unique" ON "_fixedshift"("A", "B");

-- CreateIndex
CREATE INDEX "_fixedshift_B_index" ON "_fixedshift"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_flexibleshift_AB_unique" ON "_flexibleshift"("A", "B");

-- CreateIndex
CREATE INDEX "_flexibleshift_B_index" ON "_flexibleshift"("B");

-- AddForeignKey
ALTER TABLE "_fixedshift" ADD CONSTRAINT "_fixedshift_A_fkey" FOREIGN KEY ("A") REFERENCES "FixedShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_fixedshift" ADD CONSTRAINT "_fixedshift_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_flexibleshift" ADD CONSTRAINT "_flexibleshift_A_fkey" FOREIGN KEY ("A") REFERENCES "FlexibleShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_flexibleshift" ADD CONSTRAINT "_flexibleshift_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
