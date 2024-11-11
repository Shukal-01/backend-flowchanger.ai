-- CreateEnum
CREATE TYPE "punchRecordStatus" AS ENUM ('ABSENT', 'PRESENT', 'HALFDAY', 'PAIDLEAVE');

-- AlterTable
ALTER TABLE "PunchIn" ADD COLUMN     "approve" TEXT DEFAULT 'Pending';

-- AlterTable
ALTER TABLE "PunchRecords" ADD COLUMN     "status" "punchRecordStatus" NOT NULL DEFAULT 'ABSENT';

-- AlterTable
ALTER TABLE "StaffDetails" ADD COLUMN     "guardian_name" TEXT;

-- CreateTable
CREATE TABLE "Fine" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "lateEntryFineAmount" TEXT DEFAULT '1',
    "lateEntryAmount" TEXT DEFAULT '0',
    "excessBreakFineAmount" TEXT DEFAULT '1',
    "excessBreakAmount" TEXT DEFAULT '0',
    "earlyOutFineAmount" TEXT DEFAULT '1',
    "earlyOutAmount" TEXT DEFAULT '0',
    "totalAmount" TEXT DEFAULT '0',
    "shiftId" TEXT,
    "punchRecordId" TEXT,

    CONSTRAINT "Fine_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Fine" ADD CONSTRAINT "Fine_shiftId_fkey" FOREIGN KEY ("shiftId") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fine" ADD CONSTRAINT "Fine_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES "PunchRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;
