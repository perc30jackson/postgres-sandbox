-- ============================================
-- PostgreSQL Learning Database - Initial Schema
-- ============================================
-- This script creates a sample bookstore database
-- Perfect for learning SQL, Python, and Prisma!

-- Create Authors table
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    bio TEXT,
    birth_year INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Categories table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Create Books table
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    author_id INTEGER REFERENCES authors(id) ON DELETE SET NULL,
    category_id INTEGER REFERENCES categories(id) ON DELETE SET NULL,
    price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    published_date DATE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Customers table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create Orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id) ON DELETE CASCADE,
    order_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    total_amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00
);

-- Create Order Items table (many-to-many between orders and books)
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
    book_id INTEGER REFERENCES books(id) ON DELETE SET NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    price_at_purchase DECIMAL(10, 2) NOT NULL
);

-- Create Reviews table
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(id) ON DELETE CASCADE,
    customer_id INTEGER REFERENCES customers(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(book_id, customer_id)
);

-- Create indexes for better query performance
CREATE INDEX idx_books_author ON books(author_id);
CREATE INDEX idx_books_category ON books(category_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_reviews_book ON reviews(book_id);

-- ============================================
-- Insert Sample Data
-- ============================================

-- Insert Authors
INSERT INTO authors (name, email, bio, birth_year) VALUES
('J.K. Rowling', 'jk@example.com', 'British author best known for the Harry Potter series.', 1965),
('George Orwell', 'orwell@example.com', 'English novelist and essayist, known for 1984 and Animal Farm.', 1903),
('Jane Austen', 'austen@example.com', 'English novelist known for her six major novels.', 1775),
('Ernest Hemingway', 'hemingway@example.com', 'American novelist and short story writer.', 1899),
('Agatha Christie', 'christie@example.com', 'English writer known for detective novels.', 1890);

-- Insert Categories
INSERT INTO categories (name, description) VALUES
('Fiction', 'Novels and short stories based on imagination'),
('Science Fiction', 'Fiction dealing with futuristic science and technology'),
('Mystery', 'Fiction dealing with puzzles and crime solving'),
('Romance', 'Fiction centered on romantic relationships'),
('Non-Fiction', 'Factual books based on real events and information');

-- Insert Books
INSERT INTO books (title, isbn, author_id, category_id, price, stock_quantity, published_date, description) VALUES
('Harry Potter and the Sorcerer''s Stone', '978-0439708180', 1, 1, 24.99, 50, '1997-06-26', 'A young wizard begins his journey.'),
('1984', '978-0451524935', 2, 2, 15.99, 30, '1949-06-08', 'A dystopian social science fiction novel.'),
('Pride and Prejudice', '978-0141439518', 3, 4, 12.99, 25, '1813-01-28', 'A romantic novel of manners.'),
('The Old Man and the Sea', '978-0684801223', 4, 1, 14.99, 20, '1952-09-01', 'The story of an aging Cuban fisherman.'),
('Murder on the Orient Express', '978-0062693662', 5, 3, 16.99, 35, '1934-01-01', 'A famous Hercule Poirot mystery.'),
('Animal Farm', '978-0451526342', 2, 1, 11.99, 40, '1945-08-17', 'An allegorical novella about farm animals.'),
('Emma', '978-0141439587', 3, 4, 13.99, 15, '1815-12-23', 'A comedy of manners about matchmaking.'),
('And Then There Were None', '978-0062073488', 5, 3, 15.99, 28, '1939-11-06', 'Ten strangers are lured to an island.');

-- Insert Customers
INSERT INTO customers (first_name, last_name, email, phone, address) VALUES
('Alice', 'Johnson', 'alice@example.com', '555-0101', '123 Main St, Springfield'),
('Bob', 'Smith', 'bob@example.com', '555-0102', '456 Oak Ave, Portland'),
('Carol', 'Williams', 'carol@example.com', '555-0103', '789 Pine Rd, Seattle'),
('David', 'Brown', 'david@example.com', '555-0104', '321 Elm St, Austin'),
('Eva', 'Davis', 'eva@example.com', '555-0105', '654 Maple Dr, Denver');

-- Insert Orders
INSERT INTO orders (customer_id, status, total_amount, order_date) VALUES
(1, 'delivered', 40.98, '2024-01-15 10:30:00'),
(2, 'shipped', 24.99, '2024-01-20 14:45:00'),
(3, 'processing', 32.98, '2024-01-22 09:15:00'),
(1, 'pending', 15.99, '2024-01-25 16:00:00'),
(4, 'delivered', 27.98, '2024-01-10 11:30:00');

-- Insert Order Items
INSERT INTO order_items (order_id, book_id, quantity, price_at_purchase) VALUES
(1, 1, 1, 24.99),
(1, 6, 1, 11.99),
(2, 1, 1, 24.99),
(3, 5, 1, 16.99),
(3, 2, 1, 15.99),
(4, 2, 1, 15.99),
(5, 3, 1, 12.99),
(5, 4, 1, 14.99);

-- Insert Reviews
INSERT INTO reviews (book_id, customer_id, rating, comment) VALUES
(1, 1, 5, 'Absolutely magical! A must-read for all ages.'),
(1, 2, 5, 'Loved every page. Can''t wait to read the series.'),
(2, 3, 4, 'Chilling and thought-provoking. Still relevant today.'),
(3, 4, 5, 'A timeless classic. Witty and romantic.'),
(5, 1, 4, 'Great mystery! Kept me guessing until the end.'),
(6, 2, 4, 'A clever allegory. Easy to read but deep meaning.');

-- ============================================
-- Useful Views for Learning
-- ============================================

-- View: Book details with author and category names
CREATE VIEW book_details AS
SELECT 
    b.id,
    b.title,
    b.isbn,
    a.name AS author_name,
    c.name AS category_name,
    b.price,
    b.stock_quantity,
    b.published_date
FROM books b
LEFT JOIN authors a ON b.author_id = a.id
LEFT JOIN categories c ON b.category_id = c.id;

-- View: Customer order summary
CREATE VIEW customer_order_summary AS
SELECT 
    c.id AS customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name;

-- View: Book ratings summary
CREATE VIEW book_ratings AS
SELECT 
    b.id AS book_id,
    b.title,
    COUNT(r.id) AS review_count,
    ROUND(AVG(r.rating)::numeric, 2) AS average_rating
FROM books b
LEFT JOIN reviews r ON b.id = r.book_id
GROUP BY b.id, b.title;

COMMENT ON DATABASE learning_db IS 'A sample bookstore database for learning PostgreSQL, Python, and Prisma';
