#!/bin/bash

BASE_URL=$1
ANNOUNCEMENT_TEMPLATE=$2
SUBDIRECTORY=${3:-"posts"}

# Find the latest added post
LATEST_POST=$(git diff --diff-filter=A --name-only HEAD~1 HEAD -- "content/$SUBDIRECTORY/" | grep "\.md$" | head -1)

if [ -z "$LATEST_POST" ]; then
  echo "No new post added in the last commit."
  exit 0
fi

# Extract post metadata
TITLE=$(grep -m1 '^title:' "$LATEST_POST" | cut -d: -f2 | xargs)
TAGS=$(grep -m1 '^tags:' "$LATEST_POST" | cut -d: -f2- | xargs | sed -E 's/\[|\]//g' | tr ',' '\n' | xargs -I {} echo "#{}" | tr '\n' ' ')
DESCRIPTION=$(grep -m1 '^description:' "$LATEST_POST" | cut -d: -f2 | xargs)

# Generate post URL
POST_PATH=$(echo "$LATEST_POST" | sed -E 's/^content(\/|\\)//' | sed -E 's/\.md$//')
POST_URL="${BASE_URL}/${POST_PATH}"

# Prepare the announcement text
ANNOUNCEMENT=$(echo "$ANNOUNCEMENT_TEMPLATE" | sed "s|{{TITLE}}|$TITLE|g" | sed "s|{{POST_URL}}|$POST_URL|g" | sed "s|{{TAGS}}|$TAGS|g" | sed "s|{{DESCRIPTION}}|$DESCRIPTION|g")

# Output the announcement text
echo "$ANNOUNCEMENT"
