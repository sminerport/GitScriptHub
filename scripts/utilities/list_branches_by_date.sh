#!/bin/bash
# Script to list all Git branches sorted by last commit date

echo "Listing all branches sorted by the last commit date:"
git for-each-ref --sort=committerdate refs/heads/ refs/remotes/ --format="%(committerdate:relative) %(refname:short)"
