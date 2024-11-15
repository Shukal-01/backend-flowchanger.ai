/*
  Warnings:

  - You are about to drop the column `shifts` on the `FixedShift` table. All the data in the column will be lost.
  - You are about to drop the column `shifts` on the `FlexibleShift` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "FixedShift" DROP CONSTRAINT "FixedShift_shifts_fkey";

-- DropForeignKey
ALTER TABLE "FlexibleShift" DROP CONSTRAINT "FlexibleShift_shifts_fkey";

-- AlterTable
ALTER TABLE "FixedShift" DROP COLUMN "shifts";

-- AlterTable
ALTER TABLE "FlexibleShift" DROP COLUMN "shifts";

-- CreateTable
CREATE TABLE "_shiftsId" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_shiftsId_AB_unique" ON "_shiftsId"("A", "B");

-- CreateIndex
CREATE INDEX "_shiftsId_B_index" ON "_shiftsId"("B");

-- AddForeignKey
ALTER TABLE "_shiftsId" ADD CONSTRAINT "_shiftsId_A_fkey" FOREIGN KEY ("A") REFERENCES "FlexibleShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_shiftsId" ADD CONSTRAINT "_shiftsId_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
