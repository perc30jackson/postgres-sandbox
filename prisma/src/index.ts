/**
 * Prisma Learning - Main Entry Point
 * ===================================
 * This file provides an overview and runs all lessons.
 */

import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  console.log("🔷".repeat(25));
  console.log("\n   Welcome to Prisma Learning!\n");
  console.log("🔷".repeat(25));

  // Test connection
  console.log("\n📡 Testing database connection...");
  await prisma.$connect();
  console.log("✅ Connected to PostgreSQL!");

  // Show database statistics
  console.log("\n📊 Database Overview:");
  console.log("-".repeat(40));

  const stats = await Promise.all([
    prisma.author.count(),
    prisma.book.count(),
    prisma.category.count(),
    prisma.customer.count(),
    prisma.order.count(),
    prisma.review.count(),
  ]);

  const labels = [
    "Authors",
    "Books",
    "Categories",
    "Customers",
    "Orders",
    "Reviews",
  ];

  for (let i = 0; i < labels.length; i++) {
    console.log(`   ${labels[i].padEnd(12)} ${stats[i]}`);
  }

  // Show sample data
  console.log("\n📚 Sample Books:");
  console.log("-".repeat(40));

  const books = await prisma.book.findMany({
    take: 5,
    include: {
      author: { select: { name: true } },
      category: { select: { name: true } },
    },
    orderBy: { title: "asc" },
  });

  for (const book of books) {
    console.log(`   ${book.title}`);
    console.log(
      `      by ${book.author?.name || "Unknown"} | ${book.category?.name || "Uncategorized"} | $${book.price}`
    );
  }

  console.log("\n" + "=".repeat(50));
  console.log("Available Lessons:");
  console.log("=".repeat(50));
  console.log("\n   pnpm lesson:basics     - Basic queries and connection");
  console.log("   pnpm lesson:crud       - CRUD operations");
  console.log("   pnpm lesson:relations  - Working with relationships");
  console.log("\nOther Commands:");
  console.log("   pnpm prisma:studio     - Visual database browser");
  console.log("   pnpm prisma:generate   - Regenerate Prisma Client");
}

main()
  .then(async () => {
    console.log("\n" + "=".repeat(50));
    console.log("Happy learning! 🎉");
    console.log("=".repeat(50) + "\n");
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error("❌ Error:", e);
    await prisma.$disconnect();
    process.exit(1);
  });
