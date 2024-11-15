/*
  Warnings:

  - Made the column `staffId` on table `FixedShift` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "FixedShift" ALTER COLUMN "staffId" SET NOT NULL;
