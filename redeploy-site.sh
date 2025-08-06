#!/bin/bash

# redeploy-site.sh
# Simple script to redeploy Flask application on VPS

echo "Starting Flask application redeployment..."

# Step 1: Navigate to project folder
echo "Step 1: Navigating to project folder..."
PROJECT_DIR="$HOME/pe-portfolio-site"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory $PROJECT_DIR not found!"
    exit 1
fi

cd "$PROJECT_DIR"
echo "Now in directory: $(pwd)"

# Step 2: Update git repository
echo "Step 3: Updating git repository..."
git fetch && git reset origin/main --hard
echo "Git repository updated to latest main branch"

# Step 3: Activate virtual environment and download dependencies
echo "Activating virtual environment"
source venv/bin/activate
echo "Installing dependencies"
pip install -r requirements.txt

# Step 4: Restart my portfolio service
systemctl daemon-reload
systemctl restart myportfolio
