-- CreateEnum
CREATE TYPE "MarkAttendenceType" AS ENUM ('Office', 'Anywhere');

-- CreateEnum
CREATE TYPE "VerificationType" AS ENUM ('AADHAAR', 'PAN', 'DRIVING_LICENSE', 'UAN', 'FACE', 'ADDRESS', 'PAST_EMPLOYMENT');

-- CreateEnum
CREATE TYPE "VerificationStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "FineType" AS ENUM ('HOURLY', 'DAILY');

-- CreateEnum
CREATE TYPE "PunchTime" AS ENUM ('ANYTIME', 'ADDLIMIT');

-- CreateEnum
CREATE TYPE "PunchInMethod" AS ENUM ('BIOMETRIC', 'QRSCAN', 'PHOTOCLICK');

-- CreateEnum
CREATE TYPE "PunchOutMethod" AS ENUM ('BIOMETRIC', 'QRSCAN', 'PHOTOCLICK');

-- CreateEnum
CREATE TYPE "StatusType" AS ENUM ('active', 'inactive');

-- CreateTable
CREATE TABLE "Admin" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "time_zone" TEXT NOT NULL,
    "time_formate" TEXT NOT NULL,
    "date_formate" TEXT NOT NULL,
    "week_formate" TEXT NOT NULL,
    "package_id" TEXT NOT NULL,
    "company_name" TEXT NOT NULL,
    "company_logo" TEXT,
    "profile_image" TEXT,
    "password" TEXT NOT NULL,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "otp" INTEGER NOT NULL,
    "otpExpiresAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Staff" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "job_title" TEXT,
    "branch" TEXT,
    "departmentId" TEXT,
    "roleId" TEXT,
    "mobile" TEXT,
    "login_otp" TEXT,
    "gender" TEXT,
    "official_email" TEXT,
    "date_of_joining" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "date_of_birth" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "current_address" TEXT,
    "permanent_address" TEXT,
    "emergency_contact_name" TEXT,
    "emergency_contact_mobile" TEXT,
    "emergency_contact_relation" TEXT,
    "emergency_contact_address" TEXT,

    CONSTRAINT "Staff_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Department" (
    "id" TEXT NOT NULL,
    "department_name" TEXT NOT NULL,

    CONSTRAINT "Department_pkey" PRIMARY KEY ("id")
);

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

-- CreateTable
CREATE TABLE "BankDetails" (
    "id" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,
    "bank_name" TEXT,
    "account_number" TEXT,
    "branch_name" TEXT,
    "ifsc_code" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BankDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LeavePolicy" (
    "id" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "allowed_leaves" INTEGER NOT NULL DEFAULT 0,
    "carry_forward_leaves" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LeavePolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LeaveBalance" (
    "id" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,
    "leaveTypeId" TEXT NOT NULL,
    "balance" INTEGER NOT NULL DEFAULT 0,
    "used" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LeaveBalance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LeaveRequest" (
    "id" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,
    "leaveTypeId" TEXT NOT NULL,
    "request_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LeaveRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Verification" (
    "id" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,
    "type" "VerificationType" NOT NULL,
    "status" "VerificationStatus" NOT NULL,
    "documentUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Verification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomDetails" (
    "id" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,
    "field_name" TEXT NOT NULL,
    "field_value" TEXT NOT NULL,

    CONSTRAINT "CustomDetails_pkey" PRIMARY KEY ("id")
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
    "fineType" "FineType" NOT NULL DEFAULT 'HOURLY',
    "gracePeriodMins" INTEGER NOT NULL,
    "fineAmountMins" INTEGER NOT NULL,
    "waiveOffDays" INTEGER NOT NULL,
    "panaltyOvertimeDetailId" TEXT,

    CONSTRAINT "EarlyLeavePolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LateComingPolicy" (
    "id" TEXT NOT NULL,
    "fineType" "FineType" NOT NULL DEFAULT 'HOURLY',
    "gracePeriodMins" INTEGER NOT NULL,
    "fineAmountMins" INTEGER NOT NULL,
    "waiveOffDays" INTEGER NOT NULL,
    "panaltyOvertimeDetailId" TEXT,

    CONSTRAINT "LateComingPolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OvertimePolicy" (
    "id" TEXT NOT NULL,
    "gracePeriodMins" INTEGER NOT NULL,
    "extraHoursPay" INTEGER NOT NULL,
    "publicHolidayPay" INTEGER NOT NULL,
    "weekOffPay" INTEGER NOT NULL,
    "panaltyOvertimeDetailId" TEXT,

    CONSTRAINT "OvertimePolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" TEXT NOT NULL,
    "role_name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClientsPermissions" (
    "id" TEXT NOT NULL,
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "create" BOOLEAN NOT NULL DEFAULT false,
    "edit" BOOLEAN NOT NULL DEFAULT false,
    "delete" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClientsPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectsPermissions" (
    "id" TEXT NOT NULL,
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "create" BOOLEAN NOT NULL DEFAULT false,
    "edit" BOOLEAN NOT NULL DEFAULT false,
    "delete" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectsPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReportPermissions" (
    "id" TEXT NOT NULL,
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "view_time_sheets" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ReportPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StaffRolePermissions" (
    "id" TEXT NOT NULL,
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "create" BOOLEAN NOT NULL DEFAULT false,
    "edit" BOOLEAN NOT NULL DEFAULT false,
    "delete" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StaffRolePermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SettingsPermissions" (
    "id" TEXT NOT NULL,
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "view_time_sheets" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SettingsPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StaffPermissions" (
    "id" TEXT NOT NULL,
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "create" BOOLEAN NOT NULL DEFAULT false,
    "edit" BOOLEAN NOT NULL DEFAULT false,
    "delete" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StaffPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskPermissions" (
    "id" TEXT NOT NULL,
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "create" BOOLEAN NOT NULL DEFAULT false,
    "edit" BOOLEAN NOT NULL DEFAULT false,
    "delete" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TaskPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubTaskPermissions" (
    "id" TEXT NOT NULL,
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "create" BOOLEAN NOT NULL DEFAULT false,
    "edit" BOOLEAN NOT NULL DEFAULT false,
    "delete" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SubTaskPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChatModulePermissions" (
    "id" TEXT NOT NULL,
    "grant_access" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ChatModulePermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AIPermissions" (
    "id" TEXT NOT NULL,
    "grant_access" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AIPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permissions" (
    "id" TEXT NOT NULL,
    "roleId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SalaryDetails" (
    "id" TEXT NOT NULL,
    "effective_date" TIMESTAMP(3),
    "salary_type" TEXT,
    "ctc_amount" DOUBLE PRECISION,
    "basic" DOUBLE PRECISION,
    "hra" DOUBLE PRECISION,
    "dearness_allowance" DOUBLE PRECISION,
    "employer_pf" DOUBLE PRECISION,
    "employer_esi" DOUBLE PRECISION,
    "employer_lwf" DOUBLE PRECISION,
    "employee_pf" DOUBLE PRECISION,
    "employee_esi" DOUBLE PRECISION,
    "professional_tax" DOUBLE PRECISION,
    "employee_lwf" DOUBLE PRECISION,
    "tds" DOUBLE PRECISION,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "staffId" TEXT NOT NULL,

    CONSTRAINT "SalaryDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Deductions" (
    "id" TEXT NOT NULL,
    "salaryId" TEXT,
    "heads" TEXT[],
    "calculation" TEXT[],
    "amount" DOUBLE PRECISION[],
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Deductions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Shifts" (
    "id" TEXT NOT NULL,
    "shiftName" TEXT NOT NULL,
    "shiftStartTime" TEXT NOT NULL,
    "shiftEndTime" TEXT NOT NULL,
    "punchInType" "PunchTime" NOT NULL DEFAULT 'ANYTIME',
    "punchOutType" "PunchTime" NOT NULL DEFAULT 'ANYTIME',
    "fixedId" TEXT,
    "flexibleId" TEXT,

    CONSTRAINT "Shifts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FixedShift" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "weekOff" BOOLEAN NOT NULL,
    "staffId" TEXT,

    CONSTRAINT "FixedShift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FlexibleShift" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "weekOff" BOOLEAN NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "FlexibleShift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PunchRecords" (
    "id" TEXT NOT NULL,
    "punchDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchInId" TEXT NOT NULL,
    "punchOutId" TEXT NOT NULL,
    "staffId" TEXT,

    CONSTRAINT "PunchRecords_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PunchIn" (
    "id" TEXT NOT NULL,
    "punchInMethod" "PunchInMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "punchInTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchInDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "PunchIn_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PunchOut" (
    "id" TEXT NOT NULL,
    "punchOutMethod" "PunchOutMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "punchOutTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchOutDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "PunchOut_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskStatus" (
    "id" TEXT NOT NULL,
    "taskStatusName" TEXT NOT NULL,
    "statusColor" TEXT NOT NULL,
    "statusOrder" INTEGER NOT NULL,
    "isHiddenId" TEXT NOT NULL,
    "canBeChangedId" TEXT NOT NULL,

    CONSTRAINT "TaskStatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskPriority" (
    "id" TEXT NOT NULL,
    "taskPriorityName" TEXT NOT NULL,

    CONSTRAINT "TaskPriority_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskDetail" (
    "id" TEXT NOT NULL,
    "taskName" TEXT NOT NULL,
    "taskStatusId" TEXT NOT NULL,
    "taskTypeId" TEXT NOT NULL,
    "taskPriorityId" TEXT NOT NULL,
    "startDate" TEXT NOT NULL,
    "endDate" TEXT NOT NULL,
    "dueDate" TEXT NOT NULL,
    "selectProject" TEXT NOT NULL,
    "selectDepartment" TEXT NOT NULL,
    "taskAssign" TEXT NOT NULL,
    "taskDescription" TEXT NOT NULL,
    "attachFile" TEXT NOT NULL,

    CONSTRAINT "TaskDetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectFiles" (
    "id" TEXT NOT NULL,
    "file_name" TEXT NOT NULL,
    "file_type" TEXT NOT NULL,
    "last_activity" TEXT,
    "total_comments" TEXT,
    "visible_to_customer" BOOLEAN NOT NULL DEFAULT false,
    "uploaded_by" TEXT NOT NULL,
    "date_uploaded" TIMESTAMP(3) NOT NULL,
    "projectId" TEXT NOT NULL,

    CONSTRAINT "ProjectFiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Project" (
    "id" TEXT NOT NULL,
    "project_name" TEXT NOT NULL,
    "customer" TEXT NOT NULL,
    "billing_type" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "total_rate" INTEGER NOT NULL,
    "estimated_hours" INTEGER NOT NULL,
    "start_Date" TEXT NOT NULL,
    "department" TEXT NOT NULL,
    "deadline" TEXT NOT NULL,
    "tags" TEXT[],
    "description" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,

    CONSTRAINT "Project_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TicketInformation" (
    "id" TEXT NOT NULL,
    "subject" TEXT NOT NULL,
    "contact" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "department" TEXT NOT NULL,
    "cc" TEXT NOT NULL,
    "tags" TEXT[],
    "asign_ticket" TEXT NOT NULL,
    "priority" TEXT NOT NULL,
    "service" TEXT NOT NULL,
    "project" TEXT NOT NULL,
    "ticket_body" TEXT NOT NULL,
    "insert_link" TEXT NOT NULL,
    "personal_notes" TEXT NOT NULL,
    "insert_files" TEXT NOT NULL,
    "projectId" TEXT,
    "staffIdd" TEXT,

    CONSTRAINT "TicketInformation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Discussion" (
    "id" TEXT NOT NULL,
    "subject" TEXT NOT NULL,
    "discription" TEXT NOT NULL,
    "last_activity" TEXT NOT NULL,
    "total_comments" TEXT NOT NULL,
    "visible_to_customer" TEXT NOT NULL,
    "projectId" TEXT,

    CONSTRAINT "Discussion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Client" (
    "id" TEXT NOT NULL,
    "company" TEXT NOT NULL,
    "vat_number" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "website" TEXT,
    "groups" TEXT[],
    "currency" TEXT[],
    "default_language" TEXT[],
    "address" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "status" "StatusType" NOT NULL DEFAULT 'inactive',
    "zip_code" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "AttendanceAutomationRule_staffId_key" ON "AttendanceAutomationRule"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "AttendanceMode_staffId_key" ON "AttendanceMode"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "StaffBackgroundVerification_staffId_key" ON "StaffBackgroundVerification"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "PanaltyOvertimeDetails_staffId_key" ON "PanaltyOvertimeDetails"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "EarlyLeavePolicy_panaltyOvertimeDetailId_key" ON "EarlyLeavePolicy"("panaltyOvertimeDetailId");

-- CreateIndex
CREATE UNIQUE INDEX "LateComingPolicy_panaltyOvertimeDetailId_key" ON "LateComingPolicy"("panaltyOvertimeDetailId");

-- CreateIndex
CREATE UNIQUE INDEX "OvertimePolicy_panaltyOvertimeDetailId_key" ON "OvertimePolicy"("panaltyOvertimeDetailId");

-- CreateIndex
CREATE UNIQUE INDEX "Role_role_name_key" ON "Role"("role_name");

-- CreateIndex
CREATE UNIQUE INDEX "ClientsPermissions_permissionsId_key" ON "ClientsPermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectsPermissions_permissionsId_key" ON "ProjectsPermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "ReportPermissions_permissionsId_key" ON "ReportPermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "StaffRolePermissions_permissionsId_key" ON "StaffRolePermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "SettingsPermissions_permissionsId_key" ON "SettingsPermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "StaffPermissions_permissionsId_key" ON "StaffPermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "TaskPermissions_permissionsId_key" ON "TaskPermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "SubTaskPermissions_permissionsId_key" ON "SubTaskPermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "ChatModulePermissions_permissionsId_key" ON "ChatModulePermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "AIPermissions_permissionsId_key" ON "AIPermissions"("permissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "Permissions_roleId_key" ON "Permissions"("roleId");

-- CreateIndex
CREATE UNIQUE INDEX "PunchRecords_punchInId_key" ON "PunchRecords"("punchInId");

-- CreateIndex
CREATE UNIQUE INDEX "PunchRecords_punchOutId_key" ON "PunchRecords"("punchOutId");

-- CreateIndex
CREATE UNIQUE INDEX "Client_vat_number_key" ON "Client"("vat_number");

-- AddForeignKey
ALTER TABLE "Staff" ADD CONSTRAINT "Staff_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "Department"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Staff" ADD CONSTRAINT "Staff_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttendanceAutomationRule" ADD CONSTRAINT "AttendanceAutomationRule_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttendanceMode" ADD CONSTRAINT "AttendanceMode_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffBackgroundVerification" ADD CONSTRAINT "StaffBackgroundVerification_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BankDetails" ADD CONSTRAINT "BankDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeavePolicy" ADD CONSTRAINT "LeavePolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeaveBalance" ADD CONSTRAINT "LeaveBalance_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeaveBalance" ADD CONSTRAINT "LeaveBalance_leaveTypeId_fkey" FOREIGN KEY ("leaveTypeId") REFERENCES "LeavePolicy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeaveRequest" ADD CONSTRAINT "LeaveRequest_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeaveRequest" ADD CONSTRAINT "LeaveRequest_leaveTypeId_fkey" FOREIGN KEY ("leaveTypeId") REFERENCES "LeavePolicy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Verification" ADD CONSTRAINT "Verification_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomDetails" ADD CONSTRAINT "CustomDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PanaltyOvertimeDetails" ADD CONSTRAINT "PanaltyOvertimeDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EarlyLeavePolicy" ADD CONSTRAINT "EarlyLeavePolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LateComingPolicy" ADD CONSTRAINT "LateComingPolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OvertimePolicy" ADD CONSTRAINT "OvertimePolicy_panaltyOvertimeDetailId_fkey" FOREIGN KEY ("panaltyOvertimeDetailId") REFERENCES "PanaltyOvertimeDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClientsPermissions" ADD CONSTRAINT "ClientsPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectsPermissions" ADD CONSTRAINT "ProjectsPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReportPermissions" ADD CONSTRAINT "ReportPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffRolePermissions" ADD CONSTRAINT "StaffRolePermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SettingsPermissions" ADD CONSTRAINT "SettingsPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffPermissions" ADD CONSTRAINT "StaffPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskPermissions" ADD CONSTRAINT "TaskPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubTaskPermissions" ADD CONSTRAINT "SubTaskPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChatModulePermissions" ADD CONSTRAINT "ChatModulePermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AIPermissions" ADD CONSTRAINT "AIPermissions_permissionsId_fkey" FOREIGN KEY ("permissionsId") REFERENCES "Permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Permissions" ADD CONSTRAINT "Permissions_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalaryDetails" ADD CONSTRAINT "SalaryDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Deductions" ADD CONSTRAINT "Deductions_salaryId_fkey" FOREIGN KEY ("salaryId") REFERENCES "SalaryDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shifts" ADD CONSTRAINT "Shifts_fixedId_fkey" FOREIGN KEY ("fixedId") REFERENCES "FixedShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shifts" ADD CONSTRAINT "Shifts_flexibleId_fkey" FOREIGN KEY ("flexibleId") REFERENCES "FlexibleShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FixedShift" ADD CONSTRAINT "FixedShift_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FlexibleShift" ADD CONSTRAINT "FlexibleShift_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchRecords" ADD CONSTRAINT "PunchRecords_punchInId_fkey" FOREIGN KEY ("punchInId") REFERENCES "PunchIn"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchRecords" ADD CONSTRAINT "PunchRecords_punchOutId_fkey" FOREIGN KEY ("punchOutId") REFERENCES "PunchOut"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchRecords" ADD CONSTRAINT "PunchRecords_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchIn" ADD CONSTRAINT "PunchIn_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchOut" ADD CONSTRAINT "PunchOut_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskDetail" ADD CONSTRAINT "TaskDetail_taskPriorityId_fkey" FOREIGN KEY ("taskPriorityId") REFERENCES "TaskPriority"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskDetail" ADD CONSTRAINT "TaskDetail_taskStatusId_fkey" FOREIGN KEY ("taskStatusId") REFERENCES "TaskStatus"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectFiles" ADD CONSTRAINT "ProjectFiles_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TicketInformation" ADD CONSTRAINT "TicketInformation_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TicketInformation" ADD CONSTRAINT "TicketInformation_staffIdd_fkey" FOREIGN KEY ("staffIdd") REFERENCES "Staff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Discussion" ADD CONSTRAINT "Discussion_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;
