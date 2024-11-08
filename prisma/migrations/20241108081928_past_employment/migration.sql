/*
  Warnings:

  - The primary key for the `PastEmployment` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
ALTER TABLE "PastEmployment" DROP CONSTRAINT "PastEmployment_pkey",
ALTER COLUMN "id" SET DEFAULT gen_random_uuid(),
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "joining_date" SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "leaving_date" SET DEFAULT CURRENT_TIMESTAMP,
ADD CONSTRAINT "PastEmployment_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "PastEmployment_id_seq";
