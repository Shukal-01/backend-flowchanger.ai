/*
  Warnings:

  - You are about to drop the column `address` on the `Staff` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Staff" DROP COLUMN "address",
ADD COLUMN     "current_address" TEXT,
ADD COLUMN     "date_of_birth" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "date_of_joining" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "emergency_contact_address" TEXT,
ADD COLUMN     "emergency_contact_mobile" TEXT,
ADD COLUMN     "emergency_contact_name" TEXT,
ADD COLUMN     "emergency_contact_relation" TEXT,
ADD COLUMN     "permanent_address" TEXT;
