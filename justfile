# Install all dependencies and setup git hooks
install:
    git init
    uv sync
    uv run pre-commit install

# Run
run:
    uv run python -m app.main

# Watch
watch:
    #!/usr/bin/env bash
    watchexec -e py "just run"

# Run all checks
check: lint type-check test 

# Lint and format
lint:
    uv run ruff check .
    uv run ruff format --check .

# Fix linting issues
fix:
    uv run ruff check --fix .
    uv run ruff format .

# Type checking
type-check:
    uv run mypy .

# Run tests
test:
    uv run pytest -n auto

# Run tests against various pythons
test-all:
    #!/usr/bin/env bash
    set -e
    VIRTUAL_ENV=.venv-311 uv run --active --python 3.11 pytest -n auto
    VIRTUAL_ENV=.venv-312 uv run --active --python 3.12 pytest -n auto
    VIRTUAL_ENV=.venv-313 uv run --active --python 3.13 pytest -n auto
    echo "🎉 All Python versions tested!"

# Run tests against various pythons in parallel
test-all-parallel:
    #!/usr/bin/env bash
    set -e
    VIRTUAL_ENV=.venv-311 uv run --active --python 3.11 pytest -n 4 &
    VIRTUAL_ENV=.venv-312 uv run --active --python 3.12 pytest -n 4 &
    VIRTUAL_ENV=.venv-313 uv run --active --python 3.13 pytest -n 4 &
    wait
    echo "🎉 All Python versions tested!"

# Test with coverage
test-cov:
    uv run pytest --cov=src --cov-report=html

# Security check
security:
    uv run bandit -r src/

# Audit dependencies
audit:
    uv run pip-audit

# Clean only gitignored files
clean:
    git clean -fXd

# See what would be cleaned first  
clean-preview:
    git clean -fXd --dry-run

docker:
    docker build -t $(basename $PWD) --no-cache .