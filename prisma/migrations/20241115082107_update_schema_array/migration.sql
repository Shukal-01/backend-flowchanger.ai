-- CreateTable
CREATE TABLE "_FixedShiftToShifts" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_FixedShiftToShifts_AB_unique" ON "_FixedShiftToShifts"("A", "B");

-- CreateIndex
CREATE INDEX "_FixedShiftToShifts_B_index" ON "_FixedShiftToShifts"("B");

-- AddForeignKey
ALTER TABLE "_FixedShiftToShifts" ADD CONSTRAINT "_FixedShiftToShifts_A_fkey" FOREIGN KEY ("A") REFERENCES "FixedShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FixedShiftToShifts" ADD CONSTRAINT "_FixedShiftToShifts_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
