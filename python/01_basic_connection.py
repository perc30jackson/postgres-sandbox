"""
Lesson 1: Basic PostgreSQL Connection with psycopg2
====================================================
This script demonstrates how to connect to PostgreSQL using psycopg2,
the most popular PostgreSQL adapter for Python.

Learning objectives:
- Connect to a PostgreSQL database
- Execute basic queries
- Handle connections properly with context managers
"""

import psycopg2
from psycopg2 import sql

# Database connection parameters
DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "learning_db",
    "user": "learner",
    "password": "learnpass123"
}


def basic_connection():
    """Demonstrate basic database connection and query."""
    print("=" * 50)
    print("Lesson 1: Basic Connection")
    print("=" * 50)
    
    # Method 1: Using connection string
    connection_string = "postgresql://learner:learnpass123@localhost:5432/learning_db"
    
    try:
        # Connect to the database
        conn = psycopg2.connect(connection_string)
        print("✅ Successfully connected to PostgreSQL!")
        
        # Create a cursor to execute queries
        cursor = conn.cursor()
        
        # Execute a simple query
        cursor.execute("SELECT version();")
        version = cursor.fetchone()[0]
        print(f"\n📦 PostgreSQL Version:\n{version}")
        
        # Clean up
        cursor.close()
        conn.close()
        print("\n🔒 Connection closed properly.")
        
    except psycopg2.Error as e:
        print(f"❌ Error connecting to PostgreSQL: {e}")


def connection_with_context_manager():
    """Use context managers for automatic resource cleanup."""
    print("\n" + "=" * 50)
    print("Using Context Managers (Recommended)")
    print("=" * 50)
    
    try:
        # Context manager automatically handles connection closing
        with psycopg2.connect(**DB_CONFIG) as conn:
            with conn.cursor() as cursor:
                # Get current database and user
                cursor.execute("SELECT current_database(), current_user;")
                db_name, user = cursor.fetchone()
                print(f"\n📊 Connected to: {db_name}")
                print(f"👤 As user: {user}")
                
                # List all tables
                cursor.execute("""
                    SELECT table_name 
                    FROM information_schema.tables 
                    WHERE table_schema = 'public'
                    AND table_type = 'BASE TABLE'
                    ORDER BY table_name;
                """)
                
                tables = cursor.fetchall()
                print(f"\n📋 Tables in database ({len(tables)}):")
                for table in tables:
                    print(f"   • {table[0]}")
                    
        print("\n✅ Connection automatically closed by context manager!")
        
    except psycopg2.Error as e:
        print(f"❌ Database error: {e}")


def query_sample_data():
    """Query and display sample data from our bookstore database."""
    print("\n" + "=" * 50)
    print("Querying Sample Data")
    print("=" * 50)
    
    try:
        with psycopg2.connect(**DB_CONFIG) as conn:
            with conn.cursor() as cursor:
                # Query books with author names
                cursor.execute("""
                    SELECT b.title, a.name as author, b.price
                    FROM books b
                    JOIN authors a ON b.author_id = a.id
                    ORDER BY b.title
                    LIMIT 5;
                """)
                
                books = cursor.fetchall()
                print("\n📚 Sample Books:")
                print("-" * 60)
                for title, author, price in books:
                    print(f"   {title}")
                    print(f"      by {author} - ${price:.2f}")
                    print()
                    
    except psycopg2.Error as e:
        print(f"❌ Error: {e}")


if __name__ == "__main__":
    basic_connection()
    connection_with_context_manager()
    query_sample_data()
    
    print("\n" + "=" * 50)
    print("🎉 Lesson 1 Complete!")
    print("=" * 50)
    print("\nNext steps:")
    print("  → Run 02_crud_operations.py to learn CRUD operations")
    print("  → Run 03_sqlalchemy_intro.py to learn SQLAlchemy ORM")
