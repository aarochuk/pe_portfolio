#!/bin/bash

# redeploy-site.sh
# Simple script to redeploy Flask application on VPS

echo "Starting Flask application redeployment..."

# Step 1: Navigate to project folder
echo "Step 2: Navigating to project folder..."
PROJECT_DIR="$HOME/25.SUM.B3-Portfolio-Site"

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

# Step 3: Spin containers down to prevent out of memory issues
docker compose -f docker-compose.prod.yml down

# Step 4: Run containers
docker compose -f docker-compose.prod.yml up -d --build
