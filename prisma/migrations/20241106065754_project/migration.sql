/*
  Warnings:

  - You are about to drop the column `projectId` on the `Discussion` table. All the data in the column will be lost.
  - You are about to drop the column `clientId` on the `Project` table. All the data in the column will be lost.
  - You are about to drop the column `start_Date` on the `Project` table. All the data in the column will be lost.
  - The `department` column on the `Project` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `projectId` on the `ProjectFiles` table. All the data in the column will be lost.
  - You are about to drop the column `projectId` on the `TicketInformation` table. All the data in the column will be lost.
  - Added the required column `start_date` to the `Project` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Discussion" DROP CONSTRAINT "Discussion_projectId_fkey";

-- DropForeignKey
ALTER TABLE "Project" DROP CONSTRAINT "Project_clientId_fkey";

-- DropForeignKey
ALTER TABLE "ProjectFiles" DROP CONSTRAINT "ProjectFiles_projectId_fkey";

-- DropForeignKey
ALTER TABLE "TicketInformation" DROP CONSTRAINT "TicketInformation_projectId_fkey";

-- AlterTable
ALTER TABLE "Discussion" DROP COLUMN "projectId";

-- AlterTable
ALTER TABLE "Project" DROP COLUMN "clientId",
DROP COLUMN "start_Date",
ADD COLUMN     "send_mail" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "start_date" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "total_rate" DROP DEFAULT,
ALTER COLUMN "estimated_hours" DROP DEFAULT,
DROP COLUMN "department",
ADD COLUMN     "department" TEXT[];

-- AlterTable
ALTER TABLE "ProjectFiles" DROP COLUMN "projectId";

-- AlterTable
ALTER TABLE "TicketInformation" DROP COLUMN "projectId";
