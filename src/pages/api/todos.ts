import type { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from ".prisma/client"

const prisma = PrismaClient

export default async (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === "GET") {
    // get all todos
    const todos = await prisma.customer.findMany({
      orderBy: { createdAt: "desc" },
    });
    res.json(todos);
  } else if (req.method === "POST") {
    //create customer
  } else if (req.method === "PUT") {
    // update customer
  } else if (req.method === "DELETE") {
    // delete customer
  }
};
