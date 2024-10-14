/*
  Warnings:

  - Changed the type of `fine_Type` on the `EarlyLeavePolicy` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `fine_Type` on the `LateComingPolicy` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "EarlyLeavePolicy" DROP COLUMN "fine_Type",
ADD COLUMN     "fine_Type" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "LateComingPolicy" DROP COLUMN "fine_Type",
ADD COLUMN     "fine_Type" TEXT NOT NULL;

-- DropEnum
DROP TYPE "FineType";
