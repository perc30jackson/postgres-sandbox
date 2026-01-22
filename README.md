# 🐘 PostgreSQL Learning Sandbox

A complete hands-on learning environment for PostgreSQL with **Python** and **Prisma** examples.

**Works on:** Windows 10/11 • macOS (Intel & Apple Silicon) • Linux

---

## 📑 Table of Contents

1. [Prerequisites Setup](#-prerequisites-setup)
   - [Install Docker Desktop](#step-1-install-docker-desktop)
   - [Install Python](#step-2-install-python)
   - [Install Node.js](#step-3-install-nodejs)
   - [Install pnpm](#step-4-install-pnpm)
   - [Install Git](#step-5-install-git)
   - [Install a Code Editor](#step-6-install-a-code-editor)
2. [Getting Started](#-getting-started)
3. [Learning Path: SQL Exercises](#-learning-path-sql-exercises)
4. [Learning Path: Python](#-learning-path-python)
5. [Learning Path: Prisma](#-learning-path-prisma)
6. [Database Schema](#-database-schema)
7. [Useful Commands](#-useful-commands)
8. [Troubleshooting](#-troubleshooting)

---

## 🔧 Prerequisites Setup

Before you can use this learning sandbox, you need to install several tools. Follow each step carefully.

> **💡 Tip:** Already have these installed? Skip to [Getting Started](#-getting-started)

---

### Step 1: Install Docker Desktop

Docker runs the PostgreSQL database in a container (like a lightweight virtual machine).

<details>
<summary><b>🪟 Windows Instructions</b></summary>

1. Go to [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Click **"Download for Windows"**
3. Run the installer (`Docker Desktop Installer.exe`)
4. Follow the installation wizard:
   - ✅ Check "Use WSL 2 instead of Hyper-V" (recommended)
   - Click **Install**
5. **Restart your computer** when prompted
6. After restart, Docker Desktop will start automatically
7. Accept the terms of service

**Verify installation:** Open PowerShell and run:
```powershell
docker --version
```
You should see something like: `Docker version 24.x.x`

</details>

<details>
<summary><b>🍎 macOS Instructions</b></summary>

1. Go to [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Click **"Download for Mac"**
3. **Choose the correct version for your Mac:**
   - **Apple Silicon** (M1, M2, M3, M4 chips) - If your Mac was made 2020 or later
   - **Intel Chip** - For older Macs (pre-2020)
   
   > 💡 Not sure? Click  → **About This Mac** → Look for "Chip" (Apple) or "Processor" (Intel)

4. Open the downloaded `.dmg` file
5. **Drag Docker to the Applications folder**
6. Open **Finder** → **Applications** → Double-click **Docker**
7. Click **Open** if you see a security warning
8. Accept the terms of service
9. Wait for Docker to start (whale icon in menu bar stops animating)

**Verify installation:** Open Terminal (Applications → Utilities → Terminal) and run:
```bash
docker --version
```
You should see something like: `Docker version 24.x.x`

</details>

---

### Step 2: Install Python

Python is needed for the Python learning path.

<details>
<summary><b>🪟 Windows Instructions</b></summary>

1. Go to [https://www.python.org/downloads/](https://www.python.org/downloads/)
2. Click **"Download Python 3.12.x"** (or latest 3.x version)
3. Run the installer
4. **⚠️ CRITICAL:** Check the box **"Add Python to PATH"** at the bottom of the installer!
5. Click **"Install Now"**
6. Click **"Close"** when complete

**Verify installation:** Open a **NEW** PowerShell window and run:
```powershell
python --version
pip --version
```
You should see: `Python 3.12.x` and `pip 23.x.x`

</details>

<details>
<summary><b>🍎 macOS Instructions</b></summary>

**Option A: Official Installer (Recommended for beginners)**

1. Go to [https://www.python.org/downloads/](https://www.python.org/downloads/)
2. Click **"Download Python 3.12.x"**
3. Open the downloaded `.pkg` file
4. Follow the installation wizard (click Continue, Agree, Install)
5. Enter your password when prompted
6. Click **Close** when complete

**Option B: Using Homebrew (if you have it installed)**
```bash
brew install python@3.12
```

**Verify installation:** Open Terminal and run:
```bash
python3 --version
pip3 --version
```
You should see: `Python 3.12.x` and `pip 23.x.x`

> **⚠️ Note for macOS:** Always use `python3` and `pip3` commands (not `python` and `pip`)

</details>

---

### Step 3: Install Node.js

Node.js is needed for the Prisma learning path.

<details>
<summary><b>🪟 Windows Instructions</b></summary>

1. Go to [https://nodejs.org/](https://nodejs.org/)
2. Download the **LTS** version (the green button, recommended for most users)
3. Run the installer (`.msi` file)
4. Accept the license agreement
5. Use the default installation settings (just click Next)
6. Click **Install**
7. Click **Finish**

**Verify installation:** Open a **NEW** PowerShell window and run:
```powershell
node --version
npm --version
```
You should see versions like: `v20.x.x` and `10.x.x`

</details>

<details>
<summary><b>🍎 macOS Instructions</b></summary>

**Option A: Official Installer (Recommended for beginners)**

1. Go to [https://nodejs.org/](https://nodejs.org/)
2. Download the **LTS** version (the green button)
3. Open the downloaded `.pkg` file
4. Follow the installation wizard
5. Enter your password when prompted

**Option B: Using Homebrew (if you have it installed)**
```bash
brew install node
```

**Verify installation:** Open Terminal and run:
```bash
node --version
npm --version
```
You should see versions like: `v20.x.x` and `10.x.x`

</details>

---

### Step 4: Install pnpm

pnpm is a fast package manager for Node.js (better than npm).

<details>
<summary><b>🪟 Windows Instructions</b></summary>

1. Open PowerShell **as Administrator**:
   - Press `Windows` key
   - Type "PowerShell"
   - Right-click "Windows PowerShell"
   - Click "Run as administrator"
   - Click "Yes" on the security prompt

2. Run this command:
```powershell
iwr https://get.pnpm.io/install.ps1 -useb | iex
```

3. **Close PowerShell completely**
4. Open a **NEW** PowerShell window (regular, not admin)

**Verify installation:**
```powershell
pnpm --version
```
You should see: `8.x.x` or higher

</details>

<details>
<summary><b>🍎 macOS Instructions</b></summary>

1. Open Terminal (Applications → Utilities → Terminal)

2. Run this command:
```bash
curl -fsSL https://get.pnpm.io/install.sh | sh -
```

3. **Important:** The installer will tell you to add pnpm to your PATH. 
   
   For **zsh** (default on modern macOS), run:
```bash
source ~/.zshrc
```

   For **bash**, run:
```bash
source ~/.bashrc
```

   Or simply **close and reopen Terminal**.

**Verify installation:**
```bash
pnpm --version
```
You should see: `8.x.x` or higher

</details>

---

### Step 5: Install Git

Git is needed to clone repositories and track changes.

<details>
<summary><b>🪟 Windows Instructions</b></summary>

1. Go to [https://git-scm.com/download/windows](https://git-scm.com/download/windows)
2. Download will start automatically (click the link if it doesn't)
3. Run the installer
4. **Use all the default options** (just keep clicking Next)
5. Click **Install**
6. Click **Finish**

**Verify installation:** Open a **NEW** PowerShell window:
```powershell
git --version
```
You should see: `git version 2.x.x`

</details>

<details>
<summary><b>🍎 macOS Instructions</b></summary>

Git comes pre-installed on macOS, but you may need to install Command Line Tools.

**Check if Git is installed:**
```bash
git --version
```

If you see a version number, you're done! ✅

If you see a popup asking to install Command Line Tools:
1. Click **Install**
2. Wait for the installation to complete (may take a few minutes)
3. Click **Done**

**Alternative: Install via Homebrew**
```bash
brew install git
```

**Verify installation:**
```bash
git --version
```
You should see: `git version 2.x.x`

</details>

---

### Step 6: Install a Code Editor

We recommend Visual Studio Code.

<details>
<summary><b>🪟 Windows Instructions</b></summary>

1. Go to [https://code.visualstudio.com/](https://code.visualstudio.com/)
2. Click **"Download for Windows"**
3. Run the installer
4. Accept the agreement
5. ✅ Check **"Add to PATH"** (important!)
6. ✅ Check **"Add 'Open with Code' action"** (optional but useful)
7. Click **Install**
8. Click **Finish**

</details>

<details>
<summary><b>🍎 macOS Instructions</b></summary>

1. Go to [https://code.visualstudio.com/](https://code.visualstudio.com/)
2. Click **"Download for Mac"**
3. Open the downloaded `.zip` file (it auto-extracts)
4. **Drag "Visual Studio Code" to the Applications folder**
5. Open VS Code from Applications
6. If you see a security warning, click **Open**

**Add `code` command to Terminal (optional but useful):**
1. Open VS Code
2. Press `Cmd + Shift + P` to open Command Palette
3. Type: `shell command`
4. Select: **"Shell Command: Install 'code' command in PATH"**
5. Now you can open folders by typing `code .` in Terminal

</details>

**Recommended VS Code Extensions:**
- PostgreSQL (by Chris Kolkman)
- Python (by Microsoft)  
- Prisma (by Prisma)

---

## 🚀 Getting Started

Now that you have all prerequisites installed, let's set up the learning environment!

### Step 1: Clone or Navigate to the Project

<details>
<summary><b>🪟 Windows (PowerShell)</b></summary>

```powershell
# If you already have the project, navigate to it:
cd "C:\path\to\postgres-sandbox"

# Or clone it from GitHub:
git clone https://github.com/YOUR_USERNAME/postgres-sandbox.git
cd postgres-sandbox

# Open in VS Code:
code .
```

</details>

<details>
<summary><b>🍎 macOS (Terminal)</b></summary>

```bash
# If you already have the project, navigate to it:
cd ~/path/to/postgres-sandbox

# Or clone it from GitHub:
git clone https://github.com/YOUR_USERNAME/postgres-sandbox.git
cd postgres-sandbox

# Open in VS Code:
code .
```

</details>

---

### Step 2: Start Docker Desktop

| Windows | macOS |
|---------|-------|
| Check system tray (bottom right) for Docker icon | Check menu bar (top right) for whale icon 🐳 |
| If not running, search "Docker Desktop" and open it | If not running, open from Applications |
| Wait until it says "Docker Desktop is running" | Wait until whale icon stops animating |

---

### Step 3: Start the PostgreSQL Database

Open a terminal in the project folder and run:

<details>
<summary><b>🪟 Windows (PowerShell)</b></summary>

```powershell
# Start the database container
docker-compose up -d

# Verify it's running
docker-compose ps
```

</details>

<details>
<summary><b>🍎 macOS (Terminal)</b></summary>

```bash
# Start the database container
docker-compose up -d

# Verify it's running
docker-compose ps
```

</details>

**What this does:**
- Downloads PostgreSQL 16 (first time only, ~150MB)
- Creates a container named `learning_postgres`
- Sets up the sample bookstore database with data
- Runs on port 5432

**Expected output:**
```
NAME               STATUS         PORTS
learning_postgres  Up (healthy)   0.0.0.0:5432->5432/tcp
```

---

### Step 4: Connect to the Database

Test the connection:

<details>
<summary><b>🪟 Windows (PowerShell)</b></summary>

```powershell
docker exec -it learning_postgres psql -U learner -d learning_db
```

</details>

<details>
<summary><b>🍎 macOS (Terminal)</b></summary>

```bash
docker exec -it learning_postgres psql -U learner -d learning_db
```

</details>

You should see:
```
learning_db=#
```

Try a test query:
```sql
SELECT * FROM authors;
```

Type `\q` to exit.

🎉 **Congratulations!** Your database is ready!

---

## 📝 Learning Path: SQL Exercises

This is the recommended starting point for beginners!

### Step 1: Connect to PostgreSQL

<details>
<summary><b>🪟 Windows (PowerShell)</b></summary>

```powershell
docker exec -it learning_postgres psql -U learner -d learning_db
```

</details>

<details>
<summary><b>🍎 macOS (Terminal)</b></summary>

```bash
docker exec -it learning_postgres psql -U learner -d learning_db
```

</details>

### Step 2: Open the Exercise Files

Open these files in your code editor:
- `sql/exercises.sql` - 50+ exercises organized by difficulty
- `sql/cheatsheet.sql` - Quick reference for SQL syntax

### Step 3: Work Through the Exercises

The exercises are organized into 15 levels:

| Level | Topic | Time Estimate |
|-------|-------|---------------|
| 1 | SELECT Basics | 15 min |
| 2 | WHERE Filtering | 20 min |
| 3 | ORDER BY & LIMIT | 15 min |
| 4 | DISTINCT & Aliases | 15 min |
| 5 | Aggregates (COUNT, SUM) | 20 min |
| 6 | GROUP BY | 25 min |
| 7 | HAVING | 15 min |
| 8 | INNER JOIN | 30 min |
| 9 | LEFT JOIN | 20 min |
| 10 | Complex JOINs | 30 min |
| 11 | Subqueries | 30 min |
| 12 | CASE Expressions | 20 min |
| 13 | Date Functions | 15 min |
| 14 | INSERT/UPDATE/DELETE | 20 min |
| 15 | Challenge Problems | 60 min |

### Step 4: Check Your Answers

Answers are at the bottom of `sql/exercises.sql` - scroll down when ready!

---

## 🐍 Learning Path: Python

Learn to interact with PostgreSQL using Python.

### Step 1: Navigate to Python Folder

<details>
<summary><b>🪟 Windows (PowerShell)</b></summary>

```powershell
cd python
```

</details>

<details>
<summary><b>🍎 macOS (Terminal)</b></summary>

```bash
cd python
```

</details>

### Step 2: Create and Activate Virtual Environment

<details>
<summary><b>🪟 Windows (PowerShell)</b></summary>

```powershell
# Create the virtual environment
python -m venv venv

# Activate it
.\venv\Scripts\Activate

# You should see (venv) at the start of your prompt
```

</details>

<details>
<summary><b>🍎 macOS (Terminal)</b></summary>

```bash
# Create the virtual environment
python3 -m venv venv

# Activate it
source venv/bin/activate

# You should see (venv) at the start of your prompt
```

</details>

### Step 3: Install Dependencies

<details>
<summary><b>🪟 Windows (PowerShell)</b></summary>

```powershell
pip install -r requirements.txt
```

</details>

<details>
<summary><b>🍎 macOS (Terminal)</b></summary>

```bash
pip3 install -r requirements.txt
```

</details>

This installs:
- `psycopg2-binary` - PostgreSQL driver
- `sqlalchemy` - ORM (Object-Relational Mapper)
- `pandas` - Data manipulation

### Step 4: Run the Lessons

<details>
<summary><b>🪟 Windows (PowerShell)</b></summary>

```powershell
# Lesson 1: Basic Connection
python 01_basic_connection.py

# Lesson 2: CRUD Operations
python 02_crud_operations.py

# Lesson 3: SQLAlchemy ORM
python 03_sqlalchemy_intro.py

# Practice Exercises
python exercises.py
```

</details>

<details>
<summary><b>🍎 macOS (Terminal)</b></summary>

```bash
# Lesson 1: Basic Connection
python3 01_basic_connection.py

# Lesson 2: CRUD Operations
python3 02_crud_operations.py

# Lesson 3: SQLAlchemy ORM
python3 03_sqlalchemy_intro.py

# Practice Exercises
python3 exercises.py
```

</details>

### Step 5: Deactivate When Done

```bash
deactivate
```

---

## 🔷 Learning Path: Prisma

Learn modern TypeScript database access with Prisma ORM.

### Step 1: Navigate to Prisma Folder

```bash
cd prisma
```

### Step 2: Create Environment File

<details>
<summary><b>🪟 Windows (PowerShell)</b></summary>

```powershell
copy .env-template .env
```

</details>

<details>
<summary><b>🍎 macOS (Terminal)</b></summary>

```bash
cp .env-template .env
```

</details>

### Step 3: Install Dependencies

```bash
pnpm install
```

### Step 4: Generate Prisma Client

```bash
pnpm prisma:generate
```

### Step 5: Run the Lessons

```bash
# Overview and connection test
pnpm dev

# Lesson 1: Basic Queries
pnpm lesson:basics

# Lesson 2: CRUD Operations  
pnpm lesson:crud

# Lesson 3: Relationships
pnpm lesson:relations
```

### Step 6: Explore with Prisma Studio

```bash
pnpm prisma:studio
```

This opens a visual database browser at `http://localhost:5555`

---

## 🗄️ Database Schema

The sample database is a **bookstore** with the following tables:

```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│   authors   │──────▶│    books    │◀──────│ categories  │
│             │       │             │       │             │
│ id          │       │ id          │       │ id          │
│ name        │       │ title       │       │ name        │
│ email       │       │ isbn        │       │ description │
│ bio         │       │ price       │       └─────────────┘
│ birth_year  │       │ stock_qty   │
└─────────────┘       │ author_id   │
                      │ category_id │
                      └──────┬──────┘
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
       ┌──────────┐   ┌──────────┐   ┌──────────────┐
       │ reviews  │   │  orders  │   │ order_items  │
       │          │   │          │   │              │
       │ book_id  │   │ order_id │◀──│ order_id     │
       │ customer │   │ customer │   │ book_id      │
       │ rating   │   │ status   │   │ quantity     │
       │ comment  │   │ total    │   │ price        │
       └──────────┘   └────┬─────┘   └──────────────┘
                           │
                           ▼
                    ┌─────────────┐
                    │  customers  │
                    │             │
                    │ id          │
                    │ first_name  │
                    │ last_name   │
                    │ email       │
                    │ phone       │
                    └─────────────┘
```

### Sample Data Included

- **5 Authors**: J.K. Rowling, George Orwell, Jane Austen, etc.
- **8 Books**: Harry Potter, 1984, Pride and Prejudice, etc.
- **5 Categories**: Fiction, Mystery, Romance, etc.
- **5 Customers**: With orders and reviews
- **5 Orders**: Various statuses
- **6 Reviews**: Book ratings and comments

---

## 📋 Useful Commands

### Docker Commands (Same for Windows & macOS)

```bash
# Start the database
docker-compose up -d

# Stop the database (keeps data)
docker-compose stop

# View logs
docker-compose logs -f postgres

# Restart the database
docker-compose restart

# Stop and DELETE all data
docker-compose down -v

# Check status
docker-compose ps
```

### PostgreSQL Commands (Same for Windows & macOS)

```bash
# Connect to database
docker exec -it learning_postgres psql -U learner -d learning_db

# Inside psql:
\dt          # List all tables
\d books     # Describe the books table
\l           # List all databases
\q           # Quit psql
```

### Python Commands

| Action | Windows | macOS |
|--------|---------|-------|
| Create venv | `python -m venv venv` | `python3 -m venv venv` |
| Activate venv | `.\venv\Scripts\Activate` | `source venv/bin/activate` |
| Run script | `python script.py` | `python3 script.py` |
| Install packages | `pip install -r requirements.txt` | `pip3 install -r requirements.txt` |
| Deactivate | `deactivate` | `deactivate` |

### Prisma Commands (Same for Windows & macOS)

```bash
cd prisma

# Run lessons
pnpm lesson:basics
pnpm lesson:crud
pnpm lesson:relations

# Prisma tools
pnpm prisma:generate   # Generate client
pnpm prisma:studio     # Visual browser
pnpm prisma:introspect # Pull schema from database
```

---

## ❓ Troubleshooting

### 🪟 Windows Issues

<details>
<summary><b>"python is not recognized"</b></summary>

**Symptom:** PowerShell doesn't find Python

**Solution:**
1. Reinstall Python from [python.org](https://www.python.org/downloads/)
2. **⚠️ Check "Add Python to PATH"** at the bottom of the installer
3. Close ALL PowerShell windows
4. Open a NEW PowerShell window

</details>

<details>
<summary><b>"pnpm is not recognized"</b></summary>

**Symptom:** PowerShell doesn't find pnpm

**Solution:**
1. Close all PowerShell windows
2. Open a NEW PowerShell **as Administrator**
3. Reinstall pnpm:
```powershell
iwr https://get.pnpm.io/install.ps1 -useb | iex
```
4. Close PowerShell and open a new regular window

</details>

<details>
<summary><b>Virtual environment won't activate</b></summary>

**Symptom:** `.\venv\Scripts\Activate` gives an error about scripts being disabled

**Solution:** Run this once as Administrator:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

</details>

---

### 🍎 macOS Issues

<details>
<summary><b>"python3: command not found"</b></summary>

**Symptom:** Terminal doesn't find Python

**Solution:**
1. Install Xcode Command Line Tools:
```bash
xcode-select --install
```
2. Or install Python from [python.org](https://www.python.org/downloads/)

</details>

<details>
<summary><b>"pnpm: command not found"</b></summary>

**Symptom:** Terminal doesn't find pnpm after installation

**Solution:** Add pnpm to your PATH:
```bash
# For zsh (default on modern macOS)
echo 'export PNPM_HOME="$HOME/Library/pnpm"' >> ~/.zshrc
echo 'export PATH="$PNPM_HOME:$PATH"' >> ~/.zshrc
source ~/.zshrc

# For bash
echo 'export PNPM_HOME="$HOME/Library/pnpm"' >> ~/.bashrc
echo 'export PATH="$PNPM_HOME:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

</details>

<details>
<summary><b>"Error: pg_config executable not found" when installing psycopg2</b></summary>

**Symptom:** `pip install psycopg2-binary` fails

**Solution:** We use `psycopg2-binary` which should work. If not:
```bash
# Install with Homebrew
brew install postgresql

# Then retry
pip3 install -r requirements.txt
```

</details>

<details>
<summary><b>Docker says "Cannot connect to Docker daemon"</b></summary>

**Symptom:** Docker commands fail

**Solution:**
1. Make sure Docker Desktop is running (whale icon in menu bar)
2. If whale is there but commands fail, restart Docker Desktop:
   - Click whale icon → Restart
3. Wait until whale stops animating

</details>

---

### 🪟🍎 Common Issues (Both Platforms)

<details>
<summary><b>"Port 5432 already in use"</b></summary>

**Symptom:** Container won't start, port conflict error

**Solution:** Another PostgreSQL is using port 5432. Either:

1. Stop the other PostgreSQL service, or
2. Change the port in `docker-compose.yml`:
```yaml
ports:
  - "5433:5432"  # Use 5433 instead
```
Then update all connection strings to use port 5433.

</details>

<details>
<summary><b>"Connection refused" when running Python/Prisma</b></summary>

**Symptom:** Scripts can't connect to database

**Solution:**
1. Check if Docker container is running:
```bash
docker-compose ps
```
2. If not running, start it:
```bash
docker-compose up -d
```
3. Wait 10 seconds for database to initialize

</details>

<details>
<summary><b>Database is empty / tables don't exist</b></summary>

**Symptom:** Queries fail with "table does not exist"

**Solution:** Recreate the database:
```bash
docker-compose down -v
docker-compose up -d
```
Wait 10 seconds, then reconnect.

</details>

<details>
<summary><b>Prisma "Cannot find module '@prisma/client'"</b></summary>

**Symptom:** Prisma lessons won't run

**Solution:**
```bash
cd prisma
pnpm install
pnpm prisma:generate
```

</details>

---

## 🎯 Recommended Learning Order

1. **Week 1:** SQL Exercises (Levels 1-7)
2. **Week 2:** SQL Exercises (Levels 8-15)
3. **Week 3:** Python Lessons (all 3 + exercises)
4. **Week 4:** Prisma Lessons (all 3)
5. **Week 5+:** Build your own project!

---

## 📚 Additional Resources

- [PostgreSQL Official Docs](https://www.postgresql.org/docs/)
- [SQLBolt - Interactive SQL Tutorial](https://sqlbolt.com/)
- [Prisma Documentation](https://www.prisma.io/docs)
- [SQLAlchemy Documentation](https://docs.sqlalchemy.org/)

---

## 🔌 Connection Details

Use these settings to connect from any application:

| Setting | Value |
|---------|-------|
| Host | `localhost` |
| Port | `5432` |
| Database | `learning_db` |
| Username | `learner` |
| Password | `learnpass123` |

**Connection String:**
```
postgresql://learner:learnpass123@localhost:5432/learning_db
```

---

## 📁 Project Structure

```
postgres-sandbox/
├── docker-compose.yml          # PostgreSQL container config
├── README.md                   # This file
├── sql/
│   ├── init.sql               # Database schema & seed data
│   ├── exercises.sql          # 50+ SQL practice exercises
│   └── cheatsheet.sql         # SQL quick reference
├── python/
│   ├── requirements.txt       # Python dependencies
│   ├── 01_basic_connection.py # Lesson 1
│   ├── 02_crud_operations.py  # Lesson 2
│   ├── 03_sqlalchemy_intro.py # Lesson 3
│   └── exercises.py           # Python practice problems
└── prisma/
    ├── package.json           # Node.js dependencies
    ├── tsconfig.json          # TypeScript config
    ├── .env-template          # Environment template
    ├── prisma/
    │   └── schema.prisma      # Prisma schema
    └── src/
        ├── index.ts           # Main entry point
        ├── 01_basics.ts       # Lesson 1
        ├── 02_crud.ts         # Lesson 2
        └── 03_relations.ts    # Lesson 3
```

---

Happy learning! 🎉
