-- AlterTable
ALTER TABLE "ProjectPriority" ALTER COLUMN "can_changed" DROP NOT NULL,
ALTER COLUMN "can_changed" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "ProjectStatus" ALTER COLUMN "can_changed" DROP NOT NULL,
ALTER COLUMN "can_changed" SET DATA TYPE TEXT;
