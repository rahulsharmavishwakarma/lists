# Contributing to Notion-Style Todo List

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to the project.

## 🚀 Getting Started

### Prerequisites
- Python 3.8 or higher
- Git
- Docker (optional, for PostgreSQL setup)

### Setup Development Environment

1. **Fork and clone the repository**
```bash
git clone https://github.com/yourusername/To_do_list.git
cd To_do_list
```

2. **Create a virtual environment**
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. **Install dependencies**
```bash
pip install -r requirements.txt
```

4. **Run the application**
```bash
make dev
```

## 📋 Development Workflow

### Branch Naming

Use the following naming conventions for branches:
- `feature/description` - New features
- `bugfix/description` - Bug fixes
- `hotfix/description` - Critical bug fixes
- `refactor/description` - Code refactoring
- `docs/description` - Documentation updates

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat(todos): add drag and drop reordering

- Implement drag and drop for todos
- Add API endpoint for reordering
- Update frontend to handle drag events

Closes #123
```

```
fix(api): handle missing priority level

Add validation to ensure priority is one of the valid values
before creating a todo.

Fixes #456
```

## 🧪 Testing

### Running Tests

```bash
# Run all tests
make test

# Run specific test file
pytest tests/test_api.py -v

# Run with coverage
pytest tests/ --cov=backend --cov-report=html
```

### Writing Tests

1. Create test files in the `tests/` directory
2. Use descriptive test names
3. Test both success and failure cases
4. Mock external dependencies when necessary

Example:
```python
def test_create_todo_with_subtasks(client):
    todo_data = {
        "title": "Test Todo",
        "subtasks": [
            {"title": "Subtask 1"},
            {"title": "Subtask 2"}
        ]
    }
    response = client.post("/api/todos/", json=todo_data)
    assert response.status_code == 200
    assert len(response.json()["subtasks"]) == 2
```

## 🎨 Code Style

### Formatting

Use the provided Makefile commands:
```bash
# Format code
make format

# Lint code
make lint
```

### Python Style Guide

- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/)
- Use meaningful variable and function names
- Add docstrings to functions and classes
- Keep functions focused and small

### JavaScript Style Guide

- Use camelCase for variables and functions
- Use const/let instead of var
- Add comments for complex logic
- Follow ESLint rules

### CSS Style Guide

- Use BEM naming convention for classes
- Group related styles
- Use CSS variables for theming
- Ensure mobile responsiveness

## 📂 Project Structure

```
backend/
├── main.py          # Application entry point
├── models/          # Database models
├── routes/          # API endpoints
├── schemas/         # Pydantic schemas
└── utils/           # Utility functions

frontend/
├── index.html       # Main HTML
├── css/           # Stylesheets
└── js/            # JavaScript logic
```

## 🐛 Reporting Issues

When reporting bugs, please include:

1. **Description**: Clear description of the issue
2. **Steps to Reproduce**: Detailed steps to reproduce the bug
3. **Expected Behavior**: What should happen
4. **Actual Behavior**: What actually happens
5. **Environment**: 
   - OS and version
   - Python version
   - Browser (if frontend issue)
6. **Screenshots**: If applicable

### Issue Template

```markdown
## Description
[Clear and concise description of the issue]

## Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

## Expected Behavior
[What you expected to happen]

## Actual Behavior
[What actually happened]

## Environment
- OS: [e.g., Ubuntu 20.04]
- Python Version: [e.g., 3.11]
- Browser: [e.g., Chrome 120]
```

## 💡 Feature Requests

When proposing new features:

1. **Title**: Clear, descriptive title
2. **Description**: Detailed description of the feature
3. **Use Cases**: How this feature would be used
4. **Alternatives**: Any alternative solutions considered
5. **Additional Context**: Any other relevant information

### Feature Request Template

```markdown
## Feature Description
[Detailed description of the feature]

## Use Cases
- [Use case 1]
- [Use case 2]

## Proposed Solution
[How you envision this feature working]

## Alternatives Considered
[Any other approaches you've thought about]

## Additional Context
[Any other information, mockups, etc.]
```

## ✅ Pull Request Process

### Before Submitting

1. **Update tests**: Ensure new code has test coverage
2. **Run tests**: `make test`
3. **Format code**: `make format`
4. **Lint code**: `make lint`
5. **Update docs**: If applicable, update documentation

### PR Checklist

- [ ] Code follows project style guidelines
- [ ] Tests pass locally (`make test`)
- [ ] Code is formatted (`make format`)
- [ ] No linting errors (`make lint`)
- [ ] Documentation updated (if applicable)
- [ ] Commit messages follow conventions
- [ ] PR description is clear and descriptive

### PR Template

```markdown
## Description
[Brief description of changes]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
[Describe how you tested your changes]

## Checklist
- [ ] Tests pass
- [ ] Code formatted
- [ ] No linting errors
- [ ] Documentation updated

## Related Issues
Closes #issue_number
```

## 📖 Documentation

When updating documentation:

1. Keep it clear and concise
2. Include code examples where appropriate
3. Update README.md for user-facing changes
4. Add inline comments for complex code

## 🤝 Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other community members

## 📞 Getting Help

If you need help:
- Check existing issues and discussions
- Read the documentation
- Ask questions in GitHub Discussions

---

Thank you for contributing! 🎉
