/*
  Warnings:

  - You are about to drop the column `date` on the `FixedShift` table. All the data in the column will be lost.
  - You are about to drop the column `date` on the `FlexibleShift` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "FixedShift" DROP COLUMN "date",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "FlexibleShift" DROP COLUMN "date",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "staffId" DROP NOT NULL;
