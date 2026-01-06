# Changelog

All notable changes to the Notion-Style Todo List project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Planned Features
- [ ] User authentication and authorization
- [ ] User accounts and profiles
- [ ] Task sharing and collaboration
- [ ] Comments on tasks
- [ ] File attachments
- [ ] Rich text descriptions
- [ ] Keyboard shortcuts
- [ ] Bulk operations
- [ ] Custom views/saved filters
- [ ] Dark mode theme
- [ ] Export/Import functionality
- [ ] Task templates
- [ ] Recurring tasks
- [ ] Email notifications
- [ ] Mobile app (React Native/Flutter)
- [ ] Offline support
- [ ] Real-time updates (WebSocket)

## [1.0.0] - 2026-01-06

### Added
- ✅ Complete CRUD operations for todos
  - Create, read, update, delete tasks
  - Toggle task completion
  - Drag and drop reordering
- ✅ Tag management system
  - Create and delete tags
  - Color-coded tags
  - Assign multiple tags to tasks
  - Filter by tags
- ✅ Subtask support
  - Create and manage subtasks
  - Toggle subtask completion independently
  - Delete individual subtasks
- ✅ Priority levels
  - High, Medium, Low priorities
  - Visual priority indicators
  - Filter by priority
- ✅ Due date management
  - Set due dates for tasks
  - Visual overdue highlighting
  - Date and time display
- ✅ Search functionality
  - Real-time search
  - Search in titles and descriptions
  - Debounced search for performance
- ✅ Advanced filtering
  - Filter by status (All/Active/Completed)
  - Filter by priority
  - Filter by tags
  - Combine multiple filters
- ✅ Statistics dashboard
  - Total task count
  - Active task count
  - Completed task count
  - Real-time updates
- ✅ Beautiful Notion-inspired UI
  - Clean, modern interface
  - Smooth animations
  - Responsive design
  - Mobile-friendly
- ✅ FastAPI backend
  - High-performance REST API
  - Automatic API documentation (Swagger/ReDoc)
  - CORS support
  - Pydantic validation
- ✅ Database support
  - SQLite for development
  - PostgreSQL for production
  - Easy database switching via environment variables
- ✅ Docker support
  - Dockerfile for containerization
  - Docker Compose for PostgreSQL
  - Production-ready configuration
- ✅ Comprehensive documentation
  - README with setup instructions
  - API documentation
  - Architecture documentation
  - User guide
  - Contributing guidelines
  - Deployment guide
  - Changelog
- ✅ Development tooling
  - Makefile with common tasks
  - Test suite with pytest
  - Code quality tools (black, ruff, isort)
  - Pre-commit hooks (planned)
- ✅ CI/CD ready
  - GitHub Actions workflow template
  - Automated testing
  - Automated deployment (template)
- ✅ Security features
  - Input validation
  - SQL injection prevention
  - CORS configuration
  - Environment variable management

### Technical Details

**Backend Stack:**
- FastAPI 0.104.1
- SQLAlchemy 2.0.23
- Pydantic 2.5.0
- Uvicorn 0.24.0
- PostgreSQL/SQLite

**Frontend Stack:**
- HTML5
- CSS3 (with CSS variables)
- Vanilla JavaScript (ES6+)
- No framework dependencies

**DevOps Stack:**
- Docker & Docker Compose
- Make
- pytest for testing
- black, ruff, isort for code quality

### Database Schema
- `todos` table with full task metadata
- `subtasks` table for hierarchical tasks
- `tags` table for categorization
- `todo_tags` junction table for many-to-many relationships

### API Endpoints
- `GET /api/todos/` - List all todos with filters
- `GET /api/todos/{id}` - Get specific todo
- `POST /api/todos/` - Create new todo
- `PUT /api/todos/{id}` - Update todo
- `DELETE /api/todos/{id}` - Delete todo
- `PATCH /api/todos/{id}/toggle` - Toggle completion
- `POST /api/todos/{id}/reorder` - Reorder todos
- `GET /api/todos/{id}/subtasks` - Get subtasks
- `POST /api/todos/{id}/subtasks` - Create subtask
- `PUT /api/todos/subtasks/{id}` - Update subtask
- `DELETE /api/todos/subtasks/{id}` - Delete subtask
- `PATCH /api/todos/subtasks/{id}/toggle` - Toggle subtask
- `GET /api/tags/` - List all tags
- `POST /api/tags/` - Create tag
- `DELETE /api/tags/{id}` - Delete tag
- `GET /health` - Health check endpoint

### UI Components
- Header with title, filters, and search
- Add todo button with modal form
- Stats bar with task counts
- Todo cards with full information
- Sidebar with tags and priority filters
- Modals for creating/editing tasks and tags
- Empty state with helpful message

### Performance Optimizations
- Debounced search
- Efficient database queries with indexes
- Optimized CSS with variables
- Minimal JavaScript bundle size
- Lazy loading (planned)

### Accessibility
- Semantic HTML markup
- Keyboard navigation support (planned)
- ARIA labels (planned)
- High contrast colors
- Responsive design

---

## [0.1.0] - Initial Planning (Not Released)

### Planned
- Project structure setup
- Technology selection
- Architecture design
- Initial feature specification

---

## Versioning

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR**: Incompatible API changes
- **MINOR**: Backwards-compatible functionality additions
- **PATCH**: Backwards-compatible bug fixes

Example: 1.2.3
- 1 = Major version
- 2 = Minor version
- 3 = Patch version

---

## Release Process

1. Update version in code
2. Update this changelog
3. Tag release in git
4. Create GitHub release
5. Update documentation

---

## Migration Guide

### From 0.x to 1.0.0

No breaking changes. 1.0.0 is the first stable release.

### Future Upgrades

When upgrading between major versions:
1. Check this changelog for breaking changes
2. Backup your data
3. Follow the upgrade instructions
4. Test in staging environment first

---

## Reporting Issues

Found a bug or have a suggestion?
1. Check if it's already reported
2. Open an issue on GitHub
3. Include version number and environment
4. Provide steps to reproduce

---

## Credits

Built with ❤️ using:
- [FastAPI](https://fastapi.tiangolo.com/)
- [SQLAlchemy](https://www.sqlalchemy.org/)
- [Notion](https://www.notion.so/) (inspiration)

---

**End of Changelog**
