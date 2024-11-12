/*
  Warnings:

  - You are about to drop the column `blood_group` on the `StaffDetails` table. All the data in the column will be lost.
  - You are about to drop the column `marital_status` on the `StaffDetails` table. All the data in the column will be lost.
  - You are about to drop the column `clientDetailsId` on the `User` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_clientDetailsId_fkey";

-- AlterTable
ALTER TABLE "StaffDetails" DROP COLUMN "blood_group",
DROP COLUMN "marital_status",
ADD COLUMN     "guardian_name" TEXT;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "clientDetailsId";

-- AddForeignKey
ALTER TABLE "AdminDetails" ADD CONSTRAINT "AdminDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClientDetails" ADD CONSTRAINT "ClientDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
