#!/bin/bash

echo Testing git-lfs

#!/bin/bash

if command -v git-lfs &> /dev/null; then
    echo "git-lfs is installed."
    echo "Location: $(command -v git-lfs)"
else
    echo "git-lfs is NOT installed."
    exit 1
fi

# Check if we're in a Git repo
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    echo "Not inside a Git repository."
    exit 1
fi

# Check if git-lfs is initialized in the repo
if git lfs ls-files &> /dev/null; then
    echo "git-lfs is active in this repository."
else
    echo "git-lfs is not active in this repository."
fi

# Check MD5 checksum
TARGET_FILE="image.jpg"
EXPECTED_MD5="31e0ecdcccb346f4dd4b5eb77eb8284b"

if [[ ! -f "$TARGET_FILE" ]]; then
    echo "File not found: $TARGET_FILE"
    exit 1
fi

echo "Checking MD5 for: $TARGET_FILE"
ACTUAL_MD5=$(md5sum "$TARGET_FILE" | awk '{print $1}')

if [[ "$ACTUAL_MD5" == "$EXPECTED_MD5" ]]; then
    echo "MD5 checksum matches ✅ $EXPECTED_MD5"
else
    echo "MD5 checksum does NOT match ❌ $ACTUAL_MD5"
    echo "Expected: $EXPECTED_MD5"
    exit 1
fi
