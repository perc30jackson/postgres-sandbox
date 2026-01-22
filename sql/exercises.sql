-- ============================================
-- SQL Practice Worksheet
-- ============================================
-- Work through these exercises in order!
-- Each level builds on the previous one.
-- 
-- HOW TO USE:
-- 1. Connect to the database:
--    docker exec -it learning_postgres psql -U learner -d learning_db
-- 2. Try writing the query yourself first
-- 3. Check answers at the bottom (no peeking!)
-- ============================================


-- ████████████████████████████████████████████
-- LEVEL 1: SELECT Basics (Warm-up)
-- ████████████████████████████████████████████

-- Exercise 1.1
-- Select all columns from the authors table
-- YOUR QUERY:



-- Exercise 1.2
-- Select only the name and email columns from authors
-- YOUR QUERY:



-- Exercise 1.3
-- Select all book titles
-- YOUR QUERY:



-- Exercise 1.4
-- Select title and price from books
-- YOUR QUERY:



-- Exercise 1.5
-- Select all columns from customers
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 2: WHERE Clause (Filtering)
-- ████████████████████████████████████████████

-- Exercise 2.1
-- Find all books priced over $15
-- YOUR QUERY:



-- Exercise 2.2
-- Find the author born in 1965
-- YOUR QUERY:



-- Exercise 2.3
-- Find all books with stock_quantity less than 25
-- YOUR QUERY:



-- Exercise 2.4
-- Find customers whose first_name is 'Alice'
-- YOUR QUERY:



-- Exercise 2.5
-- Find orders with status 'delivered'
-- YOUR QUERY:



-- Exercise 2.6
-- Find books priced between $12 and $18 (inclusive)
-- Hint: Use BETWEEN
-- YOUR QUERY:



-- Exercise 2.7
-- Find authors whose name contains 'Christie'
-- Hint: Use LIKE with %
-- YOUR QUERY:



-- Exercise 2.8
-- Find books where category_id is 1, 3, or 4
-- Hint: Use IN
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 3: ORDER BY & LIMIT (Sorting)
-- ████████████████████████████████████████████

-- Exercise 3.1
-- List all books ordered by price (cheapest first)
-- YOUR QUERY:



-- Exercise 3.2
-- List all books ordered by price (most expensive first)
-- YOUR QUERY:



-- Exercise 3.3
-- List authors ordered alphabetically by name
-- YOUR QUERY:



-- Exercise 3.4
-- Find the 3 most expensive books
-- YOUR QUERY:



-- Exercise 3.5
-- Find the 5 oldest authors (by birth_year, ascending)
-- YOUR QUERY:



-- Exercise 3.6
-- List books ordered by category_id, then by title within each category
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 4: DISTINCT & Column Aliases
-- ████████████████████████████████████████████

-- Exercise 4.1
-- List all unique category_ids that have books
-- YOUR QUERY:



-- Exercise 4.2
-- List all unique order statuses
-- YOUR QUERY:



-- Exercise 4.3
-- Select book titles with price, showing price as "cost"
-- Hint: Use AS for alias
-- YOUR QUERY:



-- Exercise 4.4
-- Select customer first_name and last_name combined as "full_name"
-- Hint: Use || for concatenation
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 5: Simple Aggregates (COUNT, SUM, AVG)
-- ████████████████████████████████████████████

-- Exercise 5.1
-- Count total number of books
-- YOUR QUERY:



-- Exercise 5.2
-- Count total number of customers
-- YOUR QUERY:



-- Exercise 5.3
-- Find the average book price
-- YOUR QUERY:



-- Exercise 5.4
-- Find the total value of all book inventory (sum of price * stock_quantity)
-- YOUR QUERY:



-- Exercise 5.5
-- Find the minimum and maximum book prices
-- YOUR QUERY:



-- Exercise 5.6
-- Find the average rating across all reviews
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 6: GROUP BY (Aggregation by Category)
-- ████████████████████████████████████████████

-- Exercise 6.1
-- Count how many books are in each category_id
-- YOUR QUERY:



-- Exercise 6.2
-- Find the average book price for each category_id
-- YOUR QUERY:



-- Exercise 6.3
-- Count how many orders each customer_id has placed
-- YOUR QUERY:



-- Exercise 6.4
-- Find the total stock_quantity for each author_id
-- YOUR QUERY:



-- Exercise 6.5
-- Count reviews and average rating for each book_id
-- YOUR QUERY:



-- Exercise 6.6
-- Find total order amount per order status
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 7: HAVING (Filtering Aggregates)
-- ████████████████████████████████████████████

-- Exercise 7.1
-- Find category_ids that have more than 2 books
-- YOUR QUERY:



-- Exercise 7.2
-- Find author_ids with total stock > 40
-- YOUR QUERY:



-- Exercise 7.3
-- Find book_ids with average rating >= 4.5
-- YOUR QUERY:



-- Exercise 7.4
-- Find customer_ids who have placed more than 1 order
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 8: INNER JOIN (Combining Tables)
-- ████████████████████████████████████████████

-- Exercise 8.1
-- List book titles with their author names
-- YOUR QUERY:



-- Exercise 8.2
-- List book titles with their category names
-- YOUR QUERY:



-- Exercise 8.3
-- List all reviews with the book title and customer name
-- YOUR QUERY:



-- Exercise 8.4
-- List order items with book titles and prices
-- YOUR QUERY:



-- Exercise 8.5
-- List all books with author name AND category name
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 9: LEFT JOIN (Including Unmatched Rows)
-- ████████████████████████████████████████████

-- Exercise 9.1
-- List ALL authors and their books (even authors with no books)
-- YOUR QUERY:



-- Exercise 9.2
-- List ALL categories and count of books in each (even empty categories)
-- YOUR QUERY:



-- Exercise 9.3
-- List ALL customers and their order count (even those with 0 orders)
-- YOUR QUERY:



-- Exercise 9.4
-- Find authors who have no books
-- Hint: Use LEFT JOIN and check for NULL
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 10: Complex JOINs with Aggregates
-- ████████████████████████████████████████████

-- Exercise 10.1
-- List each author with their book count and average book price
-- YOUR QUERY:



-- Exercise 10.2
-- List each category with book count and total inventory value
-- YOUR QUERY:



-- Exercise 10.3
-- List each customer with their total spent across all orders
-- YOUR QUERY:



-- Exercise 10.4
-- Find the most reviewed books with their average ratings
-- Show: book title, author name, review count, average rating
-- Order by review count descending
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 11: Subqueries
-- ████████████████████████████████████████████

-- Exercise 11.1
-- Find books priced above the average price
-- YOUR QUERY:



-- Exercise 11.2
-- Find authors who have written books in category 'Mystery'
-- YOUR QUERY:



-- Exercise 11.3
-- Find customers who have never placed an order
-- Hint: Use NOT IN or NOT EXISTS
-- YOUR QUERY:



-- Exercise 11.4
-- Find the book(s) with the highest price
-- YOUR QUERY:



-- Exercise 11.5
-- Find books that have better-than-average ratings
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 12: CASE Expressions
-- ████████████████████████████████████████████

-- Exercise 12.1
-- Categorize books as 'Budget' (< $14), 'Standard' ($14-$20), or 'Premium' (> $20)
-- YOUR QUERY:



-- Exercise 12.2
-- Show order status with friendly labels:
-- 'pending' → 'Awaiting Processing'
-- 'processing' → 'Being Prepared'
-- 'shipped' → 'On the Way'
-- 'delivered' → 'Completed'
-- YOUR QUERY:



-- Exercise 12.3
-- Rate books: 'Low Stock' (< 20), 'Normal' (20-35), 'Well Stocked' (> 35)
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 13: Date Functions
-- ████████████████████████████████████████████

-- Exercise 13.1
-- Find orders placed in January 2024
-- YOUR QUERY:



-- Exercise 13.2
-- Calculate how many days ago each order was placed
-- Hint: Use CURRENT_DATE
-- YOUR QUERY:



-- Exercise 13.3
-- Extract the year and month from order dates
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 14: INSERT, UPDATE, DELETE
-- ████████████████████████████████████████████

-- Exercise 14.1
-- Insert a new category called 'Poetry' with description 'Poems and verse'
-- YOUR QUERY:



-- Exercise 14.2
-- Update all Mystery books to increase price by 10%
-- YOUR QUERY:



-- Exercise 14.3
-- Add 5 to the stock_quantity of all books by 'George Orwell'
-- Hint: Use a subquery or JOIN
-- YOUR QUERY:



-- Exercise 14.4
-- Delete the 'Poetry' category you just created
-- YOUR QUERY:




-- ████████████████████████████████████████████
-- LEVEL 15: CHALLENGE PROBLEMS
-- ████████████████████████████████████████████

-- Challenge 1: Best Selling Authors
-- Find authors ranked by total revenue (sum of book price × stock sold)
-- Assume "sold" = original stock (50) minus current stock
-- Show: author name, books sold count, total revenue
-- YOUR QUERY:



-- Challenge 2: Customer Loyalty Report  
-- Create a report showing:
-- - Customer full name
-- - Total orders
-- - Total amount spent
-- - Average order value
-- - Their favorite category (most purchased)
-- Order by total spent descending
-- YOUR QUERY:



-- Challenge 3: Book Recommendation
-- For each book, find other books in the same category
-- (excluding the book itself)
-- Show: book title, recommended book title, category
-- YOUR QUERY:



-- Challenge 4: Monthly Sales Report
-- Show orders aggregated by month:
-- - Month/Year
-- - Number of orders
-- - Total revenue
-- - Average order value
-- YOUR QUERY:



-- Challenge 5: Complete Order Details
-- Create a comprehensive order view showing:
-- - Order ID
-- - Customer name
-- - Order date
-- - Status
-- - Number of items
-- - List of book titles (comma-separated)
-- - Total amount
-- YOUR QUERY:




-- ============================================
-- ============================================
-- 
--              ANSWER KEY
--          (Scroll down slowly!)
-- 
-- ============================================
-- ============================================
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- ████████████████████████████████████████████
-- LEVEL 1 ANSWERS
-- ████████████████████████████████████████████

-- 1.1
-- SELECT * FROM authors;

-- 1.2
-- SELECT name, email FROM authors;

-- 1.3
-- SELECT title FROM books;

-- 1.4
-- SELECT title, price FROM books;

-- 1.5
-- SELECT * FROM customers;


-- ████████████████████████████████████████████
-- LEVEL 2 ANSWERS
-- ████████████████████████████████████████████

-- 2.1
-- SELECT * FROM books WHERE price > 15;

-- 2.2
-- SELECT * FROM authors WHERE birth_year = 1965;

-- 2.3
-- SELECT * FROM books WHERE stock_quantity < 25;

-- 2.4
-- SELECT * FROM customers WHERE first_name = 'Alice';

-- 2.5
-- SELECT * FROM orders WHERE status = 'delivered';

-- 2.6
-- SELECT * FROM books WHERE price BETWEEN 12 AND 18;

-- 2.7
-- SELECT * FROM authors WHERE name LIKE '%Christie%';

-- 2.8
-- SELECT * FROM books WHERE category_id IN (1, 3, 4);


-- ████████████████████████████████████████████
-- LEVEL 3 ANSWERS
-- ████████████████████████████████████████████

-- 3.1
-- SELECT * FROM books ORDER BY price ASC;

-- 3.2
-- SELECT * FROM books ORDER BY price DESC;

-- 3.3
-- SELECT * FROM authors ORDER BY name ASC;

-- 3.4
-- SELECT * FROM books ORDER BY price DESC LIMIT 3;

-- 3.5
-- SELECT * FROM authors ORDER BY birth_year ASC LIMIT 5;

-- 3.6
-- SELECT * FROM books ORDER BY category_id, title;


-- ████████████████████████████████████████████
-- LEVEL 4 ANSWERS
-- ████████████████████████████████████████████

-- 4.1
-- SELECT DISTINCT category_id FROM books;

-- 4.2
-- SELECT DISTINCT status FROM orders;

-- 4.3
-- SELECT title, price AS cost FROM books;

-- 4.4
-- SELECT first_name || ' ' || last_name AS full_name FROM customers;


-- ████████████████████████████████████████████
-- LEVEL 5 ANSWERS
-- ████████████████████████████████████████████

-- 5.1
-- SELECT COUNT(*) FROM books;

-- 5.2
-- SELECT COUNT(*) FROM customers;

-- 5.3
-- SELECT AVG(price) FROM books;

-- 5.4
-- SELECT SUM(price * stock_quantity) AS total_inventory_value FROM books;

-- 5.5
-- SELECT MIN(price), MAX(price) FROM books;

-- 5.6
-- SELECT AVG(rating) FROM reviews;


-- ████████████████████████████████████████████
-- LEVEL 6 ANSWERS
-- ████████████████████████████████████████████

-- 6.1
-- SELECT category_id, COUNT(*) FROM books GROUP BY category_id;

-- 6.2
-- SELECT category_id, AVG(price) FROM books GROUP BY category_id;

-- 6.3
-- SELECT customer_id, COUNT(*) FROM orders GROUP BY customer_id;

-- 6.4
-- SELECT author_id, SUM(stock_quantity) FROM books GROUP BY author_id;

-- 6.5
-- SELECT book_id, COUNT(*) AS review_count, AVG(rating) AS avg_rating 
-- FROM reviews GROUP BY book_id;

-- 6.6
-- SELECT status, SUM(total_amount) FROM orders GROUP BY status;


-- ████████████████████████████████████████████
-- LEVEL 7 ANSWERS
-- ████████████████████████████████████████████

-- 7.1
-- SELECT category_id, COUNT(*) 
-- FROM books 
-- GROUP BY category_id 
-- HAVING COUNT(*) > 2;

-- 7.2
-- SELECT author_id, SUM(stock_quantity) 
-- FROM books 
-- GROUP BY author_id 
-- HAVING SUM(stock_quantity) > 40;

-- 7.3
-- SELECT book_id, AVG(rating) 
-- FROM reviews 
-- GROUP BY book_id 
-- HAVING AVG(rating) >= 4.5;

-- 7.4
-- SELECT customer_id, COUNT(*) 
-- FROM orders 
-- GROUP BY customer_id 
-- HAVING COUNT(*) > 1;


-- ████████████████████████████████████████████
-- LEVEL 8 ANSWERS
-- ████████████████████████████████████████████

-- 8.1
-- SELECT b.title, a.name AS author
-- FROM books b
-- JOIN authors a ON b.author_id = a.id;

-- 8.2
-- SELECT b.title, c.name AS category
-- FROM books b
-- JOIN categories c ON b.category_id = c.id;

-- 8.3
-- SELECT b.title, c.first_name || ' ' || c.last_name AS customer, r.rating, r.comment
-- FROM reviews r
-- JOIN books b ON r.book_id = b.id
-- JOIN customers c ON r.customer_id = c.id;

-- 8.4
-- SELECT oi.id, b.title, oi.quantity, oi.price_at_purchase
-- FROM order_items oi
-- JOIN books b ON oi.book_id = b.id;

-- 8.5
-- SELECT b.title, a.name AS author, c.name AS category
-- FROM books b
-- JOIN authors a ON b.author_id = a.id
-- JOIN categories c ON b.category_id = c.id;


-- ████████████████████████████████████████████
-- LEVEL 9 ANSWERS
-- ████████████████████████████████████████████

-- 9.1
-- SELECT a.name, b.title
-- FROM authors a
-- LEFT JOIN books b ON a.id = b.author_id;

-- 9.2
-- SELECT c.name, COUNT(b.id) AS book_count
-- FROM categories c
-- LEFT JOIN books b ON c.id = b.category_id
-- GROUP BY c.id, c.name;

-- 9.3
-- SELECT c.first_name, c.last_name, COUNT(o.id) AS order_count
-- FROM customers c
-- LEFT JOIN orders o ON c.id = o.customer_id
-- GROUP BY c.id;

-- 9.4
-- SELECT a.name
-- FROM authors a
-- LEFT JOIN books b ON a.id = b.author_id
-- WHERE b.id IS NULL;


-- ████████████████████████████████████████████
-- LEVEL 10 ANSWERS
-- ████████████████████████████████████████████

-- 10.1
-- SELECT a.name, COUNT(b.id) AS book_count, ROUND(AVG(b.price)::numeric, 2) AS avg_price
-- FROM authors a
-- LEFT JOIN books b ON a.id = b.author_id
-- GROUP BY a.id
-- ORDER BY book_count DESC;

-- 10.2
-- SELECT c.name, 
--        COUNT(b.id) AS book_count,
--        SUM(b.price * b.stock_quantity) AS total_inventory_value
-- FROM categories c
-- LEFT JOIN books b ON c.id = b.category_id
-- GROUP BY c.id;

-- 10.3
-- SELECT c.first_name || ' ' || c.last_name AS customer,
--        SUM(o.total_amount) AS total_spent
-- FROM customers c
-- JOIN orders o ON c.id = o.customer_id
-- GROUP BY c.id
-- ORDER BY total_spent DESC;

-- 10.4
-- SELECT b.title, a.name AS author, 
--        COUNT(r.id) AS review_count,
--        ROUND(AVG(r.rating)::numeric, 1) AS avg_rating
-- FROM books b
-- JOIN authors a ON b.author_id = a.id
-- JOIN reviews r ON b.id = r.book_id
-- GROUP BY b.id, a.name
-- ORDER BY review_count DESC;


-- ████████████████████████████████████████████
-- LEVEL 11 ANSWERS
-- ████████████████████████████████████████████

-- 11.1
-- SELECT * FROM books WHERE price > (SELECT AVG(price) FROM books);

-- 11.2
-- SELECT DISTINCT a.name
-- FROM authors a
-- JOIN books b ON a.id = b.author_id
-- WHERE b.category_id = (SELECT id FROM categories WHERE name = 'Mystery');

-- 11.3
-- SELECT * FROM customers 
-- WHERE id NOT IN (SELECT DISTINCT customer_id FROM orders WHERE customer_id IS NOT NULL);

-- 11.4
-- SELECT * FROM books WHERE price = (SELECT MAX(price) FROM books);

-- 11.5
-- SELECT b.title, AVG(r.rating) AS avg_rating
-- FROM books b
-- JOIN reviews r ON b.id = r.book_id
-- GROUP BY b.id
-- HAVING AVG(r.rating) > (SELECT AVG(rating) FROM reviews);


-- ████████████████████████████████████████████
-- LEVEL 12 ANSWERS
-- ████████████████████████████████████████████

-- 12.1
-- SELECT title, price,
--   CASE 
--     WHEN price < 14 THEN 'Budget'
--     WHEN price <= 20 THEN 'Standard'
--     ELSE 'Premium'
--   END AS price_tier
-- FROM books;

-- 12.2
-- SELECT id, 
--   CASE status
--     WHEN 'pending' THEN 'Awaiting Processing'
--     WHEN 'processing' THEN 'Being Prepared'
--     WHEN 'shipped' THEN 'On the Way'
--     WHEN 'delivered' THEN 'Completed'
--     ELSE status
--   END AS status_label
-- FROM orders;

-- 12.3
-- SELECT title, stock_quantity,
--   CASE 
--     WHEN stock_quantity < 20 THEN 'Low Stock'
--     WHEN stock_quantity <= 35 THEN 'Normal'
--     ELSE 'Well Stocked'
--   END AS stock_status
-- FROM books;


-- ████████████████████████████████████████████
-- LEVEL 13 ANSWERS
-- ████████████████████████████████████████████

-- 13.1
-- SELECT * FROM orders 
-- WHERE order_date >= '2024-01-01' AND order_date < '2024-02-01';

-- 13.2
-- SELECT id, order_date, 
--        CURRENT_DATE - order_date::date AS days_ago
-- FROM orders;

-- 13.3
-- SELECT id, order_date,
--        EXTRACT(YEAR FROM order_date) AS year,
--        EXTRACT(MONTH FROM order_date) AS month
-- FROM orders;


-- ████████████████████████████████████████████
-- LEVEL 14 ANSWERS
-- ████████████████████████████████████████████

-- 14.1
-- INSERT INTO categories (name, description) 
-- VALUES ('Poetry', 'Poems and verse');

-- 14.2
-- UPDATE books 
-- SET price = price * 1.10 
-- WHERE category_id = (SELECT id FROM categories WHERE name = 'Mystery');

-- 14.3
-- UPDATE books 
-- SET stock_quantity = stock_quantity + 5 
-- WHERE author_id = (SELECT id FROM authors WHERE name LIKE '%Orwell%');

-- 14.4
-- DELETE FROM categories WHERE name = 'Poetry';


-- ████████████████████████████████████████████
-- LEVEL 15 CHALLENGE ANSWERS
-- ████████████████████████████████████████████

-- Challenge 1: Best Selling Authors
-- SELECT a.name,
--        SUM(50 - b.stock_quantity) AS books_sold,
--        SUM((50 - b.stock_quantity) * b.price) AS total_revenue
-- FROM authors a
-- JOIN books b ON a.id = b.author_id
-- GROUP BY a.id
-- ORDER BY total_revenue DESC;

-- Challenge 2: Customer Loyalty Report
-- SELECT 
--   c.first_name || ' ' || c.last_name AS customer,
--   COUNT(DISTINCT o.id) AS total_orders,
--   SUM(o.total_amount) AS total_spent,
--   ROUND(AVG(o.total_amount)::numeric, 2) AS avg_order_value
-- FROM customers c
-- JOIN orders o ON c.id = o.customer_id
-- GROUP BY c.id
-- ORDER BY total_spent DESC;

-- Challenge 3: Book Recommendations
-- SELECT b1.title AS book, b2.title AS recommended, c.name AS category
-- FROM books b1
-- JOIN books b2 ON b1.category_id = b2.category_id AND b1.id != b2.id
-- JOIN categories c ON b1.category_id = c.id
-- ORDER BY b1.title, b2.title;

-- Challenge 4: Monthly Sales Report
-- SELECT 
--   TO_CHAR(order_date, 'YYYY-MM') AS month,
--   COUNT(*) AS order_count,
--   SUM(total_amount) AS total_revenue,
--   ROUND(AVG(total_amount)::numeric, 2) AS avg_order_value
-- FROM orders
-- GROUP BY TO_CHAR(order_date, 'YYYY-MM')
-- ORDER BY month;

-- Challenge 5: Complete Order Details
-- SELECT 
--   o.id AS order_id,
--   c.first_name || ' ' || c.last_name AS customer,
--   o.order_date,
--   o.status,
--   COUNT(oi.id) AS item_count,
--   STRING_AGG(b.title, ', ') AS books,
--   o.total_amount
-- FROM orders o
-- JOIN customers c ON o.customer_id = c.id
-- JOIN order_items oi ON o.id = oi.order_id
-- JOIN books b ON oi.book_id = b.id
-- GROUP BY o.id, c.first_name, c.last_name
-- ORDER BY o.order_date DESC;


-- ============================================
-- 🎉 CONGRATULATIONS!
-- ============================================
-- You've completed all SQL exercises!
-- 
-- Next steps:
-- 1. Try modifying these queries
-- 2. Create your own complex queries
-- 3. Practice with real-world scenarios
-- 4. Learn about indexes and optimization
-- ============================================
