#!/bin/bash

# Only need to sync images that changed in current commit
FILES=$(git diff-tree --no-commit-id --name-only -r $COMMITID)

for FILE in $FILES
do
     echo "$FILES"
    ./image-syncer --auth=./auth.json --images=$FILE
done