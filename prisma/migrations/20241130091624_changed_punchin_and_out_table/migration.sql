-- AlterTable
ALTER TABLE "PunchIn" ALTER COLUMN "punchInMethod" DROP NOT NULL,
ALTER COLUMN "location" DROP NOT NULL;

-- AlterTable
ALTER TABLE "PunchOut" ALTER COLUMN "punchOutMethod" DROP NOT NULL,
ALTER COLUMN "location" DROP NOT NULL;
