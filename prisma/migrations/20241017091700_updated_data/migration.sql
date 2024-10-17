/*
  Warnings:

  - You are about to drop the column `method` on the `PunchOut` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "PunchOutMethod" AS ENUM ('BIOMETRIC', 'QRSCAN', 'PHOTOCLICK');

-- AlterTable
ALTER TABLE "PunchOut" DROP COLUMN "method",
ADD COLUMN     "punchOutMethod" "PunchOutMethod" NOT NULL DEFAULT 'PHOTOCLICK';
