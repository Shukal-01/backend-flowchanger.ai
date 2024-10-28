/*
  Warnings:

  - You are about to drop the column `staffId` on the `PunchIn` table. All the data in the column will be lost.
  - You are about to drop the column `staffId` on the `PunchOut` table. All the data in the column will be lost.
  - You are about to drop the column `taskTypeId` on the `TaskDetail` table. All the data in the column will be lost.
  - Added the required column `location` to the `PunchIn` table without a default value. This is not possible if the table is not empty.
  - Added the required column `location` to the `PunchOut` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "BreakMethod" AS ENUM ('BIOMETRIC', 'QRSCAN', 'PHOTOCLICK');

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
ALTER TABLE "TaskDetail" DROP COLUMN "taskTypeId";

-- CreateTable
CREATE TABLE "StartBreak" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "breakMethod" "BreakMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "startBreakTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "location" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "StartBreak_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EndBreak" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "breakMethod" "BreakMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "endBreakTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "location" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "EndBreak_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "StartBreak" ADD CONSTRAINT "StartBreak_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EndBreak" ADD CONSTRAINT "EndBreak_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;
