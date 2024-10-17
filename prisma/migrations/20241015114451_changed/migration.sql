/*
  Warnings:

  - You are about to drop the `Fixed` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Flexible` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Fixed" DROP CONSTRAINT "Fixed_staffId_fkey";

-- DropForeignKey
ALTER TABLE "Flexible" DROP CONSTRAINT "Flexible_staffId_fkey";

-- DropForeignKey
ALTER TABLE "Shifts" DROP CONSTRAINT "Shifts_fixedId_fkey";

-- DropForeignKey
ALTER TABLE "Shifts" DROP CONSTRAINT "Shifts_flexibleId_fkey";

-- DropTable
DROP TABLE "Fixed";

-- DropTable
DROP TABLE "Flexible";

-- CreateTable
CREATE TABLE "FixedShift" (
    "id" TEXT NOT NULL,
    "day" TEXT NOT NULL,
    "weekOff" BOOLEAN NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "FixedShift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FlexibleShift" (
    "id" TEXT NOT NULL,
    "day" TEXT NOT NULL,
    "weekOff" BOOLEAN NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "FlexibleShift_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Shifts" ADD CONSTRAINT "Shifts_fixedId_fkey" FOREIGN KEY ("fixedId") REFERENCES "FixedShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shifts" ADD CONSTRAINT "Shifts_flexibleId_fkey" FOREIGN KEY ("flexibleId") REFERENCES "FlexibleShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FixedShift" ADD CONSTRAINT "FixedShift_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FlexibleShift" ADD CONSTRAINT "FlexibleShift_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;
