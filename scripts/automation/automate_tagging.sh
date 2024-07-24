#!/bin/bash

# Usage: ./automate_tagging.sh <branch_name> <tag_name> <message>
# Example: ./automate_tagging.sh feature/add-vibrant v1.0.0 "Release version 1.0.0"

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <branch_name> <tag_name> <message>"
    exit 1
fi

BRANCH_NAME=$1
TAG_NAME=$2
MESSAGE=$3

# Fetch the latest updates from the origin
git fetch origin

# Checkout the specified branch
git checkout $BRANCH_NAME

# Ensure the branch is up-to-date
git pull origin $BRANCH_NAME

# Create an annotated tag
git tag -a $TAG_NAME -m "$MESSAGE"

# Push the tag to the remote repository
git push origin $TAG_NAME

echo "Tag $TAG_NAME created for branch $BRANCH_NAME and pushed to remote."
