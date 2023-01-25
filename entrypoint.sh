#!/bin/sh -l

echo "Repo: $1"
time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT

export TUGBOAT_API_TOKEN=$1

tugboat ls previews repo=$2 -j | jq -r "first(.[] | select(.ref == \"pr$3\") | .id)" | xargs tugboat rebuild
