#!/bin/bash

echo "🔍 Checking prerequisites..."
echo

all_good=true

# Function to check if command exists
check_tool() {
    local tool=$1
    local install_hint=$2
    
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✅ $tool found"
    else
        echo "❌ $tool not found - $install_hint"
        all_good=false
    fi
}

# Check each tool
check_tool "uv" "curl -LsSf https://astral.sh/uv/install.sh | sh"
check_tool "just" "brew install just"
check_tool "watchexec" "brew install watchexec (optional)"
check_tool "git" "should be pre-installed"

echo

if [ "$all_good" = true ]; then
    echo "🎉 All prerequisites found!"
    exit 0
else
    echo "⚠️  Some tools are missing. Install them and run again."
    exit 1
fi