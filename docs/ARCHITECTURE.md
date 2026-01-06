# Architecture Documentation

This document describes the architecture and design decisions for the Notion-Style Todo List application.

## Table of Contents

- [System Overview](#system-overview)
- [Architecture Diagram](#architecture-diagram)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Database Design](#database-design)
- [API Design](#api-design)
- [Frontend Architecture](#frontend-architecture)
- [Security Considerations](#security-considerations)
- [Scalability](#scalability)
- [Performance Optimization](#performance-optimization)

---

## System Overview

The Notion-Style Todo List is a **client-server web application** with the following characteristics:

- **Single-page application (SPA)** frontend
- **RESTful API** backend
- **Separation of concerns** between frontend and backend
- **Stateless API** design
- **Database-driven** persistence

### Key Principles

1. **Simplicity**: Keep the codebase clean and maintainable
2. **Performance**: Fast response times and efficient queries
3. **Scalability**: Ready for growth from SQLite to PostgreSQL
4. **Developer Experience**: Easy to understand and extend

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        Client Layer                          │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐      │
│  │   Desktop  │  │   Mobile   │  │   Tablet  │      │
│  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘      │
└─────────┼────────────────┼────────────────┼───────────────┘
          │                │                │
          └────────────────┴────────────────┘
                           │
                    ┌──────▼──────┐
                    │   Browser   │
                    │  (HTML/CSS/ │
                    │   JS App)   │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │   FastAPI    │
                    │   Backend    │
                    └──────┬──────┘
                           │
          ┌──────────────────┼──────────────────┐
          │                  │                  │
    ┌─────▼─────┐    ┌─────▼─────┐   ┌─────▼─────┐
    │   Todos    │    │   Tags     │   │  Subtasks  │
    │   Routes   │    │   Routes   │   │   Routes   │
    └─────┬─────┘    └─────┬─────┘   └─────┬─────┘
          │                  │                  │
          └──────────────────┴──────────────────┘
                           │
                    ┌──────▼──────┐
                    │  SQLAlchemy  │
                    │     ORM      │
                    └──────┬──────┘
                           │
          ┌──────────────────┼──────────────────┐
          │                  │                  │
    ┌─────▼─────┐    ┌─────▼─────┐   ┌─────▼─────┐
    │  SQLite    │    │ PostgreSQL │   │   MySQL    │
    │ (Dev/Test)│    │ (Production)│  │ (Future)   │
    └───────────┘    └────────────┘   └────────────┘
```

---

## Technology Stack

### Backend

| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Web Framework** | FastAPI 0.104.1 | High-performance API framework |
| **ORM** | SQLAlchemy 2.0.23 | Database abstraction layer |
| **Validation** | Pydantic 2.5.0 | Data validation and serialization |
| **Server** | Uvicorn 0.24.0 | ASGI server |
| **Database** | SQLite / PostgreSQL | Data persistence |

**Why FastAPI?**
- Fast performance (comparable to NodeJS and Go)
- Automatic API documentation (Swagger/ReDoc)
- Type hints and validation out of the box
- Modern async support
- Growing ecosystem

**Why SQLAlchemy?**
- Powerful ORM with flexibility
- Database-agnostic design
- Easy migration between databases
- Strong community support
- Excellent documentation

### Frontend

| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Structure** | HTML5 | Semantic markup |
| **Styling** | CSS3 | Visual presentation |
| **Logic** | Vanilla JavaScript | Interactivity |
| **Icons** | Emoji / SVG | Visual elements |

**Why Vanilla JavaScript?**
- No framework overhead
- Faster initial load
- Easier to understand
- No build step required
- Lightweight and performant

### DevOps

| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Containerization** | Docker | Consistent environments |
| **Orchestration** | Docker Compose | Multi-container apps |
| **Build Tool** | Make | Task automation |
| **Testing** | Pytest | Automated testing |
| **Code Quality** | Black, Ruff, isort | Linting and formatting |

---

## Project Structure

```
To_do_list/
│
├── backend/                      # Backend application
│   ├── __init__.py              # Package initialization
│   ├── main.py                  # FastAPI application entry point
│   │
│   ├── models/                  # Database models
│   │   ├── __init__.py
│   │   └── database.py         # SQLAlchemy models (Todo, Tag, Subtask)
│   │
│   ├── routes/                  # API endpoints
│   │   ├── __init__.py
│   │   ├── todos.py            # Todo CRUD endpoints
│   │   └── tags.py             # Tag management endpoints
│   │
│   ├── schemas/                 # Pydantic schemas
│   │   ├── __init__.py
│   │   └── schemas.py          # Request/Response models
│   │
│   └── utils/                  # Utility functions
│       ├── __init__.py
│       └── database.py         # Database connection management
│
├── frontend/                    # Frontend application
│   ├── index.html               # Main HTML page
│   ├── css/                    # Stylesheets
│   │   └── styles.css          # Application styles
│   └── js/                     # JavaScript
│       └── app.js              # Frontend logic
│
├── tests/                       # Test suite
│   └── test_api.py            # API tests
│
├── docs/                       # Documentation
│   ├── API.md                 # API reference
│   ├── ARCHITECTURE.md        # This file
│   └── ...
│
├── .env                        # Environment variables (local)
├── .env.example                # Environment variables template
├── .gitignore                  # Git ignore patterns
├── .dockerignore               # Docker ignore patterns
├── Dockerfile                  # Docker image configuration
├── docker-compose.yml          # Docker Compose configuration
├── requirements.txt            # Python dependencies
├── Makefile                  # Build automation
├── run.sh                    # Quick start script
├── README.md                 # Main documentation
├── CONTRIBUTING.md            # Contribution guidelines
└── DEPLOYMENT.md            # Deployment guide
```

### Backend Architecture

```
┌─────────────────────────────────────┐
│         main.py                  │
│    (Application Entry Point)       │
└──────────────┬──────────────────┘
               │
      ┌────────┴────────┐
      │                 │
┌─────▼─────┐   ┌─────▼─────┐
│   Routes  │   │  Middle   │
│           │   │  ware     │
│  /todos/  │   │  (CORS)  │
│  /tags/   │   └───────────┘
└─────┬─────┘
      │
      ├─────────┬──────────┐
      │         │          │
┌─────▼─────┐ ┌─▼──────┐ ┌─▼──────┐
│ Schemas   │ │ Models │ │ Utils   │
│ (Pydantic)│ │(SQLA.)│ │ (DB)    │
└───────────┘ └────────┘ └────────┘
```

### Frontend Architecture

```
┌─────────────────────────────────────┐
│        index.html                │
│   (DOM Structure)              │
└──────────────┬──────────────────┘
               │
      ┌────────┴────────┐
      │                 │
┌─────▼─────┐   ┌─────▼─────┐
│   CSS     │   │   JS      │
│  styles   │   │   app     │
│  (View)   │   │ (Logic)   │
└───────────┘   └─────┬─────┘
                        │
              ┌─────────┴─────────┐
              │                   │
        ┌─────▼─────┐     ┌─────▼─────┐
        │   State   │     │   API     │
        │Management │     │  Calls    │
        └───────────┘     └───────────┘
```

---

## Database Design

### ER Diagram

```
┌─────────────┐         ┌──────────────┐
│    Tags     │         │    Todos     │
├─────────────┤         ├──────────────┤
│ id (PK)    │◄──────►│ id (PK)      │
│ name        │         │ title        │
│ color       │         │ description  │
└─────────────┘         │ completed    │
                       │ priority     │
                       │ due_date     │
                       │ position     │
                       │ created_at   │
                       │ updated_at   │
                       └──────┬──────┘
                              │
                              │ 1
                              │
                              │
                       ┌──────────────┐
                       │  Subtasks   │
                       ├──────────────┤
                       │ id (PK)      │
                       │ title        │
                       │ completed    │
                       │ position     │
                       │ parent_id   │
                       │ created_at   │
                       └──────────────┘
```

### Table Relationships

**Many-to-Many: Todos ↔ Tags**
- A todo can have multiple tags
- A tag can belong to multiple todos
- Junction table: `todo_tags`

**One-to-Many: Todos ↔ Subtasks**
- A todo can have multiple subtasks
- A subtask belongs to exactly one todo
- Foreign key: `parent_todo_id` in `subtasks`

### Database Schema

#### Todos Table
```sql
CREATE TABLE todos (
    id INTEGER PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    completed BOOLEAN DEFAULT FALSE,
    priority VARCHAR(10) DEFAULT 'medium',
    due_date DATETIME,
    position INTEGER DEFAULT 0,
    created_at DATETIME,
    updated_at DATETIME
);
```

#### Subtasks Table
```sql
CREATE TABLE subtasks (
    id INTEGER PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    completed BOOLEAN DEFAULT FALSE,
    position INTEGER DEFAULT 0,
    parent_todo_id INTEGER REFERENCES todos(id) ON DELETE CASCADE,
    created_at DATETIME
);
```

#### Tags Table
```sql
CREATE TABLE tags (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    color VARCHAR(7)
);
```

#### Todo_Tags Table (Junction)
```sql
CREATE TABLE todo_tags (
    todo_id INTEGER REFERENCES todos(id) ON DELETE CASCADE,
    tag_id INTEGER REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (todo_id, tag_id)
);
```

---

## API Design

### RESTful Principles

The API follows REST architectural style:

| Principle | Implementation |
|-----------|---------------|
| **Resource-based** | URLs represent resources (todos, tags) |
| **HTTP methods** | GET (read), POST (create), PUT (update), DELETE (remove) |
| **Stateless** | Each request contains all necessary information |
| **Uniform interface** | Consistent response formats |
| **Layered system** | Client doesn't need to know backend implementation |

### URL Structure

```
/health                    # Health check
/api/todos/               # Todo collection
/api/todos/{id}           # Specific todo
/api/todos/{id}/toggle    # Toggle todo completion
/api/todos/{id}/subtasks  # Todo's subtasks
/api/tags/                # Tag collection
/api/tags/{id}            # Specific tag
```

### Request/Response Flow

```
Client Request
      │
      ▼
FastAPI receives request
      │
      ├─► Validation (Pydantic)
      │
      ├─► Authentication (future)
      │
      ├─► Business Logic
      │       │
      │       ├─► Query/Validate Data
      │       │
      │       ├─► Database Operations (SQLAlchemy)
      │       │
      │       └─► Response Generation
      │
      ▼
Response to Client (JSON)
```

### Error Handling

```
┌─────────────────────────────────────┐
│     Error Handler Middleware      │
└──────────────┬──────────────────┘
               │
      ┌────────┴────────┐
      │                 │
┌─────▼─────┐   ┌─────▼─────┐
│ Validation │   │  Server   │
│  Errors   │   │  Errors   │
│  (400)    │   │  (500)    │
└─────┬─────┘   └─────┬─────┘
      │                 │
      └────────┬────────┘
               │
        ┌──────▼──────┐
        │   HTTP      │
        │   Response  │
        │  + JSON     │
        └─────────────┘
```

---

## Frontend Architecture

### Component Structure

```
App
│
├─► Header
│    ├─► Title
│    ├─► Filters (All/Active/Completed)
│    └─► Search Bar
│
├─► Main Content
│    ├─► Add Todo Button
│    ├─► Stats Bar
│    │    ├─► Total Count
│    │    ├─► Active Count
│    │    └─► Completed Count
│    │
│    ├─► Todos List
│    │    └─► Todo Card (repeated)
│    │         ├─► Checkbox
│    │         ├─► Title & Description
│    │         ├─► Meta (Priority, Due Date, Tags)
│    │         ├─► Subtasks
│    │         └─► Actions (Edit, Delete)
│    │
│    └─► Empty State
│
└─► Sidebar
     ├─► Tags Section
     └─► Priority Filters
```

### State Management

```
Global State (app.js)
│
├─► todos: []                    # List of todos
├─► tags: []                     # List of tags
├─► currentFilter: 'all'          # Active/Completed/All
├─► currentPriority: 'all'        # Priority filter
├─► currentTag: null              # Selected tag
└─► draggedItem: null            # Drag state
```

### Data Flow

```
User Action
      │
      ▼
Event Listener
      │
      ▼
State Update
      │
      ├─► Re-render UI
      │
      └─► API Call (if needed)
              │
              ▼
          API Response
              │
              ▼
          State Update
              │
              ▼
          Re-render UI
```

---

## Security Considerations

### Current Security Measures

1. **CORS Configuration**
   - Allows all origins (dev mode)
   - Restrict in production

2. **SQL Injection Prevention**
   - SQLAlchemy ORM (parameterized queries)
   - No raw SQL queries

3. **Input Validation**
   - Pydantic schema validation
   - Type checking and constraints

### Future Security Enhancements

1. **Authentication**
   - JWT tokens
   - User accounts
   - Session management

2. **Authorization**
   - Resource ownership
   - Permission levels
   - Role-based access

3. **Rate Limiting**
   - Request per IP limits
   - API key management
   - Throttling

4. **HTTPS**
   - SSL/TLS encryption
   - Secure cookies
   - HTTP Strict Transport Security

5. **Data Protection**
   - Password hashing
   - Sensitive data encryption
   - GDPR compliance

---

## Scalability

### Vertical Scaling (Scaling Up)

- Increase server resources (CPU, RAM)
- More powerful database instance
- Better network bandwidth

### Horizontal Scaling (Scaling Out)

- Load balancer + multiple instances
- Database read replicas
- Caching layer (Redis)
- CDN for static assets

### Database Scaling

**SQLite → PostgreSQL Migration**

```python
# Current: SQLite (dev)
DATABASE_URL = "sqlite:///./todos.db"

# Future: PostgreSQL (production)
DATABASE_URL = "postgresql://user:pass@host:5432/db"
```

**Benefits of PostgreSQL:**
- Better concurrent connections
- Advanced indexing
- Full-text search
- JSON/JSONB support
- Replication and clustering

### Caching Strategy

```
┌──────────┐
│  Client  │
└─────┬────┘
      │
      ▼
┌─────────────┐
│   Cache     │ ← First check
│   (Redis)   │
└─────┬───────┘
      │ (miss)
      ▼
┌─────────────┐
│  Database   │ ← Fallback
│ (PostgreSQL)│
└─────────────┘
```

---

## Performance Optimization

### Backend Optimizations

1. **Database Indexing**
   ```python
   # Models already have indexed fields
   id = Column(Integer, primary_key=True, index=True)
   title = Column(String(200), index=True)
   ```

2. **Query Optimization**
   - Use `select_related` for joins
   - Limit result sets
   - Pagination

3. **Connection Pooling**
   ```python
   engine = create_engine(
       DATABASE_URL,
       pool_size=20,
       max_overflow=10
   )
   ```

4. **Async Support**
   - FastAPI supports async
   - Uvicorn async workers
   - Can enable for I/O bound operations

### Frontend Optimizations

1. **Minification**
   - Compress CSS
   - Minify JavaScript
   - Optimize images

2. **Lazy Loading**
   - Load todos on demand
   - Virtual scrolling for large lists
   - Lazy load subtasks

3. **Debouncing**
   - Search input debouncing
   - Debounced API calls
   - Reduce unnecessary requests

4. **Caching**
   - Browser cache for static assets
   - Cache API responses
   - Service workers (future)

### CDN Integration

```
Client
   │
   ├──► Static Assets (CDN)
   │    └─► CSS, JS, Images
   │
   └──► API (Server)
        └─► Dynamic data
```

---

## Monitoring and Logging

### Application Monitoring

```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger(__name__)

@app.get("/api/todos/")
def get_todos():
    logger.info("Fetching all todos")
    # ...
```

### Performance Metrics

- Response time tracking
- Query execution time
- Error rates
- Active users

### Health Checks

```python
@app.get("/health")
def health_check():
    # Check database
    # Check dependencies
    return {"status": "healthy"}
```

---

## Future Enhancements

### Planned Features

1. **User Accounts**
   - Authentication (JWT)
   - User registration
   - Profile management

2. **Collaboration**
   - Share todos
   - Comments on todos
   - Real-time updates (WebSocket)

3. **Advanced Features**
   - File attachments
   - Rich text descriptions
   - Custom views/filters
   - Notifications

4. **Mobile App**
   - React Native / Flutter
   - Offline support
   - Push notifications

### Technical Debt

1. **Add comprehensive tests**
   - Unit tests
   - Integration tests
   - E2E tests (Playwright)

2. **Add CI/CD pipeline**
   - GitHub Actions
   - Automated testing
   - Automated deployment

3. **Add monitoring**
   - Application metrics
   - Error tracking (Sentry)
   - Performance monitoring

---

## Conclusion

This architecture provides a solid foundation for a scalable, maintainable todo list application. The separation of concerns, modern technology stack, and clean design patterns make it easy to understand, extend, and deploy.

For questions or suggestions, please open an issue on GitHub.

---

**Document Version**: 1.0.0  
**Last Updated**: January 6, 2026
