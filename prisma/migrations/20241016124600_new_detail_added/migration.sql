/*
  Warnings:

  - The values [anyTime,addLimit] on the enum `PunchTime` will be removed. If these variants are still used in the database, this will fail.

*/
-- CreateEnum
CREATE TYPE "PunchInMethod" AS ENUM ('BIOMETRIC', 'QRSCAN', 'PHOTOCLICK');

-- AlterEnum
BEGIN;
CREATE TYPE "PunchTime_new" AS ENUM ('ANYTIME', 'ADDLIMIT');
ALTER TABLE "Shifts" ALTER COLUMN "punchInType" DROP DEFAULT;
ALTER TABLE "Shifts" ALTER COLUMN "punchOutType" DROP DEFAULT;
ALTER TABLE "Shifts" ALTER COLUMN "punchInType" TYPE "PunchTime_new" USING ("punchInType"::text::"PunchTime_new");
ALTER TABLE "Shifts" ALTER COLUMN "punchOutType" TYPE "PunchTime_new" USING ("punchOutType"::text::"PunchTime_new");
ALTER TYPE "PunchTime" RENAME TO "PunchTime_old";
ALTER TYPE "PunchTime_new" RENAME TO "PunchTime";
DROP TYPE "PunchTime_old";
ALTER TABLE "Shifts" ALTER COLUMN "punchInType" SET DEFAULT 'ANYTIME';
ALTER TABLE "Shifts" ALTER COLUMN "punchOutType" SET DEFAULT 'ANYTIME';
COMMIT;

-- AlterTable
ALTER TABLE "FixedShift" ALTER COLUMN "staffId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Shifts" ALTER COLUMN "punchInType" SET DEFAULT 'ANYTIME',
ALTER COLUMN "punchOutType" SET DEFAULT 'ANYTIME';

-- CreateTable
CREATE TABLE "Punch" (
    "id" TEXT NOT NULL,
    "punchDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchInId" TEXT NOT NULL,
    "punchOutId" TEXT NOT NULL,

    CONSTRAINT "Punch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PunchIn" (
    "id" TEXT NOT NULL,
    "punchInMethod" "PunchInMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "punchInTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchInDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "PunchIn_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PunchOut" (
    "id" TEXT NOT NULL,
    "method" "PunchInMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "punchOutTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchOutDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "PunchOut_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Punch_punchInId_key" ON "Punch"("punchInId");

-- CreateIndex
CREATE UNIQUE INDEX "Punch_punchOutId_key" ON "Punch"("punchOutId");

-- AddForeignKey
ALTER TABLE "Punch" ADD CONSTRAINT "Punch_punchInId_fkey" FOREIGN KEY ("punchInId") REFERENCES "PunchIn"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Punch" ADD CONSTRAINT "Punch_punchOutId_fkey" FOREIGN KEY ("punchOutId") REFERENCES "PunchOut"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchIn" ADD CONSTRAINT "PunchIn_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchOut" ADD CONSTRAINT "PunchOut_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;
