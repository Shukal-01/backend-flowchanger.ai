/*
  Warnings:

  - The values [hourly,daily] on the enum `FineType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "FineType_new" AS ENUM ('HOURLY', 'DAILY');
ALTER TABLE "EarlyLeavePolicy" ALTER COLUMN "fine_Type" TYPE "FineType_new" USING ("fine_Type"::text::"FineType_new");
ALTER TABLE "LateComingPolicy" ALTER COLUMN "fine_Type" TYPE "FineType_new" USING ("fine_Type"::text::"FineType_new");
ALTER TYPE "FineType" RENAME TO "FineType_old";
ALTER TYPE "FineType_new" RENAME TO "FineType";
DROP TYPE "FineType_old";
COMMIT;

-- AlterTable
ALTER TABLE "EarlyLeavePolicy" ALTER COLUMN "fine_Type" SET DEFAULT 'HOURLY';

-- AlterTable
ALTER TABLE "LateComingPolicy" ALTER COLUMN "fine_Type" SET DEFAULT 'HOURLY';
