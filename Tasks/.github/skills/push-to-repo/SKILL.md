---
name: push-to-repo
description: 'Push code changes to a GitHub repository with automatic fetching and rebasing. Use when: committing and pushing code to remote, handling merge conflicts, syncing local changes with remote branch.'
argument-hint: 'Optional: repository URL, branch name, or commit message'
user-invocable: true
---

# Push Code to Repository

Automates the process of pushing code changes to a Git repository with proper conflict resolution and synchronization.

## When to Use

- Pushing committed code to a remote repository
- Syncing local changes with remote branch
- Handling non-fast-forward errors
- Ensuring local changes are synced before pushing

## Prerequisites

- Git repository initialized locally
- Remote repository configured (origin)
- Changes committed to local branch

## Procedure

### Quick Push (Recommended)
1. Verify working tree is clean: `git status`
2. Fetch latest remote changes: `git fetch origin`
3. Rebase local commits on remote: `git pull origin <branch> --rebase`
4. Push to remote: `git push origin <branch>`

### Step-by-Step

1. **Check Status**
   - Run `git status` to verify all changes are committed
   - Stash any uncommitted changes if needed: `git stash`

2. **Fetch Remote Updates**
   - Run `git fetch origin` to get latest remote changes
   - This prevents push rejections due to remote updates

3. **Sync Local Branch**
   - Run `git pull origin <branch> --rebase`
   - Rebase keeps history clean without merge commits
   - Resolve any conflicts if they arise

4. **Push Changes**
   - Run `git push origin <branch>`
   - Confirm the push completed successfully

### Common Scenarios

**Scenario: Non-fast-forward error**
```bash
# Fetch and rebase, then push
git fetch origin
git pull origin main --rebase
git push origin main
```

**Scenario: Need to push to specific branch**
```bash
# Replace 'branch-name' with your branch
git fetch origin
git pull origin branch-name --rebase
git push origin branch-name
```

**Scenario: Verify before pushing**
```bash
# View commits to be pushed
git log origin/main..HEAD

# Then push
git push origin main
```

## Related References

- [Git Push Documentation](https://git-scm.com/docs/git-push)
- [Git Rebase vs Merge](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)
- [Handling Git Conflicts](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)
