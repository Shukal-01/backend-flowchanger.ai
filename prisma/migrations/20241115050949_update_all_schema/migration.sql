-- AlterTable
ALTER TABLE "Fine" ADD COLUMN     "staffId" TEXT;

-- CreateTable
CREATE TABLE "FixedShiftShifts" (
    "fixedShiftId" TEXT NOT NULL,
    "shiftId" TEXT NOT NULL,

    CONSTRAINT "FixedShiftShifts_pkey" PRIMARY KEY ("fixedShiftId","shiftId")
);

-- CreateTable
CREATE TABLE "Overtime" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "earlyCommingEntryAmount" DOUBLE PRECISION DEFAULT 1,
    "earlyEntryAmount" DOUBLE PRECISION DEFAULT 0,
    "lateOutOvertimeAmount" DOUBLE PRECISION DEFAULT 1,
    "lateOutAmount" DOUBLE PRECISION DEFAULT 0,
    "totalAmount" DOUBLE PRECISION DEFAULT 0,
    "shiftIds" TEXT,
    "punchRecordId" TEXT,
    "staffId" TEXT,

    CONSTRAINT "Overtime_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "FixedShiftShifts" ADD CONSTRAINT "FixedShiftShifts_fixedShiftId_fkey" FOREIGN KEY ("fixedShiftId") REFERENCES "FixedShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FixedShiftShifts" ADD CONSTRAINT "FixedShiftShifts_shiftId_fkey" FOREIGN KEY ("shiftId") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fine" ADD CONSTRAINT "Fine_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Overtime" ADD CONSTRAINT "Overtime_shiftIds_fkey" FOREIGN KEY ("shiftIds") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Overtime" ADD CONSTRAINT "Overtime_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES "PunchRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Overtime" ADD CONSTRAINT "Overtime_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;
