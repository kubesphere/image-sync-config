#!/bin/bash

# Only need to sync images that changed in current commit
FILES=$(find rules -type f)

for FILE in $FILES
do
     echo "========> Syncing: $FILES <========"
    ./image-syncer --auth=./auth.json --images=${FILE}
done