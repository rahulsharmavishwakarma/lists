# API Documentation

Complete API reference for the Notion-Style Todo List application.

## Base URL

- **Development**: `http://localhost:8000`
- **Production**: `https://your-domain.com`

## Authentication

Currently, the API does not require authentication. Future versions may include JWT-based authentication.

## Response Format

All API responses return JSON with the following structure:

**Success Response:**
```json
{
  "id": 1,
  "title": "Task title",
  ...
}
```

**Error Response:**
```json
{
  "detail": "Error message"
}
```

## Status Codes

| Code | Description |
|------|-------------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request |
| 404 | Not Found |
| 500 | Internal Server Error |

---

## Endpoints

### Health Check

#### Check Application Health

```http
GET /health
```

**Response:**
```json
{
  "status": "healthy"
}
```

---

## Tags API

### Get All Tags

```http
GET /api/tags/
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "Work",
    "color": "#FF5733"
  }
]
```

### Create Tag

```http
POST /api/tags/
Content-Type: application/json

{
  "name": "Personal",
  "color": "#27AE60"
}
```

**Request Body:**

| Field | Type | Required | Description |
|-------|------|-----------|-------------|
| name | string | Yes | Tag name (max 50 characters) |
| color | string | No | Hex color code (default: #007AFF) |

**Response:**
```json
{
  "id": 2,
  "name": "Personal",
  "color": "#27AE60"
}
```

### Delete Tag

```http
DELETE /api/tags/{tag_id}
```

**Response:**
```json
{
  "message": "Tag deleted successfully"
}
```

---

## Todos API

### Get All Todos

```http
GET /api/todos/
```

**Query Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| skip | integer | 0 | Number of records to skip (pagination) |
| limit | integer | 100 | Maximum number of records to return |
| completed | boolean | null | Filter by completion status |
| priority | string | null | Filter by priority (low, medium, high) |
| search | string | null | Search in todo title |

**Examples:**

```http
# Get all active todos
GET /api/todos/?completed=false

# Get high priority todos
GET /api/todos/?priority=high

# Search todos
GET /api/todos/?search=important

# Pagination
GET /api/todos/?skip=10&limit=20
```

**Response:**
```json
[
  {
    "id": 1,
    "title": "Complete project documentation",
    "description": "Write comprehensive docs for the project",
    "completed": false,
    "priority": "high",
    "due_date": "2026-01-10T10:00:00",
    "position": 1,
    "tag_ids": [1],
    "created_at": "2026-01-06T10:00:00",
    "updated_at": "2026-01-06T10:00:00",
    "subtasks": [
      {
        "id": 1,
        "title": "Write API docs",
        "completed": true,
        "position": 0,
        "parent_todo_id": 1,
        "created_at": "2026-01-06T10:00:00"
      }
    ],
    "tags": [
      {
        "id": 1,
        "name": "Work",
        "color": "#FF5733"
      }
    ]
  }
]
```

### Get Specific Todo

```http
GET /api/todos/{todo_id}
```

**Response:** Same as getting all todos, but single object

### Create Todo

```http
POST /api/todos/
Content-Type: application/json

{
  "title": "New task",
  "description": "Task description",
  "priority": "medium",
  "due_date": "2026-01-10T10:00:00",
  "tag_ids": [1, 2],
  "subtasks": [
    {
      "title": "Subtask 1",
      "completed": false
    }
  ]
}
```

**Request Body:**

| Field | Type | Required | Description |
|-------|------|-----------|-------------|
| title | string | Yes | Todo title (max 200 characters) |
| description | string | No | Detailed description |
| completed | boolean | No | Completion status (default: false) |
| priority | string | No | Priority level: low, medium, high (default: medium) |
| due_date | datetime | No | Due date (ISO 8601 format) |
| position | integer | No | Position for ordering (auto-assigned if not provided) |
| tag_ids | array | No | Array of tag IDs |
| subtasks | array | No | Array of subtask objects |

**Response:** Full todo object with generated ID

### Update Todo

```http
PUT /api/todos/{todo_id}
Content-Type: application/json

{
  "title": "Updated title",
  "completed": true,
  "priority": "high"
}
```

**Request Body:** All fields are optional, only provided fields will be updated

**Response:** Updated todo object

### Delete Todo

```http
DELETE /api/todos/{todo_id}
```

**Response:**
```json
{
  "message": "Todo deleted successfully"
}
```

### Toggle Todo Completion

```http
PATCH /api/todos/{todo_id}/toggle
```

**Response:** Updated todo object with flipped completion status

### Reorder Todos

```http
POST /api/todos/0/reorder
Content-Type: application/json

[1, 3, 2, 4]
```

**Request Body:** Array of todo IDs in desired order

**Response:**
```json
{
  "message": "Todos reordered successfully"
}
```

---

## Subtasks API

### Get Todo Subtasks

```http
GET /api/todos/{todo_id}/subtasks
```

**Response:** Array of subtask objects

### Create Subtask

```http
POST /api/todos/{todo_id}/subtasks
Content-Type: application/json

{
  "title": "New subtask",
  "completed": false
}
```

**Request Body:**

| Field | Type | Required | Description |
|-------|------|-----------|-------------|
| title | string | Yes | Subtask title (max 200 characters) |
| completed | boolean | No | Completion status (default: false) |
| position | integer | No | Position for ordering (auto-assigned) |

**Response:** Created subtask object

### Update Subtask

```http
PUT /api/todos/subtasks/{subtask_id}
Content-Type: application/json

{
  "title": "Updated subtask",
  "completed": true
}
```

**Response:** Updated subtask object

### Delete Subtask

```http
DELETE /api/todos/subtasks/{subtask_id}
```

**Response:**
```json
{
  "message": "Subtask deleted successfully"
}
```

### Toggle Subtask Completion

```http
PATCH /api/todos/subtasks/{subtask_id}/toggle
```

**Response:** Updated subtask object with flipped completion status

---

## Data Models

### Priority Levels

| Value | Description |
|--------|-------------|
| low | Low priority task |
| medium | Medium priority task (default) |
| high | High priority task |

### Color Format

Colors should be provided as hex codes:
- Example: `#FF5733` (orange-red)
- Example: `#27AE60` (green)
- Example: `#3498DB` (blue)

### Date Format

All dates use ISO 8601 format:
- Example: `2026-01-06T10:30:00`
- Example: `2026-01-10T14:45:00.000Z`

---

## Interactive API Documentation

The application includes interactive API documentation:

- **Swagger UI**: `http://localhost:8000/docs`
  - Try out API endpoints directly in browser
  - View request/response examples
  - Test with different parameters

- **ReDoc**: `http://localhost:8000/redoc`
  - Well-formatted reference documentation
  - Print-friendly layout
  - Detailed schema information

---

## Rate Limiting

Currently, there is no rate limiting. Future versions may implement:
- Request rate limits per IP
- Burst limits for heavy operations
- API keys for access control

---

## Error Handling

### Common Errors

**400 Bad Request**
```json
{
  "detail": "Validation error"
}
```
Cause: Invalid request body or parameters

**404 Not Found**
```json
{
  "detail": "Todo not found"
}
```
Cause: Requested resource does not exist

**500 Internal Server Error**
```json
{
  "detail": "Internal server error"
}
```
Cause: Server-side error, check logs

---

## Examples

### cURL Examples

**Create a todo:**
```bash
curl -X POST http://localhost:8000/api/todos/ \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Complete project",
    "priority": "high",
    "tag_ids": [1]
  }'
```

**Get all todos:**
```bash
curl http://localhost:8000/api/todos/
```

**Update a todo:**
```bash
curl -X PUT http://localhost:8000/api/todos/1 \
  -H "Content-Type: application/json" \
  -d '{
    "completed": true
  }'
```

**Delete a todo:**
```bash
curl -X DELETE http://localhost:8000/api/todos/1
```

### JavaScript/Fetch Examples

**Create a todo:**
```javascript
fetch('http://localhost:8000/api/todos/', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    title: 'Complete project',
    priority: 'high',
    tag_ids: [1]
  })
})
  .then(response => response.json())
  .then(data => console.log(data));
```

**Get all todos:**
```javascript
fetch('http://localhost:8000/api/todos/')
  .then(response => response.json())
  .then(data => console.log(data));
```

### Python/Requests Examples

**Create a todo:**
```python
import requests

url = 'http://localhost:8000/api/todos/'
data = {
    'title': 'Complete project',
    'priority': 'high',
    'tag_ids': [1]
}

response = requests.post(url, json=data)
print(response.json())
```

**Get all todos:**
```python
import requests

response = requests.get('http://localhost:8000/api/todos/')
print(response.json())
```

---

## Versioning

Current API version: **1.0.0**

Future versions will maintain backward compatibility where possible. Breaking changes will be:
- Documented in changelog
- Announced in advance
- Versioned in the URL (e.g., `/api/v2/todos/`)

---

## Changelog

### v1.0.0 (Current)
- Initial release
- CRUD operations for todos
- Tag management
- Subtask support
- Filtering and search
- Drag and drop reordering

---

## Support

For API-related issues:
- Check this documentation
- Try the interactive docs at `/docs`
- Report bugs on GitHub
- Contact maintainers

---

**Happy coding! 🚀**
