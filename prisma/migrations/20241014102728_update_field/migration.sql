/*
  Warnings:

  - You are about to drop the column `fine_Type` on the `EarlyLeavePolicy` table. All the data in the column will be lost.
  - You are about to drop the column `fine_amount_mins` on the `EarlyLeavePolicy` table. All the data in the column will be lost.
  - You are about to drop the column `grace_period_mins` on the `EarlyLeavePolicy` table. All the data in the column will be lost.
  - You are about to drop the column `waive_off_days` on the `EarlyLeavePolicy` table. All the data in the column will be lost.
  - You are about to drop the column `fine_Type` on the `LateComingPolicy` table. All the data in the column will be lost.
  - You are about to drop the column `fine_amount_mins` on the `LateComingPolicy` table. All the data in the column will be lost.
  - You are about to drop the column `grace_period_mins` on the `LateComingPolicy` table. All the data in the column will be lost.
  - You are about to drop the column `waive_off_days` on the `LateComingPolicy` table. All the data in the column will be lost.
  - You are about to drop the column `extra_hours_pay` on the `OvertimePolicy` table. All the data in the column will be lost.
  - You are about to drop the column `grace_period_mins` on the `OvertimePolicy` table. All the data in the column will be lost.
  - You are about to drop the column `public_holiday_pay` on the `OvertimePolicy` table. All the data in the column will be lost.
  - You are about to drop the column `week_off_pay` on the `OvertimePolicy` table. All the data in the column will be lost.
  - Added the required column `fineAmountMins` to the `EarlyLeavePolicy` table without a default value. This is not possible if the table is not empty.
  - Added the required column `gracePeriodMins` to the `EarlyLeavePolicy` table without a default value. This is not possible if the table is not empty.
  - Added the required column `waiveOffDays` to the `EarlyLeavePolicy` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fineAmountMins` to the `LateComingPolicy` table without a default value. This is not possible if the table is not empty.
  - Added the required column `gracePeriodMins` to the `LateComingPolicy` table without a default value. This is not possible if the table is not empty.
  - Added the required column `waiveOffDays` to the `LateComingPolicy` table without a default value. This is not possible if the table is not empty.
  - Added the required column `extraHoursPay` to the `OvertimePolicy` table without a default value. This is not possible if the table is not empty.
  - Added the required column `gracePeriodMins` to the `OvertimePolicy` table without a default value. This is not possible if the table is not empty.
  - Added the required column `publicHolidayPay` to the `OvertimePolicy` table without a default value. This is not possible if the table is not empty.
  - Added the required column `weekOffPay` to the `OvertimePolicy` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "FineType" AS ENUM ('HOURLY', 'DAILY');

-- AlterTable
ALTER TABLE "EarlyLeavePolicy" DROP COLUMN "fine_Type",
DROP COLUMN "fine_amount_mins",
DROP COLUMN "grace_period_mins",
DROP COLUMN "waive_off_days",
ADD COLUMN     "fineAmountMins" INTEGER NOT NULL,
ADD COLUMN     "fineType" "FineType" NOT NULL DEFAULT 'HOURLY',
ADD COLUMN     "gracePeriodMins" INTEGER NOT NULL,
ADD COLUMN     "waiveOffDays" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "LateComingPolicy" DROP COLUMN "fine_Type",
DROP COLUMN "fine_amount_mins",
DROP COLUMN "grace_period_mins",
DROP COLUMN "waive_off_days",
ADD COLUMN     "fineAmountMins" INTEGER NOT NULL,
ADD COLUMN     "fineType" "FineType" NOT NULL DEFAULT 'HOURLY',
ADD COLUMN     "gracePeriodMins" INTEGER NOT NULL,
ADD COLUMN     "waiveOffDays" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "OvertimePolicy" DROP COLUMN "extra_hours_pay",
DROP COLUMN "grace_period_mins",
DROP COLUMN "public_holiday_pay",
DROP COLUMN "week_off_pay",
ADD COLUMN     "extraHoursPay" INTEGER NOT NULL,
ADD COLUMN     "gracePeriodMins" INTEGER NOT NULL,
ADD COLUMN     "publicHolidayPay" INTEGER NOT NULL,
ADD COLUMN     "weekOffPay" INTEGER NOT NULL;
