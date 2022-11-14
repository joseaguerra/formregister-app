/*
  Warnings:

  - You are about to drop the `Todo` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('PARENT', 'GUARDIAN', 'SISTER', 'BROTHER');

-- DropTable
DROP TABLE "Todo";

-- CreateTable
CREATE TABLE "Customer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "phone" INTEGER NOT NULL,
    "email" TEXT NOT NULL,
    "addressId" TEXT NOT NULL,
    "nif" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Child" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "birthday" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Child_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChildsOnCustomers" (
    "customerId" TEXT NOT NULL,
    "childId" TEXT NOT NULL,
    "role" "Role" NOT NULL,

    CONSTRAINT "ChildsOnCustomers_pkey" PRIMARY KEY ("customerId","childId")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" TEXT NOT NULL,
    "street" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "province" TEXT NOT NULL,
    "postalCode" INTEGER NOT NULL,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ChildToCustomer" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Customer_email_key" ON "Customer"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Customer_nif_key" ON "Customer"("nif");

-- CreateIndex
CREATE UNIQUE INDEX "_ChildToCustomer_AB_unique" ON "_ChildToCustomer"("A", "B");

-- CreateIndex
CREATE INDEX "_ChildToCustomer_B_index" ON "_ChildToCustomer"("B");

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChildsOnCustomers" ADD CONSTRAINT "ChildsOnCustomers_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "Customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChildsOnCustomers" ADD CONSTRAINT "ChildsOnCustomers_childId_fkey" FOREIGN KEY ("childId") REFERENCES "Child"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ChildToCustomer" ADD CONSTRAINT "_ChildToCustomer_A_fkey" FOREIGN KEY ("A") REFERENCES "Child"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ChildToCustomer" ADD CONSTRAINT "_ChildToCustomer_B_fkey" FOREIGN KEY ("B") REFERENCES "Customer"("id") ON DELETE CASCADE ON UPDATE CASCADE;
