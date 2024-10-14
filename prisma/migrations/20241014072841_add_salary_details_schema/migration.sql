-- CreateTable
CREATE TABLE "SalaryDetails" (
    "id" TEXT NOT NULL,
    "effective_Date" TIMESTAMP(3) NOT NULL,
    "salary_Type" TEXT NOT NULL,
    "ctc_Amount" DOUBLE PRECISION NOT NULL,
    "basic" DOUBLE PRECISION NOT NULL,
    "hra" DOUBLE PRECISION NOT NULL,
    "dearness_Allowance" DOUBLE PRECISION NOT NULL,
    "employer_PF" DOUBLE PRECISION NOT NULL,
    "employer_ESI" DOUBLE PRECISION NOT NULL,
    "employer_LWF" DOUBLE PRECISION NOT NULL,
    "employee_PF" DOUBLE PRECISION NOT NULL,
    "employee_ESI" DOUBLE PRECISION NOT NULL,
    "professional_Tax" DOUBLE PRECISION NOT NULL,
    "employee_LWF" DOUBLE PRECISION NOT NULL,
    "tds" DOUBLE PRECISION NOT NULL,
    "created_At" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_At" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SalaryDetails_pkey" PRIMARY KEY ("id")
);
