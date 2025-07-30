# Python Project Skeleton

A modern Python project template using the latest tooling (2025 edition).

## What's This?

This is a **template/skeleton** for Python projects that ditches the old, clunky workflow in favor of modern Rust-based tools. No more juggling 10 different tools - this setup is fast, clean, and actually enjoyable to use.

## The Stack

- **[uv](https://github.com/astral-sh/uv)** - All-in-one Python project management (replaces pip, virtualenv, pyenv, poetry)
- **[ruff](https://github.com/astral-sh/ruff)** - Blazing fast linter + formatter (replaces flake8, black, isort, pyupgrade, etc.)
- **[just](https://github.com/casey/just)** - Task runner (like make, but better)
- **[hatchling](https://hatch.pypa.io/)** - Modern build backend
- **[pytest](https://pytest.org/)** - Testing framework
- **[mypy](https://mypy.readthedocs.io/)** - Type checking

## Project Structure

```
skel/
├── src/app/              # Main application code
│   ├── __init__.py
│   └── main.py           # Entry point
├── tests/                # Test files
│   └── test_main.py
├── scripts/              # Utility scripts
│   └── check-deps.sh     # Prerequisites checker
├── pyproject.toml        # Project config & dependencies
├── justfile              # Task definitions
├── .gitignore
└── README.md
```

## Quick Start

### 1. Setup Project

```bash
# Clone template without git history and reinitialize git
git clone --depth=1 https://github.com/noroutine/python-skel my-project
cd my-project
rm -rf .git
git init # or git remote set-url origin <your upstream>
```
### 2. Check Prerequisites

```bash
./scripts/check-deps.sh
```

**Required:**
- `uv` - Python package manager
- `git` - Version control
- `just` - Task runner

**Optional but recommended:**
- `watchexec` - File watcher for development

### 3. Install and Run

```bash
# Install dependencies and git hooks
just install

# Run the app
just run
# or: uv run python -m app.main
```

## Development Workflow

### Common Tasks

```bash
# Run the application
just run

# Run with file watching (auto-restart on changes)
just watch

# Run all code quality checks
just check

# Format code
just format  

# Run tests
just test

# Run tests for 3 pythons
just test-all

# Run tests for 3 pythons in parallel
just test-all-parallel

# Clean build artifacts
just clean
```

### Adding Dependencies

```bash
# Add runtime dependency
uv add requests

# Add development dependency  
uv add --dev pytest-cov

# Remove dependency
uv remove requests
```

### Testing Multiple Python Versions

```bash
# Install Python versions
uv python install 3.11 3.12 3.13

# Test across versions
uv run --python 3.11 pytest
uv run --python 3.12 pytest
uv run --python 3.13 pytest
```

## Skaffold new project with bash function

## Installation as Shell Function

For quick project creation, add this function to your shell:

```bash
# Add to ~/.bashrc or ~/.zshrc
cat >> ~/.bashrc << 'EOF'
python-skel() {
    local target_dir="${1:-python-project}"
    local repo_url="https://github.com/noroutine/python-skel"
    
    # Check if target directory already exists
    if [ -d "$target_dir" ]; then
        echo "❌ Directory '$target_dir' already exists!"
        echo "💡 Choose a different name or remove the existing directory"
        return 1
    fi
    
    echo "🔄 Creating Python project skeleton in '$target_dir'..."
    
    # Clone without history
    if git clone --depth=1 "$repo_url" "$target_dir" 2>/dev/null; then
        cd "$target_dir"
        
        # Remove git history for clean slate
        rm -rf .git
        
        echo "✅ Skeleton created successfully!"
        echo "🚀 Next steps:"
        echo "   cd $target_dir"
        echo "   just install"
        echo "   just run"
    else
        echo "❌ Failed to clone repository"
        return 1
    fi
}
EOF

# Reload your shell
source ~/.bashrc
```

### Usage
```
# Create project in 'my-app' folder
python-skel my-app

# Then setup
cd my-app
just install
```

## Key Features

### ⚡ Blazing Fast
- `uv` installs packages 10-100x faster than pip
- `ruff` lints/formats entire codebases in milliseconds
- Global package caching means recreating environments is nearly instant

### 🧹 Clean & Simple
- One tool (`uv`) handles environments, dependencies, and Python versions
- One tool (`ruff`) handles all code quality
- `git clean -fXd` cleans all build artifacts safely

### 🔧 Modern Tooling
- All tools are actively maintained and fast
- Configuration is minimal and lives in `pyproject.toml`
- No more `requirements.txt`, `setup.py`, or complex build configs

### 📦 Template Ready
- Generic `src/app/` structure - no renaming needed
- Copy this skeleton for new projects
- Just change the project name in `pyproject.toml`

## Files Explained

### `pyproject.toml`
Modern Python project configuration. Contains:
- Project metadata and dependencies
- Tool configurations (ruff, mypy, etc.)
- Build system setup

### `justfile`
Task definitions. Common commands:
- `just run` - Run the app
- `just check` - Code quality checks
- `just watch` - Development mode with auto-reload

### `src/app/`
Application code. Using `app` as package name makes this template reusable - you never need to rename the package, just change the project name.

## Why This Stack?

### The Old Way (painful):
- virtualenv + pip + requirements.txt + setup.py
- flake8 + black + isort + pyupgrade + bandit
- Complex configuration across multiple files
- Slow installs, slow linting, lots of boilerplate

### The New Way (this template):
- `uv` handles everything Python-related
- `ruff` handles all code quality
- Single `pyproject.toml` config
- Everything is fast and just works

## Tips for Future Me

1. **Don't activate virtual environments manually** - use `uv run` for everything
2. **Global tools go in `uv tool install`** - keeps project environments clean  
3. **Use `just watch` during development** - auto-restart on file changes
4. **`git clean -fXd`** is the best clean command - only removes gitignored files
5. **The `src/app/` structure is template-friendly** - reuse without renaming

## Migration from Old Projects

If you have an old Python project with pip/requirements.txt:

```bash
# Convert requirements.txt to pyproject.toml
uv init --lib  # or --app for applications
uv add $(cat requirements.txt | grep -v '^#' | tr '\n' ' ')

# Move code to src/app/
mkdir -p src/app
mv your_main_module/* src/app/

# Set up tooling
cp justfile pyproject.toml .gitignore from this template
```

---

*This template represents the modern Python development experience as of 2025. Fast, clean, and actually enjoyable to use.*