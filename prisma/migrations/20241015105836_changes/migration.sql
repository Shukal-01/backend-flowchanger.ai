-- CreateEnum
CREATE TYPE "PunchTime" AS ENUM ('anyTime', 'addLimit');

-- CreateTable
CREATE TABLE "Shifts" (
    "id" TEXT NOT NULL,
    "shiftName" TEXT NOT NULL,
    "shiftStartTime" TEXT NOT NULL,
    "shiftEndTime" TEXT NOT NULL,
    "punchInTime" TEXT NOT NULL,
    "punchOutTime" TEXT NOT NULL,
    "punchInType" "PunchTime" NOT NULL DEFAULT 'anyTime',
    "punchOutType" "PunchTime" NOT NULL DEFAULT 'anyTime',
    "fixedId" TEXT NOT NULL,
    "flexibleId" TEXT NOT NULL,

    CONSTRAINT "Shifts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Fixed" (
    "id" TEXT NOT NULL,
    "day" TEXT NOT NULL,
    "weekOff" BOOLEAN NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "Fixed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Flexible" (
    "id" TEXT NOT NULL,
    "day" TEXT NOT NULL,
    "weekOff" BOOLEAN NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "Flexible_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Shifts" ADD CONSTRAINT "Shifts_fixedId_fkey" FOREIGN KEY ("fixedId") REFERENCES "Fixed"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shifts" ADD CONSTRAINT "Shifts_flexibleId_fkey" FOREIGN KEY ("flexibleId") REFERENCES "Flexible"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fixed" ADD CONSTRAINT "Fixed_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Flexible" ADD CONSTRAINT "Flexible_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;
