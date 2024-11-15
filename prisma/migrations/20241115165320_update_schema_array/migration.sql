/*
  Warnings:

  - Made the column `staffId` on table `FlexibleShift` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "FlexibleShift" ALTER COLUMN "staffId" SET NOT NULL;
