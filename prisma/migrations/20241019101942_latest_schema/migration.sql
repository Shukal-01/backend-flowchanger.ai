-- CreateEnum
CREATE TYPE "MarkAttendenceType" AS ENUM ('Office', 'Anywhere');

-- DropForeignKey
ALTER TABLE "Verification" DROP CONSTRAINT "Verification_staffId_fkey";

-- CreateTable
CREATE TABLE "AttendanceAutomationRule" (
    "id" TEXT NOT NULL,
    "auto_absent" BOOLEAN NOT NULL DEFAULT false,
    "present_on_punch" BOOLEAN NOT NULL DEFAULT false,
    "auto_half_day" TEXT,
    "manadatory_half_day" TEXT,
    "manadatory_full_day" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "AttendanceAutomationRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AttendanceMode" (
    "id" TEXT NOT NULL,
    "selfie_attendance" BOOLEAN NOT NULL DEFAULT false,
    "qr_attendance" BOOLEAN NOT NULL DEFAULT false,
    "gps_attendance" BOOLEAN NOT NULL DEFAULT false,
    "mark_attendance" "MarkAttendenceType" NOT NULL DEFAULT 'Office',
    "allow_punch_in_for_mobile" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "AttendanceMode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StaffBackgroundVerification" (
    "id" TEXT NOT NULL,
    "aadhaar_number" TEXT,
    "aadhaar_verification_status" TEXT DEFAULT 'Not Verified',
    "aadhaar_file" TEXT,
    "pan_number" TEXT,
    "pan_verification_status" TEXT DEFAULT 'Not Verified',
    "pan_file" TEXT,
    "uan_number" TEXT,
    "uan_verification_status" TEXT DEFAULT 'Not Verified',
    "uan_file" TEXT,
    "driving_license_number" TEXT,
    "driving_license_status" TEXT DEFAULT 'Not Verified',
    "driving_license_file" TEXT,
    "face_file" TEXT,
    "face_verification_status" TEXT DEFAULT 'Not Verified',
    "current_address" TEXT,
    "permanent_address" TEXT,
    "address_status" TEXT DEFAULT 'Not Verified',
    "address_file" TEXT,
    "staffId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StaffBackgroundVerification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "AttendanceAutomationRule_staffId_key" ON "AttendanceAutomationRule"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "AttendanceMode_staffId_key" ON "AttendanceMode"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "StaffBackgroundVerification_staffId_key" ON "StaffBackgroundVerification"("staffId");

-- AddForeignKey
ALTER TABLE "AttendanceAutomationRule" ADD CONSTRAINT "AttendanceAutomationRule_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttendanceMode" ADD CONSTRAINT "AttendanceMode_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffBackgroundVerification" ADD CONSTRAINT "StaffBackgroundVerification_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Verification" ADD CONSTRAINT "Verification_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;
