-- AlterTable
ALTER TABLE "BankDetails" ALTER COLUMN "bank_name" DROP NOT NULL,
ALTER COLUMN "account_number" DROP NOT NULL,
ALTER COLUMN "branch_name" DROP NOT NULL,
ALTER COLUMN "ifsc_code" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Staff" ALTER COLUMN "date_of_joining" DROP NOT NULL,
ALTER COLUMN "address" DROP NOT NULL;
