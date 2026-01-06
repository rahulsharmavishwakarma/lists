from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from enum import Enum

class PriorityLevel(str, Enum):
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"

class TagBase(BaseModel):
    name: str = Field(..., max_length=50)
    color: Optional[str] = "#007AFF"

class TagCreate(TagBase):
    pass

class TagResponse(TagBase):
    id: int
    
    class Config:
        from_attributes = True

class SubtaskBase(BaseModel):
    title: str = Field(..., max_length=200)
    completed: bool = False
    position: int = 0

class SubtaskCreate(SubtaskBase):
    pass

class SubtaskUpdate(BaseModel):
    title: Optional[str] = None
    completed: Optional[bool] = None
    position: Optional[int] = None

class SubtaskResponse(SubtaskBase):
    id: int
    parent_todo_id: int
    created_at: datetime
    
    class Config:
        from_attributes = True

class TodoBase(BaseModel):
    title: str = Field(..., max_length=200)
    description: Optional[str] = None
    completed: bool = False
    priority: PriorityLevel = PriorityLevel.MEDIUM
    due_date: Optional[datetime] = None
    position: int = 0
    tag_ids: Optional[List[int]] = None

class TodoCreate(TodoBase):
    subtasks: Optional[List[SubtaskCreate]] = None

class TodoUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    completed: Optional[bool] = None
    priority: Optional[PriorityLevel] = None
    due_date: Optional[datetime] = None
    position: Optional[int] = None
    tag_ids: Optional[List[int]] = None

class TodoResponse(TodoBase):
    id: int
    created_at: datetime
    updated_at: datetime
    subtasks: List[SubtaskResponse] = []
    tags: List[TagResponse] = []
    
    class Config:
        from_attributes = True
