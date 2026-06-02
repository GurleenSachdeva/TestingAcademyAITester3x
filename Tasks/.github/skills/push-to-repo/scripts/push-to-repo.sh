#!/bin/bash
# Push to Repository Helper Script with README Generation
# Usage: ./push-to-repo.sh [branch-name]
# If no branch is provided, defaults to 'main'

set -e  # Exit on error

BRANCH="${1:-main}"
REMOTE="origin"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Syncing repository: $REMOTE/$BRANCH"

# Check if working tree is clean
if ! git diff-index --quiet HEAD --; then
    echo "⚠️  Warning: Uncommitted changes detected"
    echo "Stashing changes..."
    git stash
    STASHED=true
fi

# Generate or update README
echo "📝 Generating README.md..."
bash "$SCRIPT_DIR/generate-readme.sh"

# Check if README was created/modified and commit it
if git status --porcelain | grep -q "README.md"; then
    echo "📋 Committing README changes..."
    git add README.md
    git commit -m "docs: Auto-generated README update"
fi

# Fetch latest remote changes
echo "📥 Fetching latest changes from $REMOTE..."
git fetch "$REMOTE"

# Pull with rebase
echo "🔗 Rebasing on $REMOTE/$BRANCH..."
git pull "$REMOTE" "$BRANCH" --rebase

# Push to remote
echo "📤 Pushing to $REMOTE/$BRANCH..."
git push "$REMOTE" "$BRANCH"

echo "✅ Successfully pushed to $REMOTE/$BRANCH"

# Restore stashed changes if any
if [ "$STASHED" = true ]; then
    echo "📋 Restoring stashed changes..."
    git stash pop
fi
