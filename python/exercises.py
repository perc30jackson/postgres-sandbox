"""
PostgreSQL Practice Exercises
=============================
Complete these exercises to test your understanding!
Each exercise has a description and a placeholder function.
Fill in the function body to solve the exercise.

Run this file to check your answers:
    python exercises.py
"""

import psycopg2
from typing import List, Tuple, Optional

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "learning_db",
    "user": "learner",
    "password": "learnpass123"
}


# ==============================================
# EXERCISE 1: Basic Query
# ==============================================
def exercise_1_get_all_categories() -> List[str]:
    """
    Return a list of all category names, sorted alphabetically.
    
    Expected output format: ['Fiction', 'Mystery', 'Non-Fiction', ...]
    """
    # YOUR CODE HERE
    pass


# ==============================================
# EXERCISE 2: Filtering
# ==============================================
def exercise_2_get_expensive_books(min_price: float) -> List[Tuple[str, float]]:
    """
    Return books with price >= min_price.
    Return as list of tuples: (title, price)
    Order by price descending.
    
    Example: exercise_2_get_expensive_books(15.00)
    Expected: [('Harry Potter...', 24.99), ('Murder on...', 16.99), ...]
    """
    # YOUR CODE HERE
    pass


# ==============================================
# EXERCISE 3: Joins
# ==============================================
def exercise_3_get_books_by_author(author_name: str) -> List[str]:
    """
    Return all book titles by an author whose name contains the given string.
    Case-insensitive search.
    
    Example: exercise_3_get_books_by_author('Agatha')
    Expected: ['Murder on the Orient Express', 'And Then There Were None']
    """
    # YOUR CODE HERE
    pass


# ==============================================
# EXERCISE 4: Aggregation
# ==============================================
def exercise_4_get_author_book_counts() -> List[Tuple[str, int]]:
    """
    Return each author's name and their total book count.
    Only include authors with at least 1 book.
    Order by book count descending, then by name.
    
    Expected: [('Agatha Christie', 2), ('George Orwell', 2), ...]
    """
    # YOUR CODE HERE
    pass


# ==============================================
# EXERCISE 5: Insert
# ==============================================
def exercise_5_add_review(book_title: str, customer_email: str, 
                          rating: int, comment: str) -> Optional[int]:
    """
    Add a review for a book from a customer.
    Return the new review ID, or None if book/customer not found.
    Handle the case where a review already exists (return None).
    
    Example: exercise_5_add_review('1984', 'alice@example.com', 5, 'Great!')
    """
    # YOUR CODE HERE
    pass


# ==============================================
# EXERCISE 6: Update
# ==============================================
def exercise_6_apply_discount(category_name: str, discount_percent: float) -> int:
    """
    Apply a discount to all books in a category.
    Return the number of books updated.
    
    Example: exercise_6_apply_discount('Mystery', 10)  # 10% off mystery books
    """
    # YOUR CODE HERE
    pass


# ==============================================
# EXERCISE 7: Complex Query
# ==============================================
def exercise_7_get_top_rated_books(limit: int = 5) -> List[Tuple[str, str, float]]:
    """
    Return the top-rated books.
    Return: (book_title, author_name, average_rating)
    Only include books with at least 1 review.
    Order by average rating descending.
    
    Expected: [('Harry Potter...', 'J.K. Rowling', 5.0), ...]
    """
    # YOUR CODE HERE
    pass


# ==============================================
# EXERCISE 8: Transaction
# ==============================================
def exercise_8_create_order(customer_email: str, 
                            items: List[Tuple[str, int]]) -> Optional[int]:
    """
    Create a new order with multiple items.
    items = [(isbn, quantity), ...]
    
    Must be done as a transaction:
    1. Create order record
    2. Create order_item records
    3. Update book stock quantities
    4. Calculate and set total_amount
    
    If any step fails (e.g., not enough stock), rollback and return None.
    Return the order ID on success.
    """
    # YOUR CODE HERE
    pass


# ==============================================
# TEST RUNNER
# ==============================================
def run_tests():
    """Run all exercises and show results."""
    print("=" * 60)
    print("PostgreSQL Exercise Checker")
    print("=" * 60)
    
    tests = [
        ("Exercise 1: Get all categories", 
         lambda: exercise_1_get_all_categories() is not None),
        ("Exercise 2: Filter expensive books", 
         lambda: exercise_2_get_expensive_books(15.0) is not None),
        ("Exercise 3: Get books by author", 
         lambda: exercise_3_get_books_by_author("Agatha") is not None),
        ("Exercise 4: Author book counts", 
         lambda: exercise_4_get_author_book_counts() is not None),
        ("Exercise 5: Add review", 
         lambda: True),  # Can't easily test without side effects
        ("Exercise 6: Apply discount", 
         lambda: True),  # Can't easily test without side effects
        ("Exercise 7: Top rated books", 
         lambda: exercise_7_get_top_rated_books() is not None),
        ("Exercise 8: Create order", 
         lambda: True),  # Can't easily test without side effects
    ]
    
    passed = 0
    for name, test_fn in tests:
        try:
            result = test_fn()
            if result:
                print(f"✅ {name}")
                passed += 1
            else:
                print(f"❌ {name} - returned None/empty")
        except Exception as e:
            print(f"❌ {name} - Error: {e}")
    
    print("\n" + "=" * 60)
    print(f"Results: {passed}/{len(tests)} exercises implemented")
    print("=" * 60)
    
    if passed == 0:
        print("\n💡 Hint: Start by implementing the functions!")
        print("   Look at the lesson files for examples.")


# ==============================================
# SOLUTIONS (SPOILERS!)
# ==============================================
# Uncomment and look at these if you get stuck

"""
def exercise_1_get_all_categories() -> List[str]:
    with psycopg2.connect(**DB_CONFIG) as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT name FROM categories ORDER BY name")
            return [row[0] for row in cur.fetchall()]

def exercise_2_get_expensive_books(min_price: float) -> List[Tuple[str, float]]:
    with psycopg2.connect(**DB_CONFIG) as conn:
        with conn.cursor() as cur:
            cur.execute(
                "SELECT title, price FROM books WHERE price >= %s ORDER BY price DESC",
                (min_price,)
            )
            return cur.fetchall()

def exercise_3_get_books_by_author(author_name: str) -> List[str]:
    with psycopg2.connect(**DB_CONFIG) as conn:
        with conn.cursor() as cur:
            cur.execute('''
                SELECT b.title 
                FROM books b 
                JOIN authors a ON b.author_id = a.id 
                WHERE LOWER(a.name) LIKE LOWER(%s)
                ORDER BY b.title
            ''', (f'%{author_name}%',))
            return [row[0] for row in cur.fetchall()]
"""


if __name__ == "__main__":
    run_tests()
