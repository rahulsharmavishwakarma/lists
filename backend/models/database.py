from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey, Text, Table
from sqlalchemy.orm import relationship, DeclarativeBase
from datetime import datetime

class Base(DeclarativeBase):
    pass

todo_tags = Table(
    'todo_tags',
    Base.metadata,
    Column('todo_id', Integer, ForeignKey('todos.id'), primary_key=True),
    Column('tag_id', Integer, ForeignKey('tags.id'), primary_key=True)
)

class Tag(Base):
    __tablename__ = "tags"
    
    id = Column(Integer, primary_key=True)
    name = Column(String(50), unique=True)
    color = Column(String(7))
    
    todos = relationship("Todo", secondary="todo_tags", back_populates="tags")

class Todo(Base):
    __tablename__ = "todos"
    
    id = Column(Integer, primary_key=True)
    title = Column(String(200))
    description = Column(Text, nullable=True)
    completed = Column(Boolean, default=False)
    priority = Column(String(10), default="medium")
    due_date = Column(DateTime, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    position = Column(Integer, default=0)
    
    subtasks = relationship("Subtask", back_populates="parent_todo", cascade="all, delete-orphan")
    tags = relationship("Tag", secondary="todo_tags", back_populates="todos")

class Subtask(Base):
    __tablename__ = "subtasks"
    
    id = Column(Integer, primary_key=True)
    title = Column(String(200))
    completed = Column(Boolean, default=False)
    position = Column(Integer, default=0)
    parent_todo_id = Column(Integer, ForeignKey("todos.id"))
    created_at = Column(DateTime, default=datetime.utcnow)
    
    parent_todo = relationship("Todo", back_populates="subtasks")
