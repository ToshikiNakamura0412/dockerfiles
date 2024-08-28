#!/bin/bash

NEW_ROOT_DIR=$1

if [ -z "$NEW_ROOT_DIR" ]; then
    echo "Usage: $0 <new_root_dir>"
    exit 1
fi

find . -type f -name "docker-compose.yml" -exec sed -i 's|\"~/|\"'$NEW_ROOT_DIR'/|g' {} \;
find . -type f -name "setup.sh" -exec sed -i 's|~/|'$NEW_ROOT_DIR'/|g' {} \;
