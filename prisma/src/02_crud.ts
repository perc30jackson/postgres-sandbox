/**
 * Lesson 2: CRUD Operations with Prisma
 * ======================================
 * Learn Create, Read, Update, Delete operations.
 *
 * Learning objectives:
 * - Create single and multiple records
 * - Read with filters, ordering, and pagination
 * - Update records with various methods
 * - Delete records safely
 */

import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function createOperations() {
  console.log("=".repeat(50));
  console.log("CREATE Operations");
  console.log("=".repeat(50));

  // 1. Create a single record
  console.log("\n📝 Creating a new author...");

  const newAuthor = await prisma.author.upsert({
    where: { email: "tolkien@example.com" },
    update: {}, // No updates if exists
    create: {
      name: "J.R.R. Tolkien",
      email: "tolkien@example.com",
      bio: "English writer and philologist, author of The Hobbit and The Lord of the Rings.",
      birthYear: 1892,
    },
  });

  console.log(`   ✅ Author: ${newAuthor.name} (ID: ${newAuthor.id})`);

  // 2. Create multiple records
  console.log("\n📝 Creating multiple categories...");

  const categories = await prisma.category.createMany({
    data: [
      { name: "Biography", description: "Life stories of real people" },
      { name: "History", description: "Books about historical events" },
      { name: "Self-Help", description: "Personal development books" },
    ],
    skipDuplicates: true, // Ignore if already exists
  });

  console.log(`   ✅ Created ${categories.count} new categories`);

  // 3. Create with relation
  console.log("\n📝 Creating a book with author connection...");

  // First, find Tolkien
  const tolkien = await prisma.author.findUnique({
    where: { email: "tolkien@example.com" },
  });

  if (tolkien) {
    const newBook = await prisma.book.upsert({
      where: { isbn: "978-0547928227" },
      update: {},
      create: {
        title: "The Hobbit",
        isbn: "978-0547928227",
        price: 18.99,
        stockQuantity: 25,
        description: "A fantasy novel about Bilbo Baggins.",
        authorId: tolkien.id,
        categoryId: 1, // Fiction
      },
    });

    console.log(`   ✅ Book: ${newBook.title}`);
  }
}

async function readOperations() {
  console.log("\n" + "=".repeat(50));
  console.log("READ Operations");
  console.log("=".repeat(50));

  // 1. Find with filters
  console.log("\n📖 Books under $15:");
  const cheapBooks = await prisma.book.findMany({
    where: {
      price: {
        lt: 15,
      },
    },
    orderBy: { price: "asc" },
  });

  for (const book of cheapBooks) {
    console.log(`   ${book.title} - $${book.price}`);
  }

  // 2. Find with multiple conditions (AND/OR)
  console.log("\n📖 Fiction OR Mystery books:");
  const fictionOrMystery = await prisma.book.findMany({
    where: {
      OR: [{ categoryId: 1 }, { categoryId: 3 }],
    },
    select: {
      title: true,
      category: {
        select: { name: true },
      },
    },
  });

  for (const book of fictionOrMystery) {
    console.log(`   ${book.title} (${book.category?.name})`);
  }

  // 3. Pagination
  console.log("\n📖 Books (page 1, 3 per page):");
  const page1 = await prisma.book.findMany({
    take: 3,
    skip: 0,
    orderBy: { title: "asc" },
    select: { title: true },
  });

  for (const book of page1) {
    console.log(`   ${book.title}`);
  }

  // 4. String search
  console.log("\n🔍 Search titles containing 'the':");
  const searchResults = await prisma.book.findMany({
    where: {
      title: {
        contains: "the",
        mode: "insensitive",
      },
    },
    select: { title: true },
  });

  for (const book of searchResults) {
    console.log(`   ${book.title}`);
  }
}

async function updateOperations() {
  console.log("\n" + "=".repeat(50));
  console.log("UPDATE Operations");
  console.log("=".repeat(50));

  // 1. Update single record
  console.log("\n✏️ Updating book stock...");

  const book = await prisma.book.findFirst({
    where: { title: "1984" },
  });

  if (book) {
    const updated = await prisma.book.update({
      where: { id: book.id },
      data: {
        stockQuantity: {
          increment: 5, // Add 5 to current stock
        },
      },
    });

    console.log(`   ${updated.title}: stock now ${updated.stockQuantity}`);
  }

  // 2. Update many records
  console.log("\n✏️ Applying 5% discount to all Mystery books...");

  const discounted = await prisma.book.updateMany({
    where: { categoryId: 3 },
    data: {
      price: {
        multiply: 0.95,
      },
    },
  });

  console.log(`   ✅ Updated ${discounted.count} books`);

  // 3. Upsert (update or create)
  console.log("\n✏️ Upsert customer...");

  const customer = await prisma.customer.upsert({
    where: { email: "newuser@example.com" },
    update: {
      phone: "555-9999",
    },
    create: {
      firstName: "New",
      lastName: "User",
      email: "newuser@example.com",
      phone: "555-9999",
    },
  });

  console.log(`   ✅ Customer: ${customer.firstName} ${customer.lastName}`);
}

async function deleteOperations() {
  console.log("\n" + "=".repeat(50));
  console.log("DELETE Operations");
  console.log("=".repeat(50));

  // 1. Delete single record
  console.log("\n🗑️ Deleting test customer...");

  try {
    const deleted = await prisma.customer.delete({
      where: { email: "newuser@example.com" },
    });
    console.log(`   ✅ Deleted: ${deleted.firstName} ${deleted.lastName}`);
  } catch (e) {
    console.log("   ⚠️ Customer not found (already deleted)");
  }

  // 2. Delete many (demonstration - we'll create and delete temp records)
  console.log("\n🗑️ Cleaning up test categories...");

  const deleted = await prisma.category.deleteMany({
    where: {
      name: {
        in: ["Biography", "History", "Self-Help"],
      },
    },
  });

  console.log(`   ✅ Deleted ${deleted.count} categories`);
}

async function main() {
  try {
    await createOperations();
    await readOperations();
    await updateOperations();
    await deleteOperations();
  } catch (error) {
    console.error("❌ Error:", error);
  }
}

main()
  .then(async () => {
    console.log("\n" + "=".repeat(50));
    console.log("🎉 Lesson 2 Complete!");
    console.log("=".repeat(50));
    console.log("\nKey takeaways:");
    console.log("  ✓ Use upsert for create-or-update logic");
    console.log("  ✓ createMany with skipDuplicates for bulk inserts");
    console.log("  ✓ increment/decrement/multiply for numeric updates");
    console.log("  ✓ updateMany for batch updates");
    console.log("\nNext: Run `pnpm lesson:relations` for relationships");
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
