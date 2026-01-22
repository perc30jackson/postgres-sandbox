/**
 * Lesson 1: Prisma Basics - Connecting and Querying
 * ==================================================
 * Learn to use Prisma Client for basic database operations.
 *
 * Learning objectives:
 * - Initialize and connect Prisma Client
 * - Perform basic findMany and findUnique queries
 * - Use select to limit returned fields
 * - Disconnect properly
 */

import { PrismaClient } from "@prisma/client";

// Initialize Prisma Client
const prisma = new PrismaClient({
  log: ["query", "info", "warn", "error"], // Enable logging to see SQL
});

async function main() {
  console.log("=".repeat(50));
  console.log("Lesson 1: Prisma Basics");
  console.log("=".repeat(50));

  // 1. Test connection
  console.log("\n📡 Testing database connection...");
  await prisma.$connect();
  console.log("✅ Connected to PostgreSQL!");

  // 2. Query all authors
  console.log("\n👤 All Authors:");
  const authors = await prisma.author.findMany({
    orderBy: { name: "asc" },
  });

  for (const author of authors) {
    console.log(`   ${author.name} (born ${author.birthYear || "unknown"})`);
  }

  // 3. Find a specific author
  console.log("\n🔍 Finding J.K. Rowling:");
  const jkRowling = await prisma.author.findFirst({
    where: {
      name: {
        contains: "Rowling",
      },
    },
  });

  if (jkRowling) {
    console.log(`   Found: ${jkRowling.name}`);
    console.log(`   Email: ${jkRowling.email}`);
    console.log(`   Bio: ${jkRowling.bio}`);
  }

  // 4. Query with select (choose specific fields)
  console.log("\n📚 Books (title and price only):");
  const books = await prisma.book.findMany({
    select: {
      title: true,
      price: true,
    },
    take: 5,
    orderBy: { title: "asc" },
  });

  for (const book of books) {
    console.log(`   ${book.title} - $${book.price}`);
  }

  // 5. Count records
  console.log("\n📊 Database Statistics:");
  const [authorCount, bookCount, customerCount, orderCount] = await Promise.all(
    [
      prisma.author.count(),
      prisma.book.count(),
      prisma.customer.count(),
      prisma.order.count(),
    ]
  );

  console.log(`   Authors: ${authorCount}`);
  console.log(`   Books: ${bookCount}`);
  console.log(`   Customers: ${customerCount}`);
  console.log(`   Orders: ${orderCount}`);

  // 6. Using findUnique
  console.log("\n🔎 Find book by ISBN:");
  const book1984 = await prisma.book.findUnique({
    where: {
      isbn: "978-0451524935",
    },
    select: {
      title: true,
      price: true,
      stockQuantity: true,
    },
  });

  if (book1984) {
    console.log(`   Title: ${book1984.title}`);
    console.log(`   Price: $${book1984.price}`);
    console.log(`   In Stock: ${book1984.stockQuantity}`);
  }
}

main()
  .then(async () => {
    console.log("\n" + "=".repeat(50));
    console.log("🎉 Lesson 1 Complete!");
    console.log("=".repeat(50));
    console.log("\nNext: Run `pnpm lesson:crud` for CRUD operations");
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error("❌ Error:", e);
    await prisma.$disconnect();
    process.exit(1);
  });
