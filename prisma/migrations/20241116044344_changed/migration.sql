/*
  Warnings:

  - Changed the type of `dateTime` on the `FlexibleShift` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "FlexibleShift" DROP COLUMN "dateTime",
ADD COLUMN     "dateTime" TIMESTAMP(3) NOT NULL;
