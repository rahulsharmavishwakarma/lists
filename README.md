# Lists - Modern Task Management Application

A full-stack, feature-rich todo list application with a beautiful modern UI built with Vue.js 3 and FastAPI.

## 🚀 Features

### ✅ Core Functionality
- **Create, Read, Update, Delete** todos
- **Real-time search** filtering
- **Priority levels** (Low, Medium, High) with color coding
- **Due dates** with overdue highlighting
- **Tags** with custom colors for categorization
- **Subtasks** for breaking down complex tasks
- **Drag and drop** reordering

### 🎨 User Interface
- **Modern dark theme** with gradient backgrounds
- **Glass morphism** effects
- **Smooth animations** (fadeIn, slideIn, bounceIn)
- **Responsive design** (mobile, tablet, desktop)
- **Custom checkboxes** with animations
- **Modal dialogs** for creating/editing
- **Statistics dashboard** (Total/Active/Completed)

## 📋 Installation

### Setup

1. **Install Python dependencies**
   ```bash
   pip install -r requirements.txt
   ```

2. **Initialize the database**
   ```bash
   python -c "from backend.utils.database import init_db; init_db()"
   ```

3. **Run the development server**
   ```bash
   python -m uvicorn backend.main:app --reload
   ```

4. **Access the application**
   ```
   http://localhost:8000
   ```

## 🧪 Testing

### Run API Tests
```bash
python -m pytest tests/ -v
```

### Run Comprehensive Tests
```bash
./comprehensive-test.sh
```

## 📁 Project Structure

```
lists/
├── backend/
│   ├── main.py              # FastAPI application
│   ├── models/             # SQLAlchemy models
│   ├── routes/             # API endpoints
│   ├── schemas/            # Pydantic models
│   └── utils/             # Database connection
├── frontend/
│   ├── index.html          # Vue.js app
│   ├── css/               # Styling
│   └── js/                # Vue 3 logic
└── tests/                # Test suite
```

## 🔌 API Endpoints

### Todos
- `GET /api/todos/` - List todos
- `POST /api/todos/` - Create todo
- `PUT /api/todos/{id}` - Update todo
- `DELETE /api/todos/{id}` - Delete todo
- `PATCH /api/todos/{id}/toggle` - Toggle completion
- `POST /api/todos/reorder` - Reorder todos

### Tags
- `GET /api/tags/` - List tags
- `POST /api/tags/` - Create tag
- `DELETE /api/tags/{id}` - Delete tag

## 🎨 UI Features

- Dark theme with gradients
- Smooth animations
- Responsive design
- Real-time search
- Drag and drop
- Modal dialogs

## 📊 Test Results

- **API Tests**: 60/60 passed
- **Comprehensive Tests**: 49/50 passed

---

**Made with ❤️ for productivity**
