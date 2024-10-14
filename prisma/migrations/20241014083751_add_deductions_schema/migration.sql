/*
  Warnings:

  - You are about to drop the column `created_At` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `ctc_Amount` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `dearness_Allowance` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `effective_Date` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `employee_ESI` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `employee_LWF` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `employee_PF` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `employer_ESI` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `employer_LWF` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `employer_PF` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `professional_Tax` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `salary_Type` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `updated_At` on the `SalaryDetails` table. All the data in the column will be lost.
  - You are about to drop the column `viewTimesheets` on the `SettingsPermissions` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[role_name]` on the table `Role` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `ctc_amount` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dearness_allowance` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `effective_date` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employee_esi` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employee_lwf` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employee_pf` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employer_esi` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employer_lwf` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employer_pf` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `professional_tax` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `salary_type` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `SalaryDetails` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "SalaryDetails" DROP COLUMN "created_At",
DROP COLUMN "ctc_Amount",
DROP COLUMN "dearness_Allowance",
DROP COLUMN "effective_Date",
DROP COLUMN "employee_ESI",
DROP COLUMN "employee_LWF",
DROP COLUMN "employee_PF",
DROP COLUMN "employer_ESI",
DROP COLUMN "employer_LWF",
DROP COLUMN "employer_PF",
DROP COLUMN "professional_Tax",
DROP COLUMN "salary_Type",
DROP COLUMN "updated_At",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "ctc_amount" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "dearness_allowance" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "effective_date" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "employee_esi" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "employee_lwf" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "employee_pf" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "employer_esi" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "employer_lwf" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "employer_pf" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "professional_tax" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "salary_type" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "SettingsPermissions" DROP COLUMN "viewTimesheets",
ADD COLUMN     "view_time_sheets" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "deductions" (
    "id" TEXT NOT NULL,
    "salaryId" TEXT NOT NULL,
    "heads" TEXT[],
    "calculation" TEXT[],
    "amount" TEXT[],

    CONSTRAINT "deductions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Role_role_name_key" ON "Role"("role_name");

-- AddForeignKey
ALTER TABLE "deductions" ADD CONSTRAINT "deductions_salaryId_fkey" FOREIGN KEY ("salaryId") REFERENCES "SalaryDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
