.PHONY: help install dev build run test clean docker-build docker-up docker-down docker-logs lint format db-reset db-migrate

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install dependencies
	uv venv
	uv pip install -r requirements.txt

dev: ## Run development server with SQLite
	@if [ ! -f .env ]; then cp .env.example .env; fi
	uv run uvicorn backend.main:app --reload --host 0.0.0.0 --port 8000

dev-postgres: ## Run development server with PostgreSQL
	docker-compose up -d postgres
	@echo "Waiting for PostgreSQL to be ready..."
	@sleep 5
	uv run uvicorn backend.main:app --reload --host 0.0.0.0 --port 8000

build: ## Build application
	uv build

run: ## Run production server
	uvicorn backend.main:app --host 0.0.0.0 --port 8000 --workers 4

test: ## Run tests
	uv run pytest tests/ -v --cov=backend --cov-report=html

clean: ## Clean up temporary files
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find backend/ -type f -name "*.db" -delete
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	rm -rf htmlcov/
	rm -rf .coverage
	rm -rf .pytest_cache

docker-build: ## Build Docker image
	docker build -t notion-todo-list .

docker-up: ## Start Docker containers (PostgreSQL + App)
	docker-compose up -d

docker-down: ## Stop Docker containers
	docker-compose down

docker-logs: ## Show Docker logs
	docker-compose logs -f

docker-restart: ## Restart Docker containers
	docker-compose restart

docker-clean: ## Remove Docker containers and volumes
	docker-compose down -v
	docker system prune -f

lint: ## Run linting
	source venv/bin/activate && ruff check backend/
	source venv/bin/activate && ruff check --select I --fix backend/

format: ## Format code
	source venv/bin/activate && black backend/
	source venv/bin/activate && isort backend/

db-reset: ## Reset SQLite database
	find backend/ -type f -name "*.db" -delete
	@echo "Database reset successfully"

db-migrate: ## Run database migrations
	@echo "Running database migrations..."
	@python3 -c "from backend.utils.database import init_db; init_db()"
	@echo "Migrations completed"

setup: install ## Full setup (install and initialize)
	@if [ ! -f .env ]; then cp .env.example .env; fi
	@echo "Setup complete! Run 'make dev' to start the development server."

all: clean install lint test ## Run all checks (clean, install, lint, test)
