-- DropForeignKey
ALTER TABLE "AIPermissions" DROP CONSTRAINT "AIPermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "ChatModulePermissions" DROP CONSTRAINT "ChatModulePermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "ClientsPermissions" DROP CONSTRAINT "ClientsPermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "Permissions" DROP CONSTRAINT "Permissions_roleId_fkey";

-- DropForeignKey
ALTER TABLE "ProjectsPermissions" DROP CONSTRAINT "ProjectsPermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "ReportPermissions" DROP CONSTRAINT "ReportPermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "SettingsPermissions" DROP CONSTRAINT "SettingsPermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "StaffPermissions" DROP CONSTRAINT "StaffPermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "StaffRolePermissions" DROP CONSTRAINT "StaffRolePermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "SubTaskPermissions" DROP CONSTRAINT "SubTaskPermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "TaskPermissions" DROP CONSTRAINT "TaskPermissions_permissionsId_fkey";

-- DropForeignKey
ALTER TABLE "deductions" DROP CONSTRAINT "deductions_salaryId_fkey";

-- AlterTable
ALTER TABLE "deductions" ALTER COLUMN "salaryId" DROP NOT NULL;

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
ALTER TABLE "deductions" ADD CONSTRAINT "deductions_salaryId_fkey" FOREIGN KEY ("salaryId") REFERENCES "SalaryDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;
