#!/bin/bash

echo "Starting Notion-Style Todo List Application..."
echo "============================================"
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Create database directory if it doesn't exist
mkdir -p database

# Start the server
echo ""
echo "Starting server on http://localhost:8000"
echo "Press Ctrl+C to stop the server"
echo ""
uvicorn backend.main:app --reload --host 0.0.0.0 --port 8000
