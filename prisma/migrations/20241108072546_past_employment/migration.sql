-- CreateTable
CREATE TABLE "PastEmployment" (
    "id" SERIAL NOT NULL,
    "companyName" TEXT NOT NULL,
    "designation" TEXT,
    "joiningDate" TIMESTAMP(3) NOT NULL,
    "leavingDate" TIMESTAMP(3) NOT NULL,
    "currency" TEXT,
    "salary" DOUBLE PRECISION,
    "companyGST" TEXT,
    "staffId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PastEmployment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PastEmployment_staffId_key" ON "PastEmployment"("staffId");

-- AddForeignKey
ALTER TABLE "PastEmployment" ADD CONSTRAINT "PastEmployment_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "StaffDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;
