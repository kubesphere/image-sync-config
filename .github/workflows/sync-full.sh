#!/bin/bash

# Only need to sync images that changed in current commit
FILES=$(ls rules)

for FILE in $FILES
do
     echo "$FILES"
    ./image-syncer --auth=./auth.json --images=rules/$FILE
done