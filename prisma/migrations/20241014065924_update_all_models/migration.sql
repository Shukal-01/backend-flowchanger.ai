-- CreateEnum
CREATE TYPE "FineType" AS ENUM ('hourly', 'daily');

-- CreateTable
CREATE TABLE "Staff" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "job_title" TEXT NOT NULL,
    "branch" TEXT NOT NULL,
    "departmentId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,
    "mobile" TEXT NOT NULL,
    "login_otp" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "official_email" TEXT NOT NULL,
    "date_of_joining" TIMESTAMP(3) NOT NULL,
    "address" TEXT NOT NULL,

    CONSTRAINT "Staff_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BankDetails" (
    "id" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,
    "bank_name" TEXT NOT NULL,
    "account_number" TEXT NOT NULL,
    "branch_name" TEXT NOT NULL,
    "ifsc_code" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BankDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PanaltyOvertimeDetails" (
    "id" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "PanaltyOvertimeDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EarlyLeavePolicy" (
    "id" TEXT NOT NULL,
    "fine_Type" "FineType" NOT NULL,
    "grace_period_mins" INTEGER NOT NULL,
    "fine_amount_mins" INTEGER NOT NULL,
    "waive_off_days" INTEGER NOT NULL,
    "panaltyOvertimeDetailId" TEXT NOT NULL,

    CONSTRAINT "EarlyLeavePolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LateComingPolicy" (
    "id" TEXT NOT NULL,
    "fine_Type" "FineType" NOT NULL,
    "grace_period_mins" INTEGER NOT NULL,
    "fine_amount_mins" INTEGER NOT NULL,
    "waive_off_days" INTEGER NOT NULL,
    "panaltyOvertimeDetailId" TEXT NOT NULL,

    CONSTRAINT "LateComingPolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OvertimePolicy" (
    "id" TEXT NOT NULL,
    "grace_period_mins" INTEGER NOT NULL,
    "extra_hours_pay" INTEGER NOT NULL,
    "public_holiday_pay" INTEGER NOT NULL,
    "week_off_pay" INTEGER NOT NULL,
    "panaltyOvertimeDetailId" TEXT NOT NULL,

    CONSTRAINT "OvertimePolicy_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "BankDetails" ADD CONSTRAINT "BankDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PanaltyOvertimeDetails" ADD CONSTRAINT "PanaltyOvertimeDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EarlyLeavePolicy" ADD CONSTRAINT "EarlyLeavePolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LateComingPolicy" ADD CONSTRAINT "LateComingPolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OvertimePolicy" ADD CONSTRAINT "OvertimePolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
