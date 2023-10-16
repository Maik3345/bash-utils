#!/bin/bash

# 1. Get the branch name
BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD | sed 's/^origin\///')"
# 2. Get the author name
AUTHOR_NAME=$(git log -1 --pretty=format:%an)
# Branch ID
BRANCH_ID=""

# Function for extracting the branch ID
extract_branch_id() {
  # Regex for extracting the branch ID
  regex='\/([0-9]+)|\/([0-9]+)-$'

  if [[ $1 =~ $regex ]]; then
    branch_id="${BASH_REMATCH[1]}"
    if [ -z "$branch_id" ]; then
      branch_id="${BASH_REMATCH[2]}"
    fi
    BRANCH_ID=$branch_id
  else
    echo "Upps!! not found the branch id in the current branch: $1"
  fi
}

check_branch_id() {
  # Validate the branch id
  if [ -n "$1" ]; then
    echo "Branch ID: $1"
  else
    # Notify the user that the branch id could not be determined
    echo "Not able to determine the branch ID."
    exit 1
  fi
}

check_author_name() {
  if [ -z "$1" ]; then
    echo "Upps!! not found the author name"
    exit 1
  fi
}

update_commit_message() {
  commitMsgFile=$1
  msg=$(cat "$commitMsgFile")
  echo "[$AUTHOR_NAME][$BRANCH_ID] - $msg" >"$commitMsgFile"

}

# Get the branch ID
extract_branch_id "$BRANCH_NAME"
check_branch_id "$BRANCH_ID"
check_author_name "$AUTHOR_NAME"
update_commit_message "$1"
