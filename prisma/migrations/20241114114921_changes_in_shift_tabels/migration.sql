/*
  Warnings:

  - You are about to drop the column `shiftId` on the `FixedShift` table. All the data in the column will be lost.
  - The `day` column on the `FixedShift` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `shiftId` on the `FlexibleShift` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[weekId]` on the table `FixedShift` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "Day" AS ENUM ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');

-- DropForeignKey
ALTER TABLE "FixedShift" DROP CONSTRAINT "FixedShift_shiftId_fkey";

-- DropForeignKey
ALTER TABLE "FlexibleShift" DROP CONSTRAINT "FlexibleShift_shiftId_fkey";

-- AlterTable
ALTER TABLE "FixedShift" DROP COLUMN "shiftId",
ADD COLUMN     "weekId" TEXT,
DROP COLUMN "day",
ADD COLUMN     "day" "Day" NOT NULL DEFAULT 'Mon';

-- AlterTable
ALTER TABLE "FlexibleShift" DROP COLUMN "shiftId";

-- CreateTable
CREATE TABLE "WeekOffShift" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "weekOne" BOOLEAN DEFAULT false,
    "weekTwo" BOOLEAN DEFAULT false,
    "weekThree" BOOLEAN DEFAULT false,
    "weekFour" BOOLEAN DEFAULT false,
    "weekFive" BOOLEAN DEFAULT false,

    CONSTRAINT "WeekOffShift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_shiftId" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_shiftId_AB_unique" ON "_shiftId"("A", "B");

-- CreateIndex
CREATE INDEX "_shiftId_B_index" ON "_shiftId"("B");

-- CreateIndex
CREATE UNIQUE INDEX "FixedShift_weekId_key" ON "FixedShift"("weekId");

-- AddForeignKey
ALTER TABLE "FixedShift" ADD CONSTRAINT "FixedShift_weekId_fkey" FOREIGN KEY ("weekId") REFERENCES "WeekOffShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_shiftId" ADD CONSTRAINT "_shiftId_A_fkey" FOREIGN KEY ("A") REFERENCES "FlexibleShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_shiftId" ADD CONSTRAINT "_shiftId_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
