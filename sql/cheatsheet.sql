-- ============================================
-- SQL Quick Reference Cheatsheet
-- ============================================
-- Keep this open while practicing!
-- ============================================


-- ████████████████████████████████████████████
-- SELECT - Reading Data
-- ████████████████████████████████████████████

-- Basic select
SELECT * FROM table_name;
SELECT column1, column2 FROM table_name;

-- With alias
SELECT column1 AS alias_name FROM table_name;
SELECT first_name || ' ' || last_name AS full_name FROM customers;


-- ████████████████████████████████████████████
-- WHERE - Filtering Rows
-- ████████████████████████████████████████████

-- Comparison operators
SELECT * FROM books WHERE price > 15;
SELECT * FROM books WHERE price >= 15;
SELECT * FROM books WHERE price < 15;
SELECT * FROM books WHERE price <= 15;
SELECT * FROM books WHERE price = 15;
SELECT * FROM books WHERE price != 15;  -- or <>

-- Multiple conditions
SELECT * FROM books WHERE price > 10 AND price < 20;
SELECT * FROM books WHERE category_id = 1 OR category_id = 3;
SELECT * FROM books WHERE NOT category_id = 1;

-- BETWEEN (inclusive)
SELECT * FROM books WHERE price BETWEEN 10 AND 20;

-- IN (match any in list)
SELECT * FROM books WHERE category_id IN (1, 2, 3);

-- LIKE (pattern matching)
SELECT * FROM authors WHERE name LIKE 'J%';        -- starts with J
SELECT * FROM authors WHERE name LIKE '%son';      -- ends with son
SELECT * FROM authors WHERE name LIKE '%row%';     -- contains row
SELECT * FROM authors WHERE name ILIKE '%ROW%';    -- case-insensitive

-- NULL checks
SELECT * FROM books WHERE description IS NULL;
SELECT * FROM books WHERE description IS NOT NULL;


-- ████████████████████████████████████████████
-- ORDER BY - Sorting Results
-- ████████████████████████████████████████████

SELECT * FROM books ORDER BY price;              -- ascending (default)
SELECT * FROM books ORDER BY price ASC;          -- ascending explicit
SELECT * FROM books ORDER BY price DESC;         -- descending
SELECT * FROM books ORDER BY category_id, title; -- multiple columns
SELECT * FROM books ORDER BY price DESC NULLS LAST;


-- ████████████████████████████████████████████
-- LIMIT & OFFSET - Pagination
-- ████████████████████████████████████████████

SELECT * FROM books LIMIT 10;           -- first 10 rows
SELECT * FROM books LIMIT 10 OFFSET 20; -- skip 20, get next 10


-- ████████████████████████████████████████████
-- DISTINCT - Unique Values
-- ████████████████████████████████████████████

SELECT DISTINCT category_id FROM books;
SELECT DISTINCT author_id, category_id FROM books;


-- ████████████████████████████████████████████
-- Aggregate Functions
-- ████████████████████████████████████████████

SELECT COUNT(*) FROM books;                    -- count all rows
SELECT COUNT(description) FROM books;          -- count non-null values
SELECT COUNT(DISTINCT category_id) FROM books; -- count unique values

SELECT SUM(price) FROM books;
SELECT AVG(price) FROM books;
SELECT MIN(price) FROM books;
SELECT MAX(price) FROM books;

SELECT ROUND(AVG(price), 2) FROM books;        -- round to 2 decimals


-- ████████████████████████████████████████████
-- GROUP BY - Aggregation by Category
-- ████████████████████████████████████████████

SELECT category_id, COUNT(*) AS book_count
FROM books
GROUP BY category_id;

SELECT category_id, AVG(price) AS avg_price, SUM(stock_quantity) AS total_stock
FROM books
GROUP BY category_id;


-- ████████████████████████████████████████████
-- HAVING - Filter Aggregated Results
-- ████████████████████████████████████████████

-- HAVING filters AFTER grouping (WHERE filters BEFORE)
SELECT category_id, COUNT(*) AS book_count
FROM books
GROUP BY category_id
HAVING COUNT(*) > 2;

SELECT author_id, AVG(price) AS avg_price
FROM books
GROUP BY author_id
HAVING AVG(price) > 15;


-- ████████████████████████████████████████████
-- JOIN - Combining Tables
-- ████████████████████████████████████████████

-- INNER JOIN (only matching rows)
SELECT b.title, a.name
FROM books b
INNER JOIN authors a ON b.author_id = a.id;

-- LEFT JOIN (all from left table + matching from right)
SELECT a.name, b.title
FROM authors a
LEFT JOIN books b ON a.id = b.author_id;

-- RIGHT JOIN (all from right + matching from left)
SELECT a.name, b.title
FROM authors a
RIGHT JOIN books b ON a.id = b.author_id;

-- Multiple JOINs
SELECT b.title, a.name AS author, c.name AS category
FROM books b
JOIN authors a ON b.author_id = a.id
JOIN categories c ON b.category_id = c.id;


-- ████████████████████████████████████████████
-- Subqueries
-- ████████████████████████████████████████████

-- In WHERE clause
SELECT * FROM books 
WHERE price > (SELECT AVG(price) FROM books);

-- In FROM clause
SELECT category_id, avg_price
FROM (
    SELECT category_id, AVG(price) AS avg_price
    FROM books
    GROUP BY category_id
) AS category_stats
WHERE avg_price > 15;

-- With IN
SELECT * FROM authors
WHERE id IN (SELECT author_id FROM books WHERE price > 20);

-- With EXISTS
SELECT * FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);


-- ████████████████████████████████████████████
-- CASE - Conditional Logic
-- ████████████████████████████████████████████

SELECT title, price,
    CASE
        WHEN price < 14 THEN 'Budget'
        WHEN price <= 20 THEN 'Standard'
        ELSE 'Premium'
    END AS price_tier
FROM books;

-- Simple CASE
SELECT id,
    CASE status
        WHEN 'pending' THEN 'Waiting'
        WHEN 'shipped' THEN 'On the way'
        ELSE 'Other'
    END AS status_label
FROM orders;


-- ████████████████████████████████████████████
-- INSERT - Adding Data
-- ████████████████████████████████████████████

-- Single row
INSERT INTO categories (name, description)
VALUES ('Biography', 'Life stories');

-- Multiple rows
INSERT INTO categories (name, description)
VALUES 
    ('History', 'Historical books'),
    ('Science', 'Scientific topics');

-- With RETURNING (get the new row back)
INSERT INTO authors (name, email)
VALUES ('New Author', 'new@example.com')
RETURNING id, name;

-- Insert with ON CONFLICT (upsert)
INSERT INTO authors (name, email)
VALUES ('Test Author', 'test@example.com')
ON CONFLICT (email) DO NOTHING;

INSERT INTO authors (name, email)
VALUES ('Test Author', 'test@example.com')
ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name;


-- ████████████████████████████████████████████
-- UPDATE - Modifying Data
-- ████████████████████████████████████████████

-- Update specific rows
UPDATE books SET price = 19.99 WHERE id = 1;

-- Update multiple columns
UPDATE books 
SET price = 19.99, stock_quantity = 50 
WHERE id = 1;

-- Update with calculation
UPDATE books SET price = price * 1.10;  -- 10% increase

-- Update with subquery
UPDATE books
SET price = price * 0.90
WHERE category_id = (SELECT id FROM categories WHERE name = 'Mystery');

-- Update with RETURNING
UPDATE books SET price = 25.00 WHERE id = 1 RETURNING *;


-- ████████████████████████████████████████████
-- DELETE - Removing Data
-- ████████████████████████████████████████████

-- Delete specific rows
DELETE FROM categories WHERE name = 'Test';

-- Delete with subquery
DELETE FROM books 
WHERE author_id = (SELECT id FROM authors WHERE name = 'Test');

-- Delete all (dangerous!)
-- DELETE FROM table_name;

-- TRUNCATE (faster for deleting all rows)
-- TRUNCATE table_name;


-- ████████████████████████████████████████████
-- Date & Time Functions
-- ████████████████████████████████████████████

SELECT CURRENT_DATE;                            -- today's date
SELECT CURRENT_TIMESTAMP;                       -- current datetime
SELECT NOW();                                   -- same as above

SELECT EXTRACT(YEAR FROM order_date) FROM orders;
SELECT EXTRACT(MONTH FROM order_date) FROM orders;
SELECT EXTRACT(DAY FROM order_date) FROM orders;

SELECT DATE_TRUNC('month', order_date) FROM orders;  -- truncate to month
SELECT order_date + INTERVAL '7 days' FROM orders;   -- add time

SELECT AGE(order_date) FROM orders;             -- time since order


-- ████████████████████████████████████████████
-- String Functions
-- ████████████████████████████████████████████

SELECT UPPER(name) FROM authors;                -- uppercase
SELECT LOWER(name) FROM authors;                -- lowercase
SELECT LENGTH(name) FROM authors;               -- string length
SELECT TRIM('  hello  ');                       -- remove whitespace

SELECT first_name || ' ' || last_name FROM customers;  -- concatenate
SELECT CONCAT(first_name, ' ', last_name) FROM customers;

SELECT SUBSTRING(title FROM 1 FOR 10) FROM books;      -- first 10 chars
SELECT REPLACE(title, 'the', 'THE') FROM books;        -- replace text

SELECT STRING_AGG(title, ', ') FROM books;             -- combine into one string


-- ████████████████████████████████████████████
-- Useful Patterns
-- ████████████████████████████████████████████

-- Count with condition
SELECT 
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE price > 15) AS expensive
FROM books;

-- Percentage
SELECT 
    category_id,
    COUNT(*) AS count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM books
GROUP BY category_id;

-- Running total
SELECT 
    id,
    total_amount,
    SUM(total_amount) OVER (ORDER BY order_date) AS running_total
FROM orders;

-- Rank
SELECT 
    title,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank
FROM books;


-- ============================================
-- 💡 REMEMBER
-- ============================================
-- 1. WHERE filters before grouping
-- 2. HAVING filters after grouping
-- 3. Always use parameterized queries in code!
-- 4. Test SELECT before UPDATE/DELETE
-- 5. Use transactions for multiple changes
-- ============================================
