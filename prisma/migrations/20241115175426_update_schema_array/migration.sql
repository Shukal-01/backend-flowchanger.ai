/*
  Warnings:

  - A unique constraint covering the columns `[staffId]` on the table `FixedShift` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "FixedShift_staffId_key" ON "FixedShift"("staffId");
