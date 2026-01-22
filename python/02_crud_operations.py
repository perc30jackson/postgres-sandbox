"""
Lesson 2: CRUD Operations with psycopg2
========================================
Learn Create, Read, Update, Delete operations with PostgreSQL.

Learning objectives:
- INSERT data into tables
- SELECT with various conditions
- UPDATE existing records
- DELETE records safely
- Use parameterized queries to prevent SQL injection

How to run:
  Windows:  python 02_crud_operations.py
  macOS:    python3 02_crud_operations.py
"""

import psycopg2
from psycopg2 import sql
from datetime import date

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "learning_db",
    "user": "learner",
    "password": "learnpass123"
}


def create_author():
    """CREATE: Insert a new author into the database."""
    print("=" * 50)
    print("CREATE: Adding a New Author")
    print("=" * 50)
    
    new_author = {
        "name": "Isaac Asimov",
        "email": "asimov@example.com",
        "bio": "American writer and professor of biochemistry, known for science fiction.",
        "birth_year": 1920
    }
    
    try:
        with psycopg2.connect(**DB_CONFIG) as conn:
            with conn.cursor() as cursor:
                # IMPORTANT: Always use parameterized queries!
                # Never use string formatting with user input (SQL injection risk)
                
                cursor.execute("""
                    INSERT INTO authors (name, email, bio, birth_year)
                    VALUES (%s, %s, %s, %s)
                    ON CONFLICT (email) DO NOTHING
                    RETURNING id, name;
                """, (new_author["name"], new_author["email"], 
                      new_author["bio"], new_author["birth_year"]))
                
                result = cursor.fetchone()
                
                if result:
                    print(f"\n✅ Created author: {result[1]} (ID: {result[0]})")
                else:
                    print(f"\n⚠️ Author already exists: {new_author['name']}")
                    
                # Commit the transaction
                conn.commit()
                
    except psycopg2.Error as e:
        print(f"❌ Error: {e}")


def read_books():
    """READ: Various ways to query data."""
    print("\n" + "=" * 50)
    print("READ: Querying Data")
    print("=" * 50)
    
    try:
        with psycopg2.connect(**DB_CONFIG) as conn:
            with conn.cursor() as cursor:
                
                # 1. Simple SELECT
                print("\n📖 All Books (Simple Query):")
                cursor.execute("SELECT id, title, price FROM books ORDER BY title;")
                for book in cursor.fetchall():
                    print(f"   [{book[0]}] {book[1]} - ${book[2]}")
                
                # 2. SELECT with WHERE clause
                print("\n📖 Books under $15:")
                cursor.execute("""
                    SELECT title, price 
                    FROM books 
                    WHERE price < %s 
                    ORDER BY price;
                """, (15.00,))
                for book in cursor.fetchall():
                    print(f"   {book[0]} - ${book[1]}")
                
                # 3. SELECT with JOIN
                print("\n📖 Mystery Books with Authors:")
                cursor.execute("""
                    SELECT b.title, a.name as author
                    FROM books b
                    JOIN authors a ON b.author_id = a.id
                    JOIN categories c ON b.category_id = c.id
                    WHERE c.name = %s;
                """, ("Mystery",))
                for book in cursor.fetchall():
                    print(f"   {book[0]} by {book[1]}")
                
                # 4. Aggregate functions
                print("\n📊 Category Statistics:")
                cursor.execute("""
                    SELECT c.name, 
                           COUNT(b.id) as book_count,
                           ROUND(AVG(b.price)::numeric, 2) as avg_price
                    FROM categories c
                    LEFT JOIN books b ON c.id = b.category_id
                    GROUP BY c.name
                    ORDER BY book_count DESC;
                """)
                for row in cursor.fetchall():
                    print(f"   {row[0]}: {row[1]} books, avg ${row[2] or 0}")
                    
    except psycopg2.Error as e:
        print(f"❌ Error: {e}")


def update_book_price():
    """UPDATE: Modify existing records."""
    print("\n" + "=" * 50)
    print("UPDATE: Modifying Records")
    print("=" * 50)
    
    try:
        with psycopg2.connect(**DB_CONFIG) as conn:
            with conn.cursor() as cursor:
                
                # Get current price first
                book_title = "1984"
                cursor.execute(
                    "SELECT id, title, price FROM books WHERE title = %s;",
                    (book_title,)
                )
                book = cursor.fetchone()
                
                if book:
                    old_price = book[2]
                    new_price = float(old_price) * 1.10  # 10% increase
                    
                    print(f"\n📚 Book: {book[1]}")
                    print(f"   Current price: ${old_price}")
                    print(f"   New price (10% increase): ${new_price:.2f}")
                    
                    # Update the price
                    cursor.execute("""
                        UPDATE books 
                        SET price = %s, updated_at = CURRENT_TIMESTAMP
                        WHERE id = %s
                        RETURNING id, title, price;
                    """, (new_price, book[0]))
                    
                    updated = cursor.fetchone()
                    conn.commit()
                    
                    print(f"\n✅ Updated! New price: ${updated[2]}")
                else:
                    print(f"❌ Book not found: {book_title}")
                    
    except psycopg2.Error as e:
        print(f"❌ Error: {e}")


def delete_demonstration():
    """DELETE: Remove records (with safety considerations)."""
    print("\n" + "=" * 50)
    print("DELETE: Removing Records (Demo)")
    print("=" * 50)
    
    try:
        with psycopg2.connect(**DB_CONFIG) as conn:
            with conn.cursor() as cursor:
                
                # First, let's create a temporary record to delete
                cursor.execute("""
                    INSERT INTO categories (name, description)
                    VALUES ('Temporary', 'This category will be deleted')
                    ON CONFLICT (name) DO NOTHING
                    RETURNING id, name;
                """)
                
                result = cursor.fetchone()
                if result:
                    temp_id = result[0]
                    print(f"\n✅ Created temporary category: {result[1]} (ID: {temp_id})")
                    
                    # Now delete it
                    cursor.execute("""
                        DELETE FROM categories 
                        WHERE id = %s
                        RETURNING id, name;
                    """, (temp_id,))
                    
                    deleted = cursor.fetchone()
                    print(f"🗑️ Deleted category: {deleted[1]} (ID: {deleted[0]})")
                else:
                    # Already exists, fetch and delete it
                    cursor.execute("SELECT id FROM categories WHERE name = 'Temporary';")
                    temp = cursor.fetchone()
                    if temp:
                        cursor.execute("DELETE FROM categories WHERE id = %s RETURNING name;", (temp[0],))
                        print(f"🗑️ Deleted existing temporary category")
                
                conn.commit()
                
                # Show remaining categories
                print("\n📋 Remaining Categories:")
                cursor.execute("SELECT name FROM categories ORDER BY name;")
                for cat in cursor.fetchall():
                    print(f"   • {cat[0]}")
                    
    except psycopg2.Error as e:
        print(f"❌ Error: {e}")


def batch_operations():
    """Demonstrate batch insert operations."""
    print("\n" + "=" * 50)
    print("BATCH: Multiple Records")
    print("=" * 50)
    
    new_customers = [
        ("Frank", "Miller", "frank@example.com", "555-0201"),
        ("Grace", "Lee", "grace@example.com", "555-0202"),
        ("Henry", "Wilson", "henry@example.com", "555-0203"),
    ]
    
    try:
        with psycopg2.connect(**DB_CONFIG) as conn:
            with conn.cursor() as cursor:
                
                # executemany for batch inserts
                cursor.executemany("""
                    INSERT INTO customers (first_name, last_name, email, phone)
                    VALUES (%s, %s, %s, %s)
                    ON CONFLICT (email) DO NOTHING;
                """, new_customers)
                
                inserted_count = cursor.rowcount
                conn.commit()
                
                print(f"\n✅ Batch insert completed!")
                print(f"   Rows affected: {inserted_count}")
                
                # Verify
                cursor.execute("SELECT first_name, last_name FROM customers ORDER BY id DESC LIMIT 5;")
                print("\n👥 Recent customers:")
                for cust in cursor.fetchall():
                    print(f"   • {cust[0]} {cust[1]}")
                    
    except psycopg2.Error as e:
        print(f"❌ Error: {e}")


if __name__ == "__main__":
    create_author()
    read_books()
    update_book_price()
    delete_demonstration()
    batch_operations()
    
    print("\n" + "=" * 50)
    print("🎉 Lesson 2 Complete!")
    print("=" * 50)
    print("\nKey takeaways:")
    print("  ✓ Always use parameterized queries (%s placeholders)")
    print("  ✓ Use RETURNING to get affected rows")
    print("  ✓ Remember to commit() after modifications")
    print("  ✓ Use ON CONFLICT for upsert operations")
    print("\nNext: Run 03_sqlalchemy_intro.py to learn SQLAlchemy ORM")
