-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'STAFF', 'CLIENT');

-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('ADMIN', 'STAFF', 'CLIENT');

-- CreateEnum
CREATE TYPE "MarkAttendenceType" AS ENUM ('Office', 'Anywhere');

-- CreateEnum
CREATE TYPE "VerificationStatus" AS ENUM ('VERIFIED', 'PENDING', 'REJECTED');

-- CreateEnum
CREATE TYPE "LeaveType" AS ENUM ('MONTHLY', 'YEARLY');

-- CreateEnum
CREATE TYPE "LeaveRequestStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "FineType" AS ENUM ('HOURLY', 'DAILY');

-- CreateEnum
CREATE TYPE "PunchTime" AS ENUM ('ANYTIME', 'ADDLIMIT');

-- CreateEnum
CREATE TYPE "Day" AS ENUM ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');

-- CreateEnum
CREATE TYPE "punchRecordStatus" AS ENUM ('ABSENT', 'PRESENT', 'HALFDAY', 'PAIDLEAVE');

-- CreateEnum
CREATE TYPE "PunchInMethod" AS ENUM ('BIOMETRIC', 'QRSCAN', 'PHOTOCLICK');

-- CreateEnum
CREATE TYPE "PunchOutMethod" AS ENUM ('BIOMETRIC', 'QRSCAN', 'PHOTOCLICK');

-- CreateEnum
CREATE TYPE "BreakMethod" AS ENUM ('BIOMETRIC', 'QRSCAN', 'PHOTOCLICK');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "email" TEXT NOT NULL,
    "password" TEXT,
    "name" TEXT,
    "mobile" TEXT,
    "role" "UserRole" NOT NULL DEFAULT 'STAFF',
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "otp" INTEGER,
    "otpExpiresAt" TIMESTAMP(3),

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkEntry" (
    "id" TEXT NOT NULL,
    "work_name" TEXT NOT NULL,
    "units" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "attachments" TEXT,
    "location" TEXT,
    "staffDetailsId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WorkEntry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChatRoom" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT,
    "isGroup" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ChatRoom_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Message" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "content" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "senderId" TEXT NOT NULL,
    "roomId" TEXT NOT NULL,

    CONSTRAINT "Message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdminDetails" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "userId" TEXT NOT NULL,
    "package_id" TEXT,
    "company_name" TEXT,
    "company_logo" TEXT,
    "profile_image" TEXT,
    "time_format" TEXT,
    "time_zone" TEXT,
    "date_format" TEXT,
    "week_format" TEXT,

    CONSTRAINT "AdminDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StaffDetails" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "userId" TEXT NOT NULL,
    "job_title" TEXT,
    "branch" TEXT,
    "departmentId" TEXT,
    "roleId" TEXT,
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
    "guardian_name" TEXT,
    "status" TEXT,
    "employment" TEXT,
    "marital_status" TEXT,
    "blood_group" TEXT,

    CONSTRAINT "StaffDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Department" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "department_name" TEXT NOT NULL,

    CONSTRAINT "Department_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AttendanceAutomationRule" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "aadhaar_number" TEXT,
    "aadhaar_verification_status" "VerificationStatus" NOT NULL DEFAULT 'PENDING',
    "aadhaar_file" TEXT,
    "voter_id_number" TEXT,
    "voter_id_verification_status" "VerificationStatus" NOT NULL DEFAULT 'PENDING',
    "voter_id_file" TEXT,
    "pan_number" TEXT,
    "pan_verification_status" "VerificationStatus" NOT NULL DEFAULT 'PENDING',
    "pan_file" TEXT,
    "uan_number" TEXT,
    "uan_verification_status" "VerificationStatus" NOT NULL DEFAULT 'PENDING',
    "uan_file" TEXT,
    "driving_license_number" TEXT,
    "driving_license_status" "VerificationStatus" NOT NULL DEFAULT 'PENDING',
    "driving_license_file" TEXT,
    "face_file" TEXT,
    "face_verification_status" "VerificationStatus" NOT NULL DEFAULT 'PENDING',
    "current_address" TEXT,
    "permanent_address" TEXT,
    "address_status" "VerificationStatus" NOT NULL DEFAULT 'PENDING',
    "address_file" TEXT,
    "staffId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StaffBackgroundVerification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PastEmployment" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "company_name" TEXT NOT NULL,
    "designation" TEXT,
    "joining_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "leaving_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "currency" TEXT,
    "salary" DOUBLE PRECISION,
    "company_gst" TEXT,
    "past_Employment_status" "VerificationStatus" NOT NULL DEFAULT 'PENDING',
    "staffId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PastEmployment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BankDetails" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "staffId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "allowed_leaves" INTEGER NOT NULL DEFAULT 0,
    "carry_forward_leaves" INTEGER NOT NULL DEFAULT 0,
    "policy_type" "LeaveType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LeavePolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LeaveRequest" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "staffId" TEXT NOT NULL,
    "leaveTypeId" TEXT NOT NULL,
    "request_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "status" "LeaveRequestStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LeaveRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LeaveBalance" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "staffId" TEXT NOT NULL,
    "leavePolicyId" TEXT NOT NULL,
    "balance" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "used" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LeaveBalance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomDetails" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "staffId" TEXT NOT NULL,
    "field_name" TEXT NOT NULL,
    "field_value" TEXT NOT NULL,

    CONSTRAINT "CustomDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EarlyLeavePolicy" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "fineType" "FineType" NOT NULL DEFAULT 'HOURLY',
    "gracePeriodMins" INTEGER NOT NULL DEFAULT 0,
    "fineAmountMins" INTEGER NOT NULL DEFAULT 0,
    "waiveOffDays" INTEGER NOT NULL DEFAULT 0,
    "staffId" TEXT,

    CONSTRAINT "EarlyLeavePolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LateComingPolicy" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "fineType" "FineType" NOT NULL DEFAULT 'HOURLY',
    "gracePeriodMins" INTEGER NOT NULL DEFAULT 0,
    "fineAmountMins" INTEGER NOT NULL DEFAULT 0,
    "waiveOffDays" INTEGER NOT NULL DEFAULT 0,
    "staffId" TEXT,

    CONSTRAINT "LateComingPolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OvertimePolicy" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "gracePeriodMins" INTEGER NOT NULL DEFAULT 0,
    "extraHoursPay" INTEGER NOT NULL DEFAULT 0,
    "publicHolidayPay" INTEGER NOT NULL DEFAULT 0,
    "weekOffPay" INTEGER NOT NULL DEFAULT 0,
    "staffId" TEXT,

    CONSTRAINT "OvertimePolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "role_name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClientsPermissions" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "view_time_sheets" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ReportPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StaffRolePermissions" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "view_global" BOOLEAN NOT NULL DEFAULT false,
    "view_time_sheets" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SettingsPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StaffPermissions" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "grant_access" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ChatModulePermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AIPermissions" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "grant_access" BOOLEAN NOT NULL DEFAULT false,
    "permissionsId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AIPermissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permissions" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
CREATE TABLE "Shifts" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "shiftName" TEXT NOT NULL,
    "shiftStartTime" TEXT NOT NULL,
    "shiftEndTime" TEXT NOT NULL,
    "punchInType" "PunchTime" NOT NULL DEFAULT 'ANYTIME',
    "punchOutType" "PunchTime" NOT NULL DEFAULT 'ANYTIME',
    "allowPunchInHours" INTEGER,
    "allowPunchInMinutes" INTEGER,
    "allowPunchOutMinutes" INTEGER,
    "allowPunchOutHours" INTEGER,

    CONSTRAINT "Shifts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WeekOffShift" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "weekOne" BOOLEAN DEFAULT false,
    "weekTwo" BOOLEAN DEFAULT false,
    "weekThree" BOOLEAN DEFAULT false,
    "weekFour" BOOLEAN DEFAULT false,
    "weekFive" BOOLEAN DEFAULT false,

    CONSTRAINT "WeekOffShift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FixedShift" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "day" "Day" NOT NULL DEFAULT 'Mon',
    "weekOff" BOOLEAN NOT NULL DEFAULT false,
    "staffId" TEXT NOT NULL,
    "weekId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FixedShift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FlexibleShift" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "dateTime" TEXT NOT NULL,
    "weekOff" BOOLEAN NOT NULL DEFAULT false,
    "staffId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FlexibleShift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PunchRecords" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "punchDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchInId" TEXT,
    "punchOutId" TEXT,
    "staffId" TEXT,
    "status" "punchRecordStatus" NOT NULL DEFAULT 'ABSENT',

    CONSTRAINT "PunchRecords_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Fine" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "lateEntryFineAmount" DOUBLE PRECISION DEFAULT 1,
    "lateEntryAmount" DOUBLE PRECISION DEFAULT 0,
    "excessBreakFineAmount" DOUBLE PRECISION DEFAULT 1,
    "excessBreakAmount" DOUBLE PRECISION DEFAULT 0,
    "earlyOutFineAmount" DOUBLE PRECISION DEFAULT 1,
    "earlyOutAmount" DOUBLE PRECISION DEFAULT 0,
    "totalAmount" DOUBLE PRECISION DEFAULT 0,
    "shiftIds" TEXT,
    "punchRecordId" TEXT,
    "staffId" TEXT,

    CONSTRAINT "Fine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Overtime" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "earlyCommingEntryAmount" DOUBLE PRECISION DEFAULT 1,
    "earlyEntryAmount" DOUBLE PRECISION DEFAULT 0,
    "lateOutOvertimeAmount" DOUBLE PRECISION DEFAULT 1,
    "lateOutAmount" DOUBLE PRECISION DEFAULT 0,
    "totalAmount" DOUBLE PRECISION DEFAULT 0,
    "shiftIds" TEXT,
    "punchRecordId" TEXT,
    "staffId" TEXT,

    CONSTRAINT "Overtime_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PunchIn" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "punchInMethod" "PunchInMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "punchInTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchInDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "location" TEXT NOT NULL,
    "fine" TEXT,
    "approve" TEXT DEFAULT 'Pending',

    CONSTRAINT "PunchIn_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PunchOut" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "punchOutMethod" "PunchOutMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "punchOutTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "punchOutDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "location" TEXT NOT NULL,
    "overtime" TEXT,

    CONSTRAINT "PunchOut_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StartBreak" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "breakMethod" "BreakMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "startBreakTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "location" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "StartBreak_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EndBreak" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "breakMethod" "BreakMethod" NOT NULL DEFAULT 'PHOTOCLICK',
    "endBreakTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "biometricData" TEXT,
    "qrCodeValue" TEXT,
    "photoUrl" TEXT,
    "location" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "EndBreak_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskStatus" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "taskStatusName" TEXT NOT NULL,
    "statusColor" TEXT NOT NULL,
    "statusOrder" INTEGER NOT NULL DEFAULT 0,
    "canBeChangedId" TEXT[],

    CONSTRAINT "TaskStatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskPriority" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "taskPriorityName" TEXT NOT NULL,

    CONSTRAINT "TaskPriority_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskDetail" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "taskName" TEXT NOT NULL,
    "taskStatusId" TEXT NOT NULL,
    "taskPriorityId" TEXT NOT NULL,
    "startDate" TEXT NOT NULL,
    "endDate" TEXT,
    "dueDate" TEXT,
    "taskDescription" TEXT NOT NULL,
    "taskTag" TEXT,
    "attachFile" TEXT,

    CONSTRAINT "TaskDetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectFiles" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "file_name" TEXT NOT NULL,
    "file_type" TEXT NOT NULL,
    "last_activity" TEXT,
    "total_comments" TEXT,
    "visible_to_customer" BOOLEAN NOT NULL DEFAULT false,
    "uploaded_by" TEXT NOT NULL,
    "date_uploaded" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectFiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Project" (
    "id" TEXT NOT NULL,
    "project_name" TEXT NOT NULL,
    "billing_type" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "total_rate" INTEGER NOT NULL,
    "estimated_hours" INTEGER NOT NULL,
    "start_date" TEXT NOT NULL,
    "deadline" TEXT NOT NULL,
    "tags" TEXT[],
    "description" TEXT NOT NULL,
    "send_mail" BOOLEAN NOT NULL DEFAULT false,
    "customerId" TEXT,

    CONSTRAINT "Project_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TicketInformation" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
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
    "staffIdd" TEXT,

    CONSTRAINT "TicketInformation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Discussion" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "subject" TEXT NOT NULL,
    "discription" TEXT NOT NULL,
    "last_activity" TEXT NOT NULL,
    "total_comments" TEXT NOT NULL,
    "visible_to_customer" TEXT NOT NULL,

    CONSTRAINT "Discussion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClientDetails" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "userId" TEXT NOT NULL,
    "company" TEXT NOT NULL,
    "vat_number" TEXT NOT NULL,
    "website" TEXT,
    "groups" TEXT[],
    "currency" TEXT[],
    "default_language" TEXT[],
    "address" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "zip_code" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClientDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UpiDetails" (
    "UpiId" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "UpiDetails_pkey" PRIMARY KEY ("UpiId")
);

-- CreateTable
CREATE TABLE "ProjectStatus" (
    "id" TEXT NOT NULL,
    "project_name" TEXT NOT NULL,
    "project_color" TEXT NOT NULL,
    "project_order" TEXT NOT NULL,
    "default_filter" BOOLEAN NOT NULL DEFAULT false,
    "can_changed" TEXT[],

    CONSTRAINT "ProjectStatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectPriority" (
    "id" TEXT NOT NULL,
    "Priority_name" TEXT NOT NULL,
    "Priority_color" TEXT NOT NULL,
    "Priority_order" TEXT NOT NULL,
    "default_filter" BOOLEAN NOT NULL DEFAULT false,
    "is_hidden" TEXT[],
    "can_changed" TEXT[],

    CONSTRAINT "ProjectPriority_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Deductions" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "heads" TEXT,
    "calculation" TEXT,
    "amount" DOUBLE PRECISION,
    "deduction_month" TEXT,
    "staffId" TEXT,
    "salaryDetailsId" TEXT,

    CONSTRAINT "Deductions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Earnings" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "heads" TEXT,
    "calculation" TEXT,
    "amount" DOUBLE PRECISION,
    "staffId" TEXT,
    "salary_month" TEXT,
    "salaryDetailsId" TEXT,

    CONSTRAINT "Earnings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_UserRooms" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_staffId" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_departmentId" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_FixedShiftToShifts" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_FlexibleShiftToShifts" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ProjectStaff" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_projectId" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "AdminDetails_userId_key" ON "AdminDetails"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "StaffDetails_userId_key" ON "StaffDetails"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "AttendanceAutomationRule_staffId_key" ON "AttendanceAutomationRule"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "AttendanceMode_staffId_key" ON "AttendanceMode"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "StaffBackgroundVerification_staffId_key" ON "StaffBackgroundVerification"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "PastEmployment_staffId_key" ON "PastEmployment"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "BankDetails_staffId_key" ON "BankDetails"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "LeaveBalance_leavePolicyId_key" ON "LeaveBalance"("leavePolicyId");

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
CREATE UNIQUE INDEX "FixedShift_weekId_key" ON "FixedShift"("weekId");

-- CreateIndex
CREATE UNIQUE INDEX "FlexibleShift_staffId_dateTime_key" ON "FlexibleShift"("staffId", "dateTime");

-- CreateIndex
CREATE UNIQUE INDEX "PunchRecords_punchInId_key" ON "PunchRecords"("punchInId");

-- CreateIndex
CREATE UNIQUE INDEX "PunchRecords_punchOutId_key" ON "PunchRecords"("punchOutId");

-- CreateIndex
CREATE UNIQUE INDEX "Fine_punchRecordId_key" ON "Fine"("punchRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "Overtime_punchRecordId_key" ON "Overtime"("punchRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "ClientDetails_userId_key" ON "ClientDetails"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "ClientDetails_vat_number_key" ON "ClientDetails"("vat_number");

-- CreateIndex
CREATE UNIQUE INDEX "UpiDetails_staffId_key" ON "UpiDetails"("staffId");

-- CreateIndex
CREATE UNIQUE INDEX "_UserRooms_AB_unique" ON "_UserRooms"("A", "B");

-- CreateIndex
CREATE INDEX "_UserRooms_B_index" ON "_UserRooms"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_staffId_AB_unique" ON "_staffId"("A", "B");

-- CreateIndex
CREATE INDEX "_staffId_B_index" ON "_staffId"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_departmentId_AB_unique" ON "_departmentId"("A", "B");

-- CreateIndex
CREATE INDEX "_departmentId_B_index" ON "_departmentId"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_FixedShiftToShifts_AB_unique" ON "_FixedShiftToShifts"("A", "B");

-- CreateIndex
CREATE INDEX "_FixedShiftToShifts_B_index" ON "_FixedShiftToShifts"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_FlexibleShiftToShifts_AB_unique" ON "_FlexibleShiftToShifts"("A", "B");

-- CreateIndex
CREATE INDEX "_FlexibleShiftToShifts_B_index" ON "_FlexibleShiftToShifts"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ProjectStaff_AB_unique" ON "_ProjectStaff"("A", "B");

-- CreateIndex
CREATE INDEX "_ProjectStaff_B_index" ON "_ProjectStaff"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_projectId_AB_unique" ON "_projectId"("A", "B");

-- CreateIndex
CREATE INDEX "_projectId_B_index" ON "_projectId"("B");

-- AddForeignKey
ALTER TABLE "WorkEntry" ADD CONSTRAINT "WorkEntry_staffDetailsId_fkey" FOREIGN KEY ("staffDetailsId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "ChatRoom"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdminDetails" ADD CONSTRAINT "AdminDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffDetails" ADD CONSTRAINT "StaffDetails_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "Department"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffDetails" ADD CONSTRAINT "StaffDetails_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffDetails" ADD CONSTRAINT "StaffDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttendanceAutomationRule" ADD CONSTRAINT "AttendanceAutomationRule_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AttendanceMode" ADD CONSTRAINT "AttendanceMode_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StaffBackgroundVerification" ADD CONSTRAINT "StaffBackgroundVerification_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PastEmployment" ADD CONSTRAINT "PastEmployment_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BankDetails" ADD CONSTRAINT "BankDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeavePolicy" ADD CONSTRAINT "LeavePolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeaveRequest" ADD CONSTRAINT "LeaveRequest_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeaveRequest" ADD CONSTRAINT "LeaveRequest_leaveTypeId_fkey" FOREIGN KEY ("leaveTypeId") REFERENCES "LeavePolicy"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeaveBalance" ADD CONSTRAINT "LeaveBalance_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeaveBalance" ADD CONSTRAINT "LeaveBalance_leavePolicyId_fkey" FOREIGN KEY ("leavePolicyId") REFERENCES "LeavePolicy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomDetails" ADD CONSTRAINT "CustomDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EarlyLeavePolicy" ADD CONSTRAINT "EarlyLeavePolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LateComingPolicy" ADD CONSTRAINT "LateComingPolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OvertimePolicy" ADD CONSTRAINT "OvertimePolicy_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

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
ALTER TABLE "SalaryDetails" ADD CONSTRAINT "SalaryDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FixedShift" ADD CONSTRAINT "FixedShift_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FixedShift" ADD CONSTRAINT "FixedShift_weekId_fkey" FOREIGN KEY ("weekId") REFERENCES "WeekOffShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FlexibleShift" ADD CONSTRAINT "FlexibleShift_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchRecords" ADD CONSTRAINT "PunchRecords_punchInId_fkey" FOREIGN KEY ("punchInId") REFERENCES "PunchIn"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchRecords" ADD CONSTRAINT "PunchRecords_punchOutId_fkey" FOREIGN KEY ("punchOutId") REFERENCES "PunchOut"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PunchRecords" ADD CONSTRAINT "PunchRecords_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fine" ADD CONSTRAINT "Fine_shiftIds_fkey" FOREIGN KEY ("shiftIds") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fine" ADD CONSTRAINT "Fine_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES "PunchRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fine" ADD CONSTRAINT "Fine_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Overtime" ADD CONSTRAINT "Overtime_shiftIds_fkey" FOREIGN KEY ("shiftIds") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Overtime" ADD CONSTRAINT "Overtime_punchRecordId_fkey" FOREIGN KEY ("punchRecordId") REFERENCES "PunchRecords"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Overtime" ADD CONSTRAINT "Overtime_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StartBreak" ADD CONSTRAINT "StartBreak_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EndBreak" ADD CONSTRAINT "EndBreak_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "ClientDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TicketInformation" ADD CONSTRAINT "TicketInformation_staffIdd_fkey" FOREIGN KEY ("staffIdd") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClientDetails" ADD CONSTRAINT "ClientDetails_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UpiDetails" ADD CONSTRAINT "UpiDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Deductions" ADD CONSTRAINT "Deductions_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Deductions" ADD CONSTRAINT "Deductions_salaryDetailsId_fkey" FOREIGN KEY ("salaryDetailsId") REFERENCES "SalaryDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Earnings" ADD CONSTRAINT "Earnings_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Earnings" ADD CONSTRAINT "Earnings_salaryDetailsId_fkey" FOREIGN KEY ("salaryDetailsId") REFERENCES "SalaryDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserRooms" ADD CONSTRAINT "_UserRooms_A_fkey" FOREIGN KEY ("A") REFERENCES "ChatRoom"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserRooms" ADD CONSTRAINT "_UserRooms_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_staffId" ADD CONSTRAINT "_staffId_A_fkey" FOREIGN KEY ("A") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_staffId" ADD CONSTRAINT "_staffId_B_fkey" FOREIGN KEY ("B") REFERENCES "TaskStatus"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_departmentId" ADD CONSTRAINT "_departmentId_A_fkey" FOREIGN KEY ("A") REFERENCES "Department"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_departmentId" ADD CONSTRAINT "_departmentId_B_fkey" FOREIGN KEY ("B") REFERENCES "TaskDetail"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FixedShiftToShifts" ADD CONSTRAINT "_FixedShiftToShifts_A_fkey" FOREIGN KEY ("A") REFERENCES "FixedShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FixedShiftToShifts" ADD CONSTRAINT "_FixedShiftToShifts_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FlexibleShiftToShifts" ADD CONSTRAINT "_FlexibleShiftToShifts_A_fkey" FOREIGN KEY ("A") REFERENCES "FlexibleShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FlexibleShiftToShifts" ADD CONSTRAINT "_FlexibleShiftToShifts_B_fkey" FOREIGN KEY ("B") REFERENCES "Shifts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProjectStaff" ADD CONSTRAINT "_ProjectStaff_A_fkey" FOREIGN KEY ("A") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProjectStaff" ADD CONSTRAINT "_ProjectStaff_B_fkey" FOREIGN KEY ("B") REFERENCES "StaffDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_projectId" ADD CONSTRAINT "_projectId_A_fkey" FOREIGN KEY ("A") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_projectId" ADD CONSTRAINT "_projectId_B_fkey" FOREIGN KEY ("B") REFERENCES "TaskDetail"("id") ON DELETE CASCADE ON UPDATE CASCADE;
