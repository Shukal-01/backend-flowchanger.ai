/*
  Warnings:

  - Changed the type of `shiftStartTime` on the `Shifts` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `shiftEndTime` on the `Shifts` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "Shifts" DROP COLUMN "shiftStartTime",
ADD COLUMN     "shiftStartTime" TIMESTAMP(3) NOT NULL,
DROP COLUMN "shiftEndTime",
ADD COLUMN     "shiftEndTime" TIMESTAMP(3) NOT NULL;
