/*
  Warnings:

  - The `punchInTime` column on the `PunchIn` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `punchInDate` column on the `PunchIn` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "PunchIn" DROP COLUMN "punchInTime",
ADD COLUMN     "punchInTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
DROP COLUMN "punchInDate",
ADD COLUMN     "punchInDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;
