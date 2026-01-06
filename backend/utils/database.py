import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from backend.models.database import Base

# Get the database URL from environment or use SQLite default
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "sqlite:///./todos.db"
)

# For SQLite, use absolute path relative to this file
if DATABASE_URL.startswith("sqlite"):
    backend_dir = os.path.dirname(os.path.abspath(__file__))
    db_name = DATABASE_URL.split("///")[-1]
    db_path = os.path.join(backend_dir, db_name)
    engine = create_engine(
        f"sqlite:///{db_path}", 
        connect_args={"check_same_thread": False}
    )
else:
    engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def init_db():
    Base.metadata.create_all(bind=engine)
