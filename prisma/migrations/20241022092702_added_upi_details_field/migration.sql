-- CreateTable
CREATE TABLE "UpiDetails" (
    "UpiId" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,

    CONSTRAINT "UpiDetails_pkey" PRIMARY KEY ("UpiId")
);

-- CreateIndex
CREATE UNIQUE INDEX "UpiDetails_staffId_key" ON "UpiDetails"("staffId");

-- AddForeignKey
ALTER TABLE "UpiDetails" ADD CONSTRAINT "UpiDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
