/*
  Warnings:

  - A unique constraint covering the columns `[staffId,dateTime]` on the table `FlexibleShift` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "FlexibleShift_staffId_dateTime_key" ON "FlexibleShift"("staffId", "dateTime");
