/*
  Warnings:

  - A unique constraint covering the columns `[staffId,punchDate]` on the table `PunchRecords` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "PunchRecords_staffId_punchDate_key" ON "PunchRecords"("staffId", "punchDate");
