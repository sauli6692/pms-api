#!/bin/bash

# Source the virtual environment created by Poetry
source /app/.venv/bin/activate

# Change to the Django project directory
cd /app

# Apply database migrations
echo "Apply database migrations"
scripts/wait-for-it.sh ${WAIT_HOSTS} -- python manage.py migrate

# Add superuser
echo "Add superuser"
python manage.py create_superuser

# Start server
echo "Starting server"
python manage.py runserver 0.0.0.0:8000