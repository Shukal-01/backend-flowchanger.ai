/*
  Warnings:

  - Added the required column `opt` to the `Admin` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Admin" ADD COLUMN     "opt" INTEGER NOT NULL,
ALTER COLUMN "package_id" SET DATA TYPE TEXT;
