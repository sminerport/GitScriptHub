#!/bin/bash

# Navigate to the Git repository directory
cd /path/to/your/repository

# Fetch the latest changes from all branches
git fetch --all

# Checkout the master branch
git checkout master

# Pull the latest updates for master
git pull origin master

# List all branches that have been merged into master
merged_branches=$(git branch --merged master | grep -v "\* master" | grep -v "master")

echo "These branches are merged into master and will be deleted:"
echo "$merged_branches"

# Delete each merged branch locally
for branch in $merged_branches; do
    git branch -d "$branch"
done

# Delete each merged branch remotely
for branch in $merged_branches; do
    git push origin --delete "$branch"
done

echo "Cleanup complete."
