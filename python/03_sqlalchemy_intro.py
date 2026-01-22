"""
Lesson 3: SQLAlchemy ORM Introduction
=====================================
Learn to use SQLAlchemy, Python's most popular ORM.

Learning objectives:
- Set up SQLAlchemy engine and session
- Define models with declarative base
- Perform CRUD operations using ORM
- Understand relationships between models

How to run:
  Windows:  python 03_sqlalchemy_intro.py
  macOS:    python3 03_sqlalchemy_intro.py
"""

from sqlalchemy import create_engine, Column, Integer, String, Float, ForeignKey, DateTime, Text
from sqlalchemy.orm import declarative_base, sessionmaker, relationship
from sqlalchemy.sql import func
from datetime import datetime

# Database URL
DATABASE_URL = "postgresql://learner:learnpass123@localhost:5432/learning_db"

# Create engine
engine = create_engine(DATABASE_URL, echo=False)  # Set echo=True to see SQL queries

# Create session factory
SessionLocal = sessionmaker(bind=engine)

# Base class for models
Base = declarative_base()


# ==============================================
# Model Definitions
# ==============================================

class Author(Base):
    """Author model mapped to the authors table."""
    __tablename__ = "authors"
    
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable=False)
    email = Column(String(150), unique=True)
    bio = Column(Text)
    birth_year = Column(Integer)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    
    # Relationship to books
    books = relationship("Book", back_populates="author")
    
    def __repr__(self):
        return f"<Author(id={self.id}, name='{self.name}')>"


class Category(Base):
    """Category model mapped to the categories table."""
    __tablename__ = "categories"
    
    id = Column(Integer, primary_key=True)
    name = Column(String(50), nullable=False, unique=True)
    description = Column(Text)
    
    # Relationship to books
    books = relationship("Book", back_populates="category")
    
    def __repr__(self):
        return f"<Category(id={self.id}, name='{self.name}')>"


class Book(Base):
    """Book model mapped to the books table."""
    __tablename__ = "books"
    
    id = Column(Integer, primary_key=True)
    title = Column(String(200), nullable=False)
    isbn = Column(String(20), unique=True)
    author_id = Column(Integer, ForeignKey("authors.id"))
    category_id = Column(Integer, ForeignKey("categories.id"))
    price = Column(Float, default=0.00)
    stock_quantity = Column(Integer, default=0)
    description = Column(Text)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    
    # Relationships
    author = relationship("Author", back_populates="books")
    category = relationship("Category", back_populates="books")
    
    def __repr__(self):
        return f"<Book(id={self.id}, title='{self.title}')>"


# ==============================================
# Demonstrations
# ==============================================

def query_with_orm():
    """Demonstrate querying data with SQLAlchemy ORM."""
    print("=" * 50)
    print("SQLAlchemy ORM: Querying Data")
    print("=" * 50)
    
    # Create a session
    session = SessionLocal()
    
    try:
        # 1. Get all authors
        print("\n👤 All Authors:")
        authors = session.query(Author).all()
        for author in authors:
            print(f"   {author.name} (born {author.birth_year})")
        
        # 2. Filter with conditions
        print("\n📚 Books priced under $15:")
        cheap_books = session.query(Book).filter(Book.price < 15).order_by(Book.price).all()
        for book in cheap_books:
            print(f"   {book.title} - ${book.price:.2f}")
        
        # 3. Query with relationships (eager loading)
        print("\n📖 Books with Author Details:")
        books = session.query(Book).limit(5).all()
        for book in books:
            author_name = book.author.name if book.author else "Unknown"
            category = book.category.name if book.category else "Uncategorized"
            print(f"   {book.title}")
            print(f"      Author: {author_name} | Category: {category}")
        
        # 4. Aggregate queries
        print("\n📊 Books per Author:")
        for author in session.query(Author).all():
            book_count = len(author.books)
            print(f"   {author.name}: {book_count} book(s)")
            
    finally:
        session.close()


def create_with_orm():
    """Demonstrate creating records with SQLAlchemy ORM."""
    print("\n" + "=" * 50)
    print("SQLAlchemy ORM: Creating Records")
    print("=" * 50)
    
    session = SessionLocal()
    
    try:
        # Check if author already exists
        existing = session.query(Author).filter(Author.email == "verne@example.com").first()
        
        if existing:
            print(f"\n⚠️ Author already exists: {existing.name}")
        else:
            # Create a new author
            new_author = Author(
                name="Jules Verne",
                email="verne@example.com",
                bio="French novelist, poet, and playwright.",
                birth_year=1828
            )
            
            session.add(new_author)
            session.commit()
            
            print(f"\n✅ Created: {new_author}")
            print(f"   ID assigned: {new_author.id}")
        
        # Verify
        print("\n📋 Authors after insert:")
        for author in session.query(Author).order_by(Author.name).all():
            print(f"   {author.id}. {author.name}")
            
    except Exception as e:
        session.rollback()
        print(f"❌ Error: {e}")
    finally:
        session.close()


def update_with_orm():
    """Demonstrate updating records with SQLAlchemy ORM."""
    print("\n" + "=" * 50)
    print("SQLAlchemy ORM: Updating Records")
    print("=" * 50)
    
    session = SessionLocal()
    
    try:
        # Find a book to update
        book = session.query(Book).filter(Book.title == "1984").first()
        
        if book:
            old_stock = book.stock_quantity
            book.stock_quantity = old_stock + 10
            
            session.commit()
            
            print(f"\n📚 Updated: {book.title}")
            print(f"   Stock: {old_stock} → {book.stock_quantity}")
        else:
            print("❌ Book not found")
            
    except Exception as e:
        session.rollback()
        print(f"❌ Error: {e}")
    finally:
        session.close()


def relationships_demo():
    """Demonstrate relationship navigation."""
    print("\n" + "=" * 50)
    print("SQLAlchemy ORM: Relationships")
    print("=" * 50)
    
    session = SessionLocal()
    
    try:
        # Get an author and explore their books
        author = session.query(Author).filter(Author.name.like("%Agatha%")).first()
        
        if author:
            print(f"\n🔍 Author: {author.name}")
            print(f"   Bio: {author.bio}")
            print(f"\n   Books by this author:")
            
            for book in author.books:
                category_name = book.category.name if book.category else "Unknown"
                print(f"      • {book.title} ({category_name}) - ${book.price:.2f}")
        
        # Get a category and list its books
        category = session.query(Category).filter(Category.name == "Fiction").first()
        
        if category:
            print(f"\n📂 Category: {category.name}")
            print(f"   Description: {category.description}")
            print(f"\n   Books in this category:")
            
            for book in category.books:
                author_name = book.author.name if book.author else "Unknown"
                print(f"      • {book.title} by {author_name}")
                
    finally:
        session.close()


def advanced_queries():
    """Demonstrate advanced query techniques."""
    print("\n" + "=" * 50)
    print("SQLAlchemy ORM: Advanced Queries")
    print("=" * 50)
    
    session = SessionLocal()
    
    try:
        from sqlalchemy import func, desc
        
        # 1. Aggregate with GROUP BY
        print("\n📊 Category Statistics:")
        stats = session.query(
            Category.name,
            func.count(Book.id).label("book_count"),
            func.round(func.avg(Book.price), 2).label("avg_price")
        ).outerjoin(Book).group_by(Category.name).all()
        
        for name, count, avg_price in stats:
            print(f"   {name}: {count} books, avg ${avg_price or 0}")
        
        # 2. Subquery example
        print("\n💰 Authors with expensive books (>$15):")
        expensive_authors = session.query(Author).join(Book).filter(Book.price > 15).distinct().all()
        
        for author in expensive_authors:
            max_price = max(b.price for b in author.books)
            print(f"   {author.name} (highest: ${max_price:.2f})")
        
        # 3. Order and limit
        print("\n🔝 Top 3 Most Expensive Books:")
        top_books = session.query(Book).order_by(desc(Book.price)).limit(3).all()
        
        for i, book in enumerate(top_books, 1):
            print(f"   {i}. {book.title} - ${book.price:.2f}")
            
    finally:
        session.close()


if __name__ == "__main__":
    print("🐍 SQLAlchemy ORM Tutorial")
    print("=" * 50)
    
    query_with_orm()
    create_with_orm()
    update_with_orm()
    relationships_demo()
    advanced_queries()
    
    print("\n" + "=" * 50)
    print("🎉 Lesson 3 Complete!")
    print("=" * 50)
    print("\nKey takeaways:")
    print("  ✓ Use declarative_base for model definitions")
    print("  ✓ Sessions manage database transactions")
    print("  ✓ relationship() enables easy navigation")
    print("  ✓ Always close sessions (use try/finally)")
    print("\n💡 Next steps:")
    print("   → Try the Prisma examples for a Node.js/TypeScript approach")
