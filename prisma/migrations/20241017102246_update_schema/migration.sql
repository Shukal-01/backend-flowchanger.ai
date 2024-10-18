/*
  Warnings:

  - You are about to drop the `Punch` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Punch" DROP CONSTRAINT "Punch_punchInId_fkey";

-- DropForeignKey
ALTER TABLE "Punch" DROP CONSTRAINT "Punch_punchOutId_fkey";

-- DropTable
DROP TABLE "Punch";

-- CreateTable
CREATE TABLE "PunchRecords" (
    "id" TEXT NOT NULL,
    "punchDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchInId" TEXT NOT NULL,
    "punchOutId" TEXT NOT NULL,

    CONSTRAINT "PunchRecords_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PunchRecords_punchInId_key" ON "PunchRecords"("punchInId");

-- CreateIndex
CREATE UNIQUE INDEX "PunchRecords_punchOutId_key" ON "PunchRecords"("punchOutId");

-- AddForeignKey
ALTER TABLE "PunchRecords" ADD CONSTRAINT "PunchRecords_punchInId_fkey" FOREIGN KEY ("punchInId") REFERENCES "PunchIn"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchRecords" ADD CONSTRAINT "PunchRecords_punchOutId_fkey" FOREIGN KEY ("punchOutId") REFERENCES "PunchOut"("id") ON DELETE CASCADE ON UPDATE CASCADE;
