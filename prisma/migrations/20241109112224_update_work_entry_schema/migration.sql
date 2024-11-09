/*
  Warnings:

  - You are about to drop the column `description` on the `WorkEntry` table. All the data in the column will be lost.
  - Added the required column `discription` to the `WorkEntry` table without a default value. This is not possible if the table is not empty.
  - Made the column `location` on table `WorkEntry` required. This step will fail if there are existing NULL values in that column.
  - Made the column `staffDetailsId` on table `WorkEntry` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "WorkEntry" DROP COLUMN "description",
ADD COLUMN     "discription" TEXT NOT NULL,
ALTER COLUMN "location" SET NOT NULL,
ALTER COLUMN "staffDetailsId" SET NOT NULL;
