#!/usr/bin/env bash
# setup-hooks.sh — One-liner git hooks setup for any project repo
# Usage: curl -fsSL https://raw.githubusercontent.com/<ORG>/GitHooker/main/setup-hooks.sh | bash
set -e

# ─── Configuration ────────────────────────────────────────────────────────────
# Change this to your GitHooker repo's raw URL
REPO_RAW_URL="https://raw.githubusercontent.com/pgwindy/GitHooker/test_git_hooks"
# ──────────────────────────────────────────────────────────────────────────────

echo "🚀 Initializing Local Git Hooks..."

# 1. Verify we are inside a git repository
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    echo "❌ Not inside a git repository. Please cd into your project first."
    exit 1
fi

PROJECT_ROOT=$(git rev-parse --show-toplevel)

# 2. Ensure Homebrew is available
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is required but not installed. Please install Homebrew first."
    exit 1
fi

# 3. Install required tools
echo "📦 Installing pre-commit, gitleaks, tflint, node, and checkstyle..."
brew install pre-commit gitleaks tflint node checkstyle

# 4. Download configuration files from GitHooker repo
echo "⬇️  Downloading hook configuration files..."
curl -fsSL "${REPO_RAW_URL}/.pre-commit-config.yaml" -o "${PROJECT_ROOT}/.pre-commit-config.yaml"
curl -fsSL "${REPO_RAW_URL}/.eslintrc.json" -o "${PROJECT_ROOT}/.eslintrc.json"

# 5. Register hooks with Git
echo "🔗 Registering hooks with Git..."
cd "${PROJECT_ROOT}"
pre-commit install

echo ""
echo "✅ Success! Pre-commit hooks are now active."
echo "📁 Added to your project:"
echo "   • .pre-commit-config.yaml"
echo "   • .eslintrc.json"
echo ""
echo "💡 Commands:"
echo "   pre-commit run --all-files   Run all hooks manually"
echo "   pre-commit autoupdate        Update hook versions"
