-- AlterTable
ALTER TABLE "LeaveBalance" ALTER COLUMN "balance" SET DEFAULT 0,
ALTER COLUMN "used" SET DEFAULT 0;

-- AlterTable
ALTER TABLE "LeavePolicy" ALTER COLUMN "allowed_leaves" SET DEFAULT 0,
ALTER COLUMN "carry_forward_leaves" SET DEFAULT 0;

-- AlterTable
ALTER TABLE "LeaveRequest" ALTER COLUMN "request_date" SET DEFAULT CURRENT_TIMESTAMP;
