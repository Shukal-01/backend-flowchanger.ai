/*
  Warnings:

  - The `amount` column on the `Deductions` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "Deductions" DROP COLUMN "amount",
ADD COLUMN     "amount" DOUBLE PRECISION[];
