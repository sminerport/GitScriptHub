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

# Function to increment the tag version
increment_tag() {
    local tag=$1
    local IFS='.'
    local parts=($tag)
    local last_index=$((${#parts[@]} - 1))
    parts[$last_index]=$((parts[$last_index] + 1))
    echo "${parts[*]}"
}

# Fetch the latest updates from the origin
git fetch origin

# Checkout the specified branch
git checkout $BRANCH_NAME

# Ensure the branch is up-to-date
git pull origin $BRANCH_NAME

# Check if the tag already exists and increment if necessary
original_tag=$TAG_NAME
while git rev-parse "$TAG_NAME" >/dev/null 2>&1; do
    echo "Tag $TAG_NAME already exists. Incrementing the tag."
    TAG_NAME=$(increment_tag $TAG_NAME)
done

# Create an annotated tag
git tag -a $TAG_NAME -m "$MESSAGE"

# Check if the local branch is ahead of the remote branch
if [ $(git rev-list --count origin/$BRANCH_NAME..$BRANCH_NAME) -gt 0 ]; then
    echo "Local branch $BRANCH_NAME is ahead of the remote. Pushing local commits first."
    git push origin $BRANCH_NAME
fi

# Push the tag to the remote repository
git push origin $TAG_NAME

echo "Tag $TAG_NAME created for branch $BRANCH_NAME and pushed to remote."
if [ "$TAG_NAME" != "$original_tag" ]; then
    echo "Note: The tag was incremented to $TAG_NAME because $original_tag already exists."
fi
