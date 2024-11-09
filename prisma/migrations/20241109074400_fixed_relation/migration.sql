/*
  Warnings:

  - You are about to drop the column `clientDetailsId` on the `User` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_adminDetailsId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_clientDetailsId_fkey";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "clientDetailsId";

-- AddForeignKey
ALTER TABLE "AdminDetails" ADD CONSTRAINT "AdminDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClientDetails" ADD CONSTRAINT "ClientDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
