/*
  Warnings:

  - You are about to drop the column `staffId` on the `PunchIn` table. All the data in the column will be lost.
  - You are about to drop the column `staffId` on the `PunchOut` table. All the data in the column will be lost.
  - You are about to drop the column `basic` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `dearness_allowance` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `hra` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `taskTypeId` on the `TaskDetail` table. All the data in the column will be lost.
  - Added the required column `location` to the `PunchIn` table without a default value. This is not possible if the table is not empty.
  - Added the required column `location` to the `PunchOut` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "PunchIn" DROP CONSTRAINT "PunchIn_staffId_fkey";

-- DropForeignKey
ALTER TABLE "PunchOut" DROP CONSTRAINT "PunchOut_staffId_fkey";

-- AlterTable
ALTER TABLE "PunchIn" DROP COLUMN "staffId",
ADD COLUMN     "location" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "PunchOut" DROP COLUMN "staffId",
ADD COLUMN     "location" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "SalaryDetails" DROP COLUMN "basic",
DROP COLUMN "dearness_allowance",
DROP COLUMN "hra",
ADD COLUMN     "earnings_amount" TEXT[],
ADD COLUMN     "earnings_calculation" TEXT[],
ADD COLUMN     "earnings_heads" TEXT[],
ALTER COLUMN "id" DROP DEFAULT;

-- AlterTable
ALTER TABLE "TaskDetail" DROP COLUMN "taskTypeId";

-- CreateTable
CREATE TABLE "WorkEntry" (
    "id" TEXT NOT NULL,
    "work_name" TEXT NOT NULL,
    "units" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "attachments" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "staffDetailsId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WorkEntry_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "WorkEntry" ADD CONSTRAINT "WorkEntry_staffDetailsId_fkey" FOREIGN KEY ("staffDetailsId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;
