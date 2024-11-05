/*
  Warnings:

  - The `isHiddenId` column on the `TaskStatus` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `canBeChangedId` column on the `TaskStatus` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "TaskStatus" DROP COLUMN "isHiddenId",
ADD COLUMN     "isHiddenId" TEXT[],
DROP COLUMN "canBeChangedId",
ADD COLUMN     "canBeChangedId" TEXT[];
