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
