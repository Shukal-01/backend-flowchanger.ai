/*
  Warnings:

  - You are about to drop the column `customer` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `department` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `selectDepartmentId` on the `TaskDetail` table. All the data in the column will be lost.
  - You are about to drop the column `selectProjectId` on the `TaskDetail` table. All the data in the column will be lost.
  - You are about to drop the column `taskAssign` on the `TaskDetail` table. All the data in the column will be lost.
  - You are about to drop the column `isHiddenId` on the `TaskStatus` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Project" DROP COLUMN "customer",
DROP COLUMN "department",
ADD COLUMN     "customerId" TEXT;

-- AlterTable
ALTER TABLE "TaskDetail" DROP COLUMN "selectDepartmentId",
DROP COLUMN "selectProjectId",
DROP COLUMN "taskAssign";

-- AlterTable
ALTER TABLE "TaskStatus" DROP COLUMN "isHiddenId";

-- CreateTable
CREATE TABLE "_staffId" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_departmentId" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ProjectStaff" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_projectId" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_staffId_AB_unique" ON "_staffId"("A", "B");

-- CreateIndex
CREATE INDEX "_staffId_B_index" ON "_staffId"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_departmentId_AB_unique" ON "_departmentId"("A", "B");

-- CreateIndex
CREATE INDEX "_departmentId_B_index" ON "_departmentId"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ProjectStaff_AB_unique" ON "_ProjectStaff"("A", "B");

-- CreateIndex
CREATE INDEX "_ProjectStaff_B_index" ON "_ProjectStaff"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_projectId_AB_unique" ON "_projectId"("A", "B");

-- CreateIndex
CREATE INDEX "_projectId_B_index" ON "_projectId"("B");

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "ClientDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_staffId" ADD CONSTRAINT "_staffId_A_fkey" FOREIGN KEY ("A") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_staffId" ADD CONSTRAINT "_staffId_B_fkey" FOREIGN KEY ("B") REFERENCES "TaskStatus"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_departmentId" ADD CONSTRAINT "_departmentId_A_fkey" FOREIGN KEY ("A") REFERENCES "Department"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_departmentId" ADD CONSTRAINT "_departmentId_B_fkey" FOREIGN KEY ("B") REFERENCES "TaskDetail"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProjectStaff" ADD CONSTRAINT "_ProjectStaff_A_fkey" FOREIGN KEY ("A") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProjectStaff" ADD CONSTRAINT "_ProjectStaff_B_fkey" FOREIGN KEY ("B") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_projectId" ADD CONSTRAINT "_projectId_A_fkey" FOREIGN KEY ("A") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_projectId" ADD CONSTRAINT "_projectId_B_fkey" FOREIGN KEY ("B") REFERENCES "TaskDetail"("id") ON DELETE CASCADE ON UPDATE CASCADE;
