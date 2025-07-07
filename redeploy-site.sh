#!/bin/bash

# redeploy-site.sh
# Simple script to redeploy Flask application on VPS

echo "Starting Flask application redeployment..."

# Step 1: Kill all existing tmux sessions
echo "Step 1: Killing all existing tmux sessions..."
tmux kill-server 2>/dev/null || echo "No tmux sessions to kill"

# Step 2: Navigate to project folder
echo "Step 2: Navigating to project folder..."
PROJECT_DIR="$HOME/25.SUM.B3-Portfolio-Site"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory $PROJECT_DIR not found!"
    exit 1
fi

cd "$PROJECT_DIR"
echo "Now in directory: $(pwd)"

# Step 3: Update git repository
echo "Step 3: Updating git repository..."
git fetch && git reset origin/main --hard
echo "Git repository updated to latest main branch"

# Step 4: Enter virtual environment and install dependencies
echo "Step 4: Setting up Python virtual environment..."

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating new virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
source "venv/bin/activate"
echo "Virtual environment activated"

# Install/update dependencies
echo "Installing Python dependencies..."
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
    echo "Dependencies installed from requirements.txt"
else
    echo "Warning: requirements.txt file not found. Skipping dependency installation."
fi

# Step 5: Start new detached tmux session
echo "Step 5: Starting new detached tmux session..."

# Create new tmux session named 'flask-app' in detached mode
tmux new-session -d -s flask-app -c "$PROJECT_DIR"

# Send commands to the tmux session
tmux send-keys -t flask-app "source venv/bin/activate" Enter
tmux send-keys -t flask-app "flask run --host=0.0.0.0" Enter

echo "Flask server started in detached tmux session 'flask-app'
echo ""
echo "Deployment completed successfully!"
