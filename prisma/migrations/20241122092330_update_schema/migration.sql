/*
  Warnings:

  - A unique constraint covering the columns `[punchRecordId]` on the table `EndBreak` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[punchRecordId]` on the table `StartBreak` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "EndBreak" ADD COLUMN     "punchRecordId" TEXT;

-- AlterTable
ALTER TABLE "StartBreak" ADD COLUMN     "punchRecordId" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "EndBreak_punchRecordId_key" ON "EndBreak"("punchRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "StartBreak_punchRecordId_key" ON "StartBreak"("punchRecordId");

-- AddForeignKey
ALTER TABLE "StartBreak" ADD CONSTRAINT "StartBreak_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES "PunchRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EndBreak" ADD CONSTRAINT "EndBreak_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES "PunchRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;
