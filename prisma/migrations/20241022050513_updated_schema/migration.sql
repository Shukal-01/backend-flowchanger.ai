/*
  Warnings:

  - You are about to drop the `TaskType` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `canBeChangedId` to the `TaskStatus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isHiddenId` to the `TaskStatus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `statusOrder` to the `TaskStatus` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "TaskDetail" DROP CONSTRAINT "TaskDetail_taskTypeId_fkey";

-- AlterTable
ALTER TABLE "TaskStatus" ADD COLUMN     "canBeChangedId" TEXT NOT NULL,
ADD COLUMN     "isHiddenId" TEXT NOT NULL,
ADD COLUMN     "statusColor" TEXT,
ADD COLUMN     "statusOrder" INTEGER NOT NULL;

-- DropTable
DROP TABLE "TaskType";

-- AddForeignKey
ALTER TABLE "TaskStatus" ADD CONSTRAINT "TaskStatus_isHiddenId_fkey" FOREIGN KEY ("isHiddenId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskStatus" ADD CONSTRAINT "TaskStatus_canBeChangedId_fkey" FOREIGN KEY ("canBeChangedId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;
