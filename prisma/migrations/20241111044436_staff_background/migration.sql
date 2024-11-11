-- AlterTable
ALTER TABLE "StaffBackgroundVerification" ADD COLUMN     "voter_id_file" TEXT,
ADD COLUMN     "voter_id_number" TEXT,
ADD COLUMN     "voter_id_verification_status" "VerificationStatus" NOT NULL DEFAULT 'PENDING';
