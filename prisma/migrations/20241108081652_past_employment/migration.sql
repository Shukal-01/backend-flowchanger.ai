/*
  Warnings:

  - You are about to drop the column `companyGST` on the `PastEmployment` table. All the data in the column will be lost.
  - You are about to drop the column `companyName` on the `PastEmployment` table. All the data in the column will be lost.
  - You are about to drop the column `joiningDate` on the `PastEmployment` table. All the data in the column will be lost.
  - You are about to drop the column `leavingDate` on the `PastEmployment` table. All the data in the column will be lost.
  - Added the required column `company_name` to the `PastEmployment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `joining_date` to the `PastEmployment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `leaving_date` to the `PastEmployment` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "PastEmployment" DROP COLUMN "companyGST",
DROP COLUMN "companyName",
DROP COLUMN "joiningDate",
DROP COLUMN "leavingDate",
ADD COLUMN     "company_gst" TEXT,
ADD COLUMN     "company_name" TEXT NOT NULL,
ADD COLUMN     "joining_date" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "leaving_date" TIMESTAMP(3) NOT NULL;
