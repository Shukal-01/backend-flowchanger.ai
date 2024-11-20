/*
  Warnings:

  - Made the column `staffId` on table `PunchRecords` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "PunchRecords" ALTER COLUMN "staffId" SET NOT NULL;
