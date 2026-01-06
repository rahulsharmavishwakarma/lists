from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional
from datetime import datetime
from backend.models.database import Todo, Subtask, Tag
from backend.schemas.schemas import TodoCreate, TodoUpdate, TodoResponse, SubtaskCreate
from backend.utils.database import get_db

router = APIRouter(prefix="/api/todos", tags=["todos"])

@router.get("/", response_model=List[TodoResponse])
def get_todos(
    skip: int = 0,
    limit: int = 100,
    completed: Optional[bool] = None,
    priority: Optional[str] = None,
    search: Optional[str] = None,
    db: Session = Depends(get_db)
):
    query = db.query(Todo)
    
    if completed is not None:
        query = query.filter(Todo.completed == completed)
    
    if priority is not None:
        query = query.filter(Todo.priority == priority)
    
    if search:
        query = query.filter(Todo.title.contains(search))
    
    todos = query.order_by(Todo.position).offset(skip).limit(limit).all()
    return todos

@router.get("/{todo_id}", response_model=TodoResponse)
def get_todo(todo_id: int, db: Session = Depends(get_db)):
    todo = db.query(Todo).filter(Todo.id == todo_id).first()
    if not todo:
        raise HTTPException(status_code=404, detail="Todo not found")
    return todo

@router.post("/", response_model=TodoResponse)
def create_todo(todo: TodoCreate, db: Session = Depends(get_db)):
    max_position = db.query(Todo).count()
    db_todo = Todo(
        title=todo.title,
        description=todo.description,
        completed=todo.completed,
        priority=todo.priority,
        due_date=todo.due_date,
        position=max_position + 1
    )
    db.add(db_todo)
    db.commit()
    db.refresh(db_todo)
    
    if todo.subtasks:
        for subtask in todo.subtasks:
            db_subtask = Subtask(
                title=subtask.title,
                completed=subtask.completed,
                parent_todo_id=db_todo.id
            )
            db.add(db_subtask)
        db.commit()
    
    if todo.tag_ids:
        for tag_id in todo.tag_ids:
            tag = db.query(Tag).filter(Tag.id == tag_id).first()
            if tag:
                db_todo.tags.append(tag)
        db.commit()
        db.refresh(db_todo)
    
    return db_todo

@router.put("/{todo_id}", response_model=TodoResponse)
def update_todo(todo_id: int, todo: TodoUpdate, db: Session = Depends(get_db)):
    db_todo = db.query(Todo).filter(Todo.id == todo_id).first()
    if not db_todo:
        raise HTTPException(status_code=404, detail="Todo not found")
    
    update_data = todo.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_todo, key, value)
    
    db.commit()
    db.refresh(db_todo)
    return db_todo

@router.delete("/{todo_id}")
def delete_todo(todo_id: int, db: Session = Depends(get_db)):
    db_todo = db.query(Todo).filter(Todo.id == todo_id).first()
    if not db_todo:
        raise HTTPException(status_code=404, detail="Todo not found")
    
    db.delete(db_todo)
    db.commit()
    return {"message": "Todo deleted successfully"}

@router.patch("/{todo_id}/toggle")
def toggle_todo(todo_id: int, db: Session = Depends(get_db)):
    db_todo = db.query(Todo).filter(Todo.id == todo_id).first()
    if not db_todo:
        raise HTTPException(status_code=404, detail="Todo not found")
    
    db_todo.completed = not db_todo.completed
    db.commit()
    db.refresh(db_todo)
    return db_todo

@router.post("/reorder")
def reorder_todos(todo_ids: List[int], db: Session = Depends(get_db)):
    for position, todo_id in enumerate(todo_ids):
        db_todo = db.query(Todo).filter(Todo.id == todo_id).first()
        if db_todo:
            db_todo.position = position
    
    db.commit()
    return {"message": "Todos reordered successfully"}

@router.get("/{todo_id}/subtasks", response_model=List[SubtaskCreate])
def get_subtasks(todo_id: int, db: Session = Depends(get_db)):
    todo = db.query(Todo).filter(Todo.id == todo_id).first()
    if not todo:
        raise HTTPException(status_code=404, detail="Todo not found")
    return todo.subtasks

@router.post("/{todo_id}/subtasks", response_model=SubtaskCreate)
def create_subtask(todo_id: int, subtask: SubtaskCreate, db: Session = Depends(get_db)):
    todo = db.query(Todo).filter(Todo.id == todo_id).first()
    if not todo:
        raise HTTPException(status_code=404, detail="Todo not found")
    
    max_position = db.query(Subtask).filter(Subtask.parent_todo_id == todo_id).count()
    db_subtask = Subtask(
        title=subtask.title,
        completed=subtask.completed,
        parent_todo_id=todo_id,
        position=max_position + 1
    )
    db.add(db_subtask)
    db.commit()
    db.refresh(db_subtask)
    return db_subtask

@router.patch("/{todo_id}/subtasks/{subtask_id}/toggle")
def toggle_subtask(todo_id: int, subtask_id: int, db: Session = Depends(get_db)):
    todo = db.query(Todo).filter(Todo.id == todo_id).first()
    if not todo:
        raise HTTPException(status_code=404, detail="Todo not found")
    
    subtask = db.query(Subtask).filter(
        Subtask.id == subtask_id,
        Subtask.parent_todo_id == todo_id
    ).first()
    
    if not subtask:
        raise HTTPException(status_code=404, detail="Subtask not found")
    
    subtask.completed = not subtask.completed
    db.commit()
    db.refresh(subtask)
    return subtask
