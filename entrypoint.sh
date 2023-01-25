#!/bin/sh -l

export TUGBOAT_API_TOKEN=$1

tugboat ls previews repo=$2 -j | jq -r "first(.[] | select(.ref == \"pr$3\") | .id)" | sed 's/^/tugboat-preview-id=/' | cat >> $GITHUB_OUTPUT
