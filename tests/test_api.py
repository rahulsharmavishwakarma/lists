import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from backend.main import app
from backend.models.database import Base
from backend.utils.database import get_db

SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def override_get_db():
    db = TestingSessionLocal()
    try:
        yield db
    finally:
        db.close()

app.dependency_overrides[get_db] = override_get_db

client = TestClient(app)

@pytest.fixture(autouse=True)
def setup_database():
    Base.metadata.create_all(bind=engine)
    yield
    Base.metadata.drop_all(bind=engine)

def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}

def test_get_todos_empty():
    response = client.get("/api/todos/")
    assert response.status_code == 200
    assert response.json() == []

def test_create_todo():
    todo_data = {
        "title": "Test Todo",
        "description": "Test description",
        "priority": "high"
    }
    response = client.post("/api/todos/", json=todo_data)
    assert response.status_code == 200
    data = response.json()
    assert data["title"] == "Test Todo"
    assert data["priority"] == "high"

def test_get_todos():
    todo_data = {
        "title": "Test Todo",
        "description": "Test description"
    }
    client.post("/api/todos/", json=todo_data)
    
    response = client.get("/api/todos/")
    assert response.status_code == 200
    assert len(response.json()) == 1

def test_create_tag():
    tag_data = {
        "name": "Work",
        "color": "#FF5733"
    }
    response = client.post("/api/tags/", json=tag_data)
    assert response.status_code == 200
    data = response.json()
    assert data["name"] == "Work"
    assert data["color"] == "#FF5733"

def test_get_tags():
    tag_data = {
        "name": "Work",
        "color": "#FF5733"
    }
    client.post("/api/tags/", json=tag_data)
    
    response = client.get("/api/tags/")
    assert response.status_code == 200
    assert len(response.json()) == 1
