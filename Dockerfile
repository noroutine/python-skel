# Use Python slim image as base
FROM python:3.13-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Set working directory
WORKDIR /app

# Copy dependency files first (better caching)
COPY pyproject.toml uv.lock ./

# Copy application code
COPY . .

# Install dependencies and project
RUN uv sync --frozen --no-dev

# Copy application code
COPY . .

# Set the command
CMD ["uv", "run", "python", "-m", "src.app.main"]