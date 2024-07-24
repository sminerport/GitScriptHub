#!/bin/bash

# Script to archive and delete Git branches

# Check if the branch name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <branch_name>"
    exit 1
fi

BRANCH_NAME=$1

# Create a tag for archiving the branch
TAG_NAME="archive/${BRANCH_NAME}-$(date +%Y-%m-%d)"
git tag $TAG_NAME $BRANCH_NAME

# Push the tag to remote
git push origin $TAG_NAME

# Delete the branch locally
git branch -d $BRANCH_NAME

# Delete the branch remotely
git push origin --delete $BRANCH_NAME

echo "Branch '$BRANCH_NAME' has been archived as '$TAG_NAME' and deleted."
