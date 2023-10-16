#!/bin/bash

branch="$(git rev-parse --abbrev-ref HEAD | sed 's/^origin\///')"
commitMsgFile=$1
msg=$(cat "$commitMsgFile")
echo "$branch: $msg" >"$commitMsgFile"
