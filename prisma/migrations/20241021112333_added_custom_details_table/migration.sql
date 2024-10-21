-- CreateTable
CREATE TABLE "CustomDetails" (
    "id" TEXT NOT NULL,
    "staffId" TEXT NOT NULL,
    "field_name" TEXT NOT NULL,
    "field_value" TEXT NOT NULL,

    CONSTRAINT "CustomDetails_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CustomDetails" ADD CONSTRAINT "CustomDetails_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
