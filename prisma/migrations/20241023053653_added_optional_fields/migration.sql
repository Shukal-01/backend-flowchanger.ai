/*
  Warnings:

  - The `mobile` column on the `Admin` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "Admin" ALTER COLUMN "first_name" DROP NOT NULL,
ALTER COLUMN "last_name" DROP NOT NULL,
DROP COLUMN "mobile",
ADD COLUMN     "mobile" INTEGER,
ALTER COLUMN "time_zone" DROP NOT NULL,
ALTER COLUMN "time_formate" DROP NOT NULL,
ALTER COLUMN "date_formate" DROP NOT NULL,
ALTER COLUMN "week_formate" DROP NOT NULL,
ALTER COLUMN "package_id" DROP NOT NULL,
ALTER COLUMN "company_name" DROP NOT NULL;
