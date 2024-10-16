-- CreateTable
CREATE TABLE "Admin" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "mobile" INTEGER NOT NULL,
    "time_zone" TIMESTAMP(3) NOT NULL,
    "time_formate" TEXT NOT NULL,
    "date_formate" TEXT NOT NULL,
    "week_formate" TEXT NOT NULL,
    "package_id" INTEGER NOT NULL,
    "company_name" TEXT NOT NULL,
    "company_logo" TEXT,
    "password" TEXT NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");
