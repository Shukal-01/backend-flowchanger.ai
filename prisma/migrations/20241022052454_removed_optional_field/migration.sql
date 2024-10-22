/*
  Warnings:

  - Made the column `staffId` on table `CustomDetails` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "CustomDetails" DROP CONSTRAINT "CustomDetails_staffId_fkey";

-- AlterTable
ALTER TABLE "CustomDetails" ALTER COLUMN "staffId" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "CustomDetails" ADD CONSTRAINT "CustomDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
