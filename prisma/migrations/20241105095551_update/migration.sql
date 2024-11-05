/*
  Warnings:

  - The `can_changed` column on the `ProjectPriority` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `can_changed` column on the `ProjectStatus` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "ProjectPriority" ALTER COLUMN "is_hidden" SET DEFAULT ARRAY[]::TEXT[],
DROP COLUMN "can_changed",
ADD COLUMN     "can_changed" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "ProjectStatus" DROP COLUMN "can_changed",
ADD COLUMN     "can_changed" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "TaskStatus" ALTER COLUMN "canBeChangedId" SET DEFAULT ARRAY[]::TEXT[];
