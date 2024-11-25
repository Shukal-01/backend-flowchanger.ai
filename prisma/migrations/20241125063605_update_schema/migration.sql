-- AlterTable
ALTER TABLE "Fine" ADD COLUMN     "earlyOutFineHoursTime" TEXT,
ADD COLUMN     "excessBreakFineHoursTime" TEXT,
ADD COLUMN     "lateEntryFineHoursTime" TEXT;

-- AlterTable
ALTER TABLE "Overtime" ADD COLUMN     "earlyCommingEntryHoursTime" TEXT,
ADD COLUMN     "lateOutOvertimeHoursTime" TEXT;
