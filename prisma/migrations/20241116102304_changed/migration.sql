/*
  Warnings:

  - Made the column `punchRecordId` on table `Fine` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Fine" ALTER COLUMN "punchRecordId" SET NOT NULL;
