-- DropForeignKey
ALTER TABLE "BankDetails" DROP CONSTRAINT "BankDetails_staffId_fkey";

-- DropForeignKey
ALTER TABLE "EarlyLeavePolicy" DROP CONSTRAINT "EarlyLeavePolicy_panaltyOvertimeDetailId_fkey";

-- DropForeignKey
ALTER TABLE "LateComingPolicy" DROP CONSTRAINT "LateComingPolicy_panaltyOvertimeDetailId_fkey";

-- DropForeignKey
ALTER TABLE "OvertimePolicy" DROP CONSTRAINT "OvertimePolicy_panaltyOvertimeDetailId_fkey";

-- DropForeignKey
ALTER TABLE "PanaltyOvertimeDetails" DROP CONSTRAINT "PanaltyOvertimeDetails_staffId_fkey";

-- AddForeignKey
ALTER TABLE "BankDetails" ADD CONSTRAINT "BankDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PanaltyOvertimeDetails" ADD CONSTRAINT "PanaltyOvertimeDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EarlyLeavePolicy" ADD CONSTRAINT "EarlyLeavePolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LateComingPolicy" ADD CONSTRAINT "LateComingPolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OvertimePolicy" ADD CONSTRAINT "OvertimePolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;
