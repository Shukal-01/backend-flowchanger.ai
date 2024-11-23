/*
  Warnings:

  - A unique constraint covering the columns `[punchRecordId]` on the table `breakRecord` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "breakRecord_punchRecordId_key" ON "breakRecord"("punchRecordId");
