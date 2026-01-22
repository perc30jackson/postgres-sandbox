# 🐘 PostgreSQL Learning Sandbox

A hands-on learning environment for PostgreSQL with **Python** (psycopg2 & SQLAlchemy) and **Prisma** (TypeScript).

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?logo=postgresql)
![Python](https://img.shields.io/badge/Python-3.10+-green?logo=python)
![Prisma](https://img.shields.io/badge/Prisma-5.x-purple?logo=prisma)
![Docker](https://img.shields.io/badge/Docker-Required-blue?logo=docker)

## 📋 Prerequisites

Before you begin, make sure you have installed:

- [Docker Desktop](https://www.docker.com/products/docker-desktop) (for running PostgreSQL)
- [Python 3.10+](https://www.python.org/downloads/)
- [Node.js 18+](https://nodejs.org/) (for Prisma)
- [pnpm](https://pnpm.io/installation) (recommended) or npm

## 🚀 Quick Start

### 1. Start the PostgreSQL Database

```bash
# Start PostgreSQL container
docker-compose up -d

# Verify it's running
docker-compose ps
```

The database will be available at:
- **Host:** localhost
- **Port:** 5432
- **Database:** learning_db
- **User:** learner
- **Password:** learnpass123

### 2. Choose Your Learning Path

#### 🐍 Python Path

```bash
# Navigate to Python directory
cd python

# Create virtual environment (recommended)
python -m venv venv

# Activate it
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run the first lesson
python 01_basic_connection.py
```

#### 🔷 Prisma Path

```bash
# Navigate to Prisma directory
cd prisma

# Copy environment template
copy .env-template .env    # Windows
# cp .env-template .env    # macOS/Linux

# Install dependencies
pnpm install

# Generate Prisma Client
pnpm prisma:generate

# Run the overview
pnpm dev
```

## 📚 Learning Modules

### Python Lessons

| File | Topic | What You'll Learn |
|------|-------|-------------------|
| `01_basic_connection.py` | Connecting | Database connections, basic queries |
| `02_crud_operations.py` | CRUD | INSERT, SELECT, UPDATE, DELETE |
| `03_sqlalchemy_intro.py` | ORM | SQLAlchemy models and relationships |
| `exercises.py` | Practice | 8 exercises to test your skills |

### Prisma Lessons

| Command | Topic | What You'll Learn |
|---------|-------|-------------------|
| `pnpm lesson:basics` | Basics | Prisma Client, basic queries |
| `pnpm lesson:crud` | CRUD | Create, Read, Update, Delete |
| `pnpm lesson:relations` | Relations | Working with related data |
| `pnpm prisma:studio` | Explore | Visual database browser |

## 🗄️ Database Schema

The sample database is a **bookstore** with:

```
┌─────────────┐       ┌─────────────┐
│   authors   │───────│    books    │
└─────────────┘       └─────────────┘
                            │
┌─────────────┐       ┌─────────────┐
│ categories  │───────│   reviews   │
└─────────────┘       └─────────────┘
                            │
┌─────────────┐       ┌─────────────┐
│  customers  │───────│   orders    │───── order_items
└─────────────┘       └─────────────┘
```

### Tables

- **authors** - Book authors with bio and birth year
- **categories** - Book categories (Fiction, Mystery, etc.)
- **books** - Books with title, ISBN, price, stock
- **customers** - Customer information
- **orders** - Customer orders with status
- **order_items** - Books in each order
- **reviews** - Book ratings and comments

## 🔧 Useful Commands

### Docker

```bash
# Start database
docker-compose up -d

# Stop database (keeps data)
docker-compose stop

# Stop and remove everything (including data)
docker-compose down -v

# View logs
docker-compose logs -f postgres

# Connect with psql
docker exec -it learning_postgres psql -U learner -d learning_db
```

### Python

```bash
# Run a lesson
python 01_basic_connection.py

# Run exercises
python exercises.py

# Interactive shell with database
ipython -i 03_sqlalchemy_intro.py
```

### Prisma

```bash
# Generate client after schema changes
pnpm prisma:generate

# Open visual database browser
pnpm prisma:studio

# Pull schema from existing database
pnpm prisma:introspect

# Push schema changes to database
pnpm prisma:push
```

## 💡 Sample Queries to Try

Once connected, try these SQL queries:

```sql
-- View all books with their authors
SELECT b.title, a.name as author, b.price
FROM books b
JOIN authors a ON b.author_id = a.id;

-- Find the average book price per category
SELECT c.name, ROUND(AVG(b.price)::numeric, 2) as avg_price
FROM categories c
LEFT JOIN books b ON c.id = b.category_id
GROUP BY c.name;

-- Find customers who spent the most
SELECT 
    c.first_name || ' ' || c.last_name as customer,
    SUM(o.total_amount) as total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id
ORDER BY total_spent DESC;

-- Books with the highest ratings
SELECT 
    b.title,
    ROUND(AVG(r.rating)::numeric, 1) as avg_rating,
    COUNT(r.id) as review_count
FROM books b
JOIN reviews r ON b.id = r.book_id
GROUP BY b.id
HAVING COUNT(r.id) >= 1
ORDER BY avg_rating DESC;
```

## 📁 Project Structure

```
postgres-sandbox/
├── docker-compose.yml      # PostgreSQL container config
├── sql/
│   └── init.sql           # Database schema & seed data
├── python/
│   ├── requirements.txt   # Python dependencies
│   ├── 01_basic_connection.py
│   ├── 02_crud_operations.py
│   ├── 03_sqlalchemy_intro.py
│   └── exercises.py       # Practice exercises
├── prisma/
│   ├── package.json       # Node.js dependencies
│   ├── tsconfig.json      # TypeScript config
│   ├── prisma/
│   │   └── schema.prisma  # Prisma schema
│   └── src/
│       ├── index.ts       # Main entry point
│       ├── 01_basics.ts
│       ├── 02_crud.ts
│       └── 03_relations.ts
└── README.md
```

## 🔒 Connection Details

For your applications, use these connection strings:

**Standard format:**
```
postgresql://learner:learnpass123@localhost:5432/learning_db
```

**Prisma format:**
```
DATABASE_URL="postgresql://learner:learnpass123@localhost:5432/learning_db?schema=public"
```

**Individual parameters:**
```
Host: localhost
Port: 5432
Database: learning_db
User: learner
Password: learnpass123
```

## ❓ Troubleshooting

### "Connection refused" error
Make sure Docker is running and the container is up:
```bash
docker-compose ps
docker-compose up -d
```

### "Database does not exist" error
The init script may not have run. Recreate the container:
```bash
docker-compose down -v
docker-compose up -d
```

### Prisma "Cannot find module" error
Regenerate the Prisma client:
```bash
cd prisma
pnpm prisma:generate
```

### Port 5432 already in use
Another PostgreSQL is running. Either stop it or change the port in `docker-compose.yml`.

## 📖 Next Steps

After completing the lessons:

1. **Try the exercises** in `python/exercises.py`
2. **Build a small project** - a CLI app or web API
3. **Explore advanced topics:**
   - Database migrations with Alembic (Python) or Prisma Migrate
   - Connection pooling
   - Transactions and rollbacks
   - Indexes and query optimization

## 📄 License

MIT License - Feel free to use this for learning!

---

Happy learning! 🎉 If you have questions, check the lesson comments for detailed explanations.
