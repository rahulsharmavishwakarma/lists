# 📋 Notion-Style Todo List

A world-class, feature-rich todo list application inspired by Notion, built with FastAPI, PostgreSQL/SQLite, and modern web technologies.

## ✨ Features

- **🎨 Beautiful Notion-Inspired UI**: Clean, modern interface with smooth animations
- **📝 Rich Task Management**: Create, edit, delete, and organize tasks
- **🏷️ Tags System**: Organize tasks with customizable color-coded tags
- **🎯 Priority Levels**: Set task priorities (High, Medium, Low) with visual indicators
- **📅 Due Dates**: Set and track due dates with overdue highlighting
- **✅ Subtasks**: Break down tasks into smaller, manageable subtasks
- **🔍 Search & Filter**: Find tasks quickly with search and powerful filters
- **📊 Statistics**: Track task completion with real-time statistics
- **🖱️ Drag & Drop**: Reorder tasks with intuitive drag and drop
- **📱 Responsive Design**: Works perfectly on desktop, tablet, and mobile
- **💾 Multi-Database Support**: SQLite for development, PostgreSQL for production/scaling
- **🚀 FastAPI Backend**: High-performance REST API
- **⚡ Real-time Updates**: Instant feedback on all actions

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [README.md](README.md) | Main documentation and setup guide |
| [API.md](docs/API.md) | Complete API reference |
| [ARCHITECTURE.md](docs/ARCHITECTURE.md) | System architecture and design |
| [USER_GUIDE.md](docs/USER_GUIDE.md) | User guide and tips |
| [DEPLOYMENT.md](DEPLOYMENT.md) | Deployment instructions |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines |
| [CHANGELOG.md](CHANGELOG.md) | Version history and changes |

## 🛠️ Tech Stack

### Backend
- **FastAPI**: Modern, fast web framework for building APIs
- **SQLAlchemy**: Powerful ORM for database operations
- **Pydantic**: Data validation using Python type annotations
- **PostgreSQL**: Robust, scalable database (production)
- **SQLite**: Lightweight, serverless database (development)

### Frontend
- **Pure HTML5**: Semantic, accessible markup
- **Modern CSS3**: Responsive design with CSS variables and Flexbox/Grid
- **Vanilla JavaScript**: No framework dependencies, pure JS for performance

### DevOps
- **Docker**: Containerization for easy deployment
- **Docker Compose**: Multi-container orchestration
- **Make**: Build automation and task runner

## 📦 Installation

### Prerequisites
- Python 3.8 or higher
- pip (Python package manager)
- Docker & Docker Compose (for PostgreSQL setup)

### Quick Start with Make

```bash
# Clone repository
git clone <repository-url>
cd To_do_list

# Install dependencies and setup
make setup

# Run development server (SQLite)
make dev

# Or run with PostgreSQL
make dev-postgres
```

### Manual Setup

1. **Navigate to the project directory**:
```bash
cd /workspaces/To_do_list
```

2. **Create a virtual environment** (recommended):
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. **Install dependencies**:
```bash
pip install -r requirements.txt
```

4. **Configure environment**:
```bash
cp .env.example .env
# Edit .env to set DATABASE_URL
```

5. **Run the application**:
```bash
# For SQLite (development)
make dev

# Or with uvicorn directly
uvicorn backend.main:app --reload --host 0.0.0.0 --port 8000
```

6. **Open your browser**:
Navigate to `http://localhost:8000` to access the application

## 🐳 Docker Deployment

### Development with PostgreSQL

```bash
# Start PostgreSQL and application
docker-compose up -d

# View logs
docker-compose logs -f

# Stop containers
docker-compose down
```

### Production with Docker

```bash
# Build and start all services
make docker-up

# Stop and remove containers
make docker-down

# Remove containers and volumes (complete cleanup)
make docker-clean
```

## 🚀 Running the Application

### Development Mode (SQLite)
```bash
make dev
```

### Development Mode (PostgreSQL)
```bash
make dev-postgres
```

### Production Mode
```bash
make run
```

### Accessing the API Documentation
- **Swagger UI**: `http://localhost:8000/docs`
- **ReDoc**: `http://localhost:8000/redoc`

## 📂 Project Structure

```
To_do_list/
├── backend/                   # Backend application
│   ├── __init__.py
│   ├── main.py                 # FastAPI application entry point
│   ├── models/
│   │   ├── __init__.py
│   │   └── database.py         # SQLAlchemy database models
│   ├── routes/
│   │   ├── __init__.py
│   │   ├── todos.py            # Todo API endpoints
│   │   └── tags.py             # Tags API endpoints
│   ├── schemas/
│   │   ├── __init__.py
│   │   └── schemas.py          # Pydantic schemas
│   └── utils/
│       ├── __init__.py
│       └── database.py         # Database connection utilities
├── frontend/                  # Frontend application
│   ├── index.html              # Main HTML page
│   ├── css/
│   │   └── styles.css          # Application styles
│   └── js/
│       └── app.js              # Frontend JavaScript logic
├── tests/                     # Test suite
│   └── test_api.py            # API tests
├── docs/                      # Documentation
│   ├── API.md                 # API reference
│   ├── ARCHITECTURE.md        # Architecture documentation
│   └── USER_GUIDE.md         # User guide
├── .env                       # Environment variables (create from .env.example)
├── .env.example               # Example environment variables
├── .dockerignore              # Docker ignore patterns
├── .gitignore                # Git ignore patterns
├── Dockerfile                 # Docker image configuration
├── docker-compose.yml        # Docker Compose configuration
├── Makefile                 # Build automation
├── requirements.txt         # Python dependencies
├── README.md              # This file
├── CONTRIBUTING.md        # Contribution guidelines
├── DEPLOYMENT.md        # Deployment guide
└── CHANGELOG.md          # Version history
```

## 🎯 API Endpoints

### Todos
- `GET /api/todos/` - List all todos (with optional filtering)
- `GET /api/todos/{id}` - Get a specific todo
- `POST /api/todos/` - Create a new todo
- `PUT /api/todos/{id}` - Update a todo
- `DELETE /api/todos/{id}` - Delete a todo
- `PATCH /api/todos/{id}/toggle` - Toggle todo completion
- `POST /api/todos/{id}/reorder` - Reorder todos

### Subtasks
- `GET /api/todos/{id}/subtasks` - List subtasks for a todo
- `POST /api/todos/{id}/subtasks` - Create a subtask
- `PUT /api/todos/subtasks/{id}` - Update a subtask
- `DELETE /api/todos/subtasks/{id}` - Delete a subtask
- `PATCH /api/todos/subtasks/{id}/toggle` - Toggle subtask completion

### Tags
- `GET /api/tags/` - List all tags
- `POST /api/tags/` - Create a new tag
- `DELETE /api/tags/{id}` - Delete a tag

## 💡 Usage Guide

See [USER_GUIDE.md](docs/USER_GUIDE.md) for detailed usage instructions and tips.

### Quick Start
1. Click the "Add a new task" button
2. Fill in the task details (title is required)
3. Optionally add description, priority, due date, tags, and subtasks
4. Click "Save Task"

### Managing Tasks
- **Toggle completion**: Click the checkbox next to a task
- **Edit task**: Click the "Edit" button on a task card
- **Delete task**: Click the "Delete" button on a task card
- **Reorder tasks**: Drag and drop tasks to reorder them

## 🔧 Configuration

### Database Configuration

#### SQLite (Development)
Edit `.env` file:
```
DATABASE_URL=sqlite:///./todos.db
```

#### PostgreSQL (Production)
Edit `.env` file:
```
DATABASE_URL=postgresql://todo_user:todo_password@postgres:5432/todo_db
POSTGRES_USER=todo_user
POSTGRES_PASSWORD=todo_password
POSTGRES_DB=todo_db
```

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DATABASE_URL` | Database connection string | `sqlite:///./todos.db` |
| `POSTGRES_USER` | PostgreSQL username | `todo_user` |
| `POSTGRES_PASSWORD` | PostgreSQL password | `todo_password` |
| `POSTGRES_DB` | PostgreSQL database name | `todo_db` |
| `HOST` | Server host | `0.0.0.0` |
| `PORT` | Server port | `8000` |

### CORS
The application allows all origins by default. For production, update the CORS configuration in `backend/main.py`.

## 📊 Database Schema

See [ARCHITECTURE.md](docs/ARCHITECTURE.md) for detailed database schema and ER diagrams.

### Tables
- **todos**: Main task records
- **subtasks**: Subtask records linked to todos
- **tags**: Tag definitions
- **todo_tags**: Many-to-many relationship between todos and tags

## 🎨 Customization

### Styling
Modify `frontend/css/styles.css` to customize the application's appearance. The CSS uses CSS variables for easy theming.

### Colors
Update the `:root` variables in `styles.css` to change the color scheme:
```css
:root {
    --accent-color: #2383E2;
    --bg-color: #FFFFFF;
    --text-primary: #37352F;
    /* ... */
}
```

## 🧪 Testing

```bash
# Run tests
make test

# Run with coverage
pytest tests/ --cov=backend --cov-report=html
```

## 🔧 Development Tasks

```bash
# Lint code
make lint

# Format code
make format

# Reset database
make db-reset

# Run database migrations
make db-migrate

# Clean temporary files
make clean

# Show all available commands
make help
```

## 🚀 Deployment

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed deployment instructions and cloud deployment options.

### Quick Deploy with Docker

```bash
# Build image
make docker-build

# Start services
make docker-up

# Check logs
make docker-logs
```

### Manual Deployment

1. Set `DATABASE_URL` to PostgreSQL connection string
2. Install dependencies: `pip install -r requirements.txt`
3. Run with multiple workers: `uvicorn backend.main:app --workers 4 --host 0.0.0.0 --port 8000`

## 📝 License

This project is licensed under the MIT License.

## 🤝 Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📖 Resources

- **[API Documentation](docs/API.md)** - Complete API reference
- **[Architecture Docs](docs/ARCHITECTURE.md)** - System design and architecture
- **[User Guide](docs/USER_GUIDE.md)** - How to use the application
- **[Deployment Guide](DEPLOYMENT.md)** - Production deployment instructions
- **[Changelog](CHANGELOG.md)** - Version history and changes

## 🙏 Acknowledgments

- Inspired by [Notion](https://www.notion.so/)
- Built with [FastAPI](https://fastapi.tiangolo.com/)
- Styled with modern CSS principles

---

**Enjoy managing your tasks with style! 🚀**
