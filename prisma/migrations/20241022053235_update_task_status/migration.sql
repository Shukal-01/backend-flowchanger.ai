/*
  Warnings:

  - Made the column `statusColor` on table `TaskStatus` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "CustomDetails" DROP CONSTRAINT "CustomDetails_staffId_fkey";

-- AlterTable
ALTER TABLE "Admin" ADD COLUMN     "profile_image" TEXT;

-- AlterTable
ALTER TABLE "CustomDetails" ALTER COLUMN "staffId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "TaskStatus" ALTER COLUMN "statusColor" SET NOT NULL;

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

-- AddForeignKey
ALTER TABLE "CustomDetails" ADD CONSTRAINT "CustomDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE SET NULL ON UPDATE CASCADE;

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
