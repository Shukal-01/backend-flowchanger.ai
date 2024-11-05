/*
  Warnings:

  - You are about to drop the column `salaryId` on the `Deductions` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `Deductions` table. All the data in the column will be lost.
  - The `amount` column on the `Deductions` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- DropForeignKey
ALTER TABLE "Deductions" DROP CONSTRAINT "Deductions_salaryId_fkey";

-- AlterTable
ALTER TABLE "Deductions" DROP COLUMN "salaryId",
DROP COLUMN "updated_at",
ADD COLUMN     "deduction_month" TEXT,
ADD COLUMN     "salaryDetailsId" TEXT,
ADD COLUMN     "staffId" TEXT,
ALTER COLUMN "heads" DROP NOT NULL,
ALTER COLUMN "heads" SET DATA TYPE TEXT,
ALTER COLUMN "calculation" DROP NOT NULL,
ALTER COLUMN "calculation" SET DATA TYPE TEXT,
DROP COLUMN "amount",
ADD COLUMN     "amount" DOUBLE PRECISION;

-- CreateTable
CREATE TABLE "ProjectStatus" (
    "id" TEXT NOT NULL,
    "project_name" TEXT NOT NULL,
    "project_color" TEXT NOT NULL,
    "project_order" TEXT NOT NULL,
    "default_filter" BOOLEAN NOT NULL DEFAULT false,
    "can_changed" TEXT[],

    CONSTRAINT "ProjectStatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectPriority" (
    "id" TEXT NOT NULL,
    "Priority_name" TEXT NOT NULL,
    "Priority_color" TEXT NOT NULL,
    "Priority_order" TEXT NOT NULL,
    "default_filter" BOOLEAN NOT NULL DEFAULT false,
    "is_hidden" TEXT[],
    "can_changed" TEXT[],

    CONSTRAINT "ProjectPriority_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Earnings" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "heads" TEXT,
    "calculation" TEXT,
    "amount" DOUBLE PRECISION,
    "salaryId" TEXT,
    "staffId" TEXT,
    "salary_month" TEXT,

    CONSTRAINT "Earnings_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Deductions" ADD CONSTRAINT "Deductions_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Earnings" ADD CONSTRAINT "Earnings_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;
