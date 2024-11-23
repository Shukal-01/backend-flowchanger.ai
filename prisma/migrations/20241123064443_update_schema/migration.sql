-- DropForeignKey
ALTER TABLE "EndBreak" DROP CONSTRAINT "EndBreak_punchRecordId_fkey";

-- DropForeignKey
ALTER TABLE "StartBreak" DROP CONSTRAINT "StartBreak_punchRecordId_fkey";

-- AlterTable
ALTER TABLE "EndBreak" ADD COLUMN     "punchRecordsId" TEXT;

-- AlterTable
ALTER TABLE "StartBreak" ADD COLUMN     "punchRecordsId" TEXT;

-- CreateTable
CREATE TABLE "breakRecord" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "breakDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "startBreakId" TEXT,
    "endBreakId" TEXT,
    "punchRecordId" TEXT,
    "staffId" TEXT,

    CONSTRAINT "breakRecord_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "breakRecord" ADD CONSTRAINT "breakRecord_startBreakId_fkey" FOREIGN KEY ("startBreakId") REFERENCES "StartBreak"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "breakRecord" ADD CONSTRAINT "breakRecord_endBreakId_fkey" FOREIGN KEY ("endBreakId") REFERENCES "EndBreak"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "breakRecord" ADD CONSTRAINT "breakRecord_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES "PunchRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "breakRecord" ADD CONSTRAINT "breakRecord_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StartBreak" ADD CONSTRAINT "StartBreak_punchRecordsId_fkey" FOREIGN KEY ("punchRecordsId") REFERENCES "PunchRecords"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EndBreak" ADD CONSTRAINT "EndBreak_punchRecordsId_fkey" FOREIGN KEY ("punchRecordsId") REFERENCES "PunchRecords"("id") ON DELETE SET NULL ON UPDATE CASCADE;
