/**
 * Lesson 3: Working with Relations in Prisma
 * ===========================================
 * Learn to query and manipulate related data.
 *
 * Learning objectives:
 * - Include related data in queries
 * - Filter based on relations
 * - Create connected records
 * - Navigate relationships
 */

import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function includeRelations() {
  console.log("=".repeat(50));
  console.log("Including Related Data");
  console.log("=".repeat(50));

  // 1. Include one-to-many relation
  console.log("\n📚 Authors with their books:");

  const authorsWithBooks = await prisma.author.findMany({
    include: {
      books: {
        select: {
          title: true,
          price: true,
        },
      },
    },
    take: 3,
  });

  for (const author of authorsWithBooks) {
    console.log(`\n   👤 ${author.name}`);
    if (author.books.length === 0) {
      console.log("      No books yet");
    } else {
      for (const book of author.books) {
        console.log(`      📖 ${book.title} - $${book.price}`);
      }
    }
  }

  // 2. Nested includes (deep relations)
  console.log("\n\n📦 Orders with customer and book details:");

  const ordersWithDetails = await prisma.order.findMany({
    include: {
      customer: {
        select: {
          firstName: true,
          lastName: true,
        },
      },
      items: {
        include: {
          book: {
            select: {
              title: true,
            },
          },
        },
      },
    },
    take: 3,
  });

  for (const order of ordersWithDetails) {
    const customerName = order.customer
      ? `${order.customer.firstName} ${order.customer.lastName}`
      : "Unknown";

    console.log(`\n   Order #${order.id} by ${customerName}`);
    console.log(`   Status: ${order.status} | Total: $${order.totalAmount}`);
    console.log("   Items:");

    for (const item of order.items) {
      console.log(
        `      - ${item.book?.title || "Unknown"} (qty: ${item.quantity})`
      );
    }
  }
}

async function filterByRelations() {
  console.log("\n" + "=".repeat(50));
  console.log("Filtering by Relations");
  console.log("=".repeat(50));

  // 1. Find authors who have books
  console.log("\n👤 Authors with at least one book:");

  const authorsWithBooks = await prisma.author.findMany({
    where: {
      books: {
        some: {},
      },
    },
    include: {
      _count: {
        select: { books: true },
      },
    },
  });

  for (const author of authorsWithBooks) {
    console.log(`   ${author.name}: ${author._count.books} book(s)`);
  }

  // 2. Find books by authors born before 1900
  console.log("\n📚 Books by authors born before 1900:");

  const classicBooks = await prisma.book.findMany({
    where: {
      author: {
        birthYear: {
          lt: 1900,
        },
      },
    },
    include: {
      author: {
        select: { name: true, birthYear: true },
      },
    },
  });

  for (const book of classicBooks) {
    console.log(`   ${book.title}`);
    console.log(`      by ${book.author?.name} (${book.author?.birthYear})`);
  }

  // 3. Find customers with high-value orders
  console.log("\n💰 Customers with orders over $25:");

  const bigSpenders = await prisma.customer.findMany({
    where: {
      orders: {
        some: {
          totalAmount: {
            gt: 25,
          },
        },
      },
    },
    include: {
      orders: {
        where: {
          totalAmount: { gt: 25 },
        },
        select: {
          id: true,
          totalAmount: true,
          status: true,
        },
      },
    },
  });

  for (const customer of bigSpenders) {
    console.log(`\n   ${customer.firstName} ${customer.lastName}`);
    for (const order of customer.orders) {
      console.log(`      Order #${order.id}: $${order.totalAmount} (${order.status})`);
    }
  }
}

async function aggregateRelations() {
  console.log("\n" + "=".repeat(50));
  console.log("Aggregating Related Data");
  console.log("=".repeat(50));

  // 1. Count related records
  console.log("\n📊 Category statistics:");

  const categoryStats = await prisma.category.findMany({
    include: {
      _count: {
        select: { books: true },
      },
    },
  });

  for (const cat of categoryStats) {
    console.log(`   ${cat.name}: ${cat._count.books} books`);
  }

  // 2. Aggregate book prices by category
  console.log("\n💵 Average book price by category:");

  const categories = await prisma.category.findMany({
    include: {
      books: {
        select: { price: true },
      },
    },
  });

  for (const cat of categories) {
    if (cat.books.length > 0) {
      const prices = cat.books.map((b) => Number(b.price));
      const avg = prices.reduce((a, b) => a + b, 0) / prices.length;
      console.log(`   ${cat.name}: $${avg.toFixed(2)} avg`);
    }
  }

  // 3. Find top-rated books
  console.log("\n⭐ Books with reviews (avg rating):");

  const booksWithReviews = await prisma.book.findMany({
    where: {
      reviews: {
        some: {},
      },
    },
    include: {
      reviews: {
        select: { rating: true },
      },
    },
  });

  for (const book of booksWithReviews) {
    const ratings = book.reviews.map((r) => r.rating);
    const avgRating = ratings.reduce((a, b) => a + b, 0) / ratings.length;
    console.log(`   ${book.title}: ${avgRating.toFixed(1)}/5 (${ratings.length} reviews)`);
  }
}

async function createWithRelations() {
  console.log("\n" + "=".repeat(50));
  console.log("Creating Connected Records");
  console.log("=".repeat(50));

  // Create an order with items using nested create
  console.log("\n🛒 Creating an order with items...");

  // First, get a customer and some books
  const customer = await prisma.customer.findFirst();
  const books = await prisma.book.findMany({ take: 2 });

  if (customer && books.length >= 2) {
    const order = await prisma.order.create({
      data: {
        customerId: customer.id,
        status: "pending",
        totalAmount: Number(books[0].price) + Number(books[1].price),
        items: {
          create: [
            {
              bookId: books[0].id,
              quantity: 1,
              priceAtPurchase: books[0].price,
            },
            {
              bookId: books[1].id,
              quantity: 1,
              priceAtPurchase: books[1].price,
            },
          ],
        },
      },
      include: {
        customer: {
          select: { firstName: true, lastName: true },
        },
        items: {
          include: {
            book: {
              select: { title: true },
            },
          },
        },
      },
    });

    console.log(`   ✅ Created Order #${order.id}`);
    console.log(`   Customer: ${order.customer?.firstName} ${order.customer?.lastName}`);
    console.log(`   Items:`);
    for (const item of order.items) {
      console.log(`      - ${item.book?.title}`);
    }

    // Clean up - delete the test order
    await prisma.order.delete({ where: { id: order.id } });
    console.log(`   🗑️ (Test order cleaned up)`);
  }
}

async function main() {
  try {
    await includeRelations();
    await filterByRelations();
    await aggregateRelations();
    await createWithRelations();
  } catch (error) {
    console.error("❌ Error:", error);
  }
}

main()
  .then(async () => {
    console.log("\n" + "=".repeat(50));
    console.log("🎉 Lesson 3 Complete!");
    console.log("=".repeat(50));
    console.log("\nKey takeaways:");
    console.log("  ✓ Use 'include' to fetch related records");
    console.log("  ✓ Use 'select' within includes for specific fields");
    console.log("  ✓ Filter with 'some', 'every', 'none' for relations");
    console.log("  ✓ Use '_count' for efficient counting");
    console.log("  ✓ Nested 'create' for connected records");
    console.log("\n🚀 Try `pnpm prisma:studio` to explore data visually!");
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
