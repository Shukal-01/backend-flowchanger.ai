/*
  Warnings:

  - The `lateEntryFineAmount` column on the `Fine` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `lateEntryAmount` column on the `Fine` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `excessBreakFineAmount` column on the `Fine` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `excessBreakAmount` column on the `Fine` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `earlyOutFineAmount` column on the `Fine` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `earlyOutAmount` column on the `Fine` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `totalAmount` column on the `Fine` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "Fine" DROP COLUMN "lateEntryFineAmount",
ADD COLUMN     "lateEntryFineAmount" DOUBLE PRECISION DEFAULT 1,
DROP COLUMN "lateEntryAmount",
ADD COLUMN     "lateEntryAmount" DOUBLE PRECISION DEFAULT 0,
DROP COLUMN "excessBreakFineAmount",
ADD COLUMN     "excessBreakFineAmount" DOUBLE PRECISION DEFAULT 1,
DROP COLUMN "excessBreakAmount",
ADD COLUMN     "excessBreakAmount" DOUBLE PRECISION DEFAULT 0,
DROP COLUMN "earlyOutFineAmount",
ADD COLUMN     "earlyOutFineAmount" DOUBLE PRECISION DEFAULT 1,
DROP COLUMN "earlyOutAmount",
ADD COLUMN     "earlyOutAmount" DOUBLE PRECISION DEFAULT 0,
DROP COLUMN "totalAmount",
ADD COLUMN     "totalAmount" DOUBLE PRECISION DEFAULT 0;
