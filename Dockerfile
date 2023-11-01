# Use an official Python runtime as a parent image
FROM python:3.10

# Set environment variables for Python to run in unbuffered mode
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create and set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/usr/local/bin/poetry python -
RUN echo "Poetry installation status: $?"

# Add Poetry bin directory to PATH
ENV PATH="${PATH}:/usr/local/bin/poetry/bin"
RUN ls /usr/local/bin/

# Copy the project's pyproject.toml and poetry.lock to the container
COPY pyproject.toml poetry.lock /app/

# Install project dependencies
RUN poetry config virtualenvs.create false \
    && poetry install

COPY ./scripts /app/scripts
# Make your entrypoint script executable
RUN chmod +x /app/scripts/wait-for-it.sh

# Copy the rest of the project files to the container
COPY . /app/

# Expose the port your application will run on
EXPOSE 8000
