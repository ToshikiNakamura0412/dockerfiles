#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/common.bash

TARGET_FILE_NAME="Dockerfile"
INSERT_POINT_STRING="~/dotfiles/install.bash"
# You should set unique element in the target file at the end of the array to avoid deleting other lines.
# TARGET_STRINGS_GIT is inserted once in the line following INSERT_POINT_STRING_GIT.
TARGET_STRING="\~/dotfiles/nvim/scripts/use_osc52.sh"

delete_lines_all_distros ${TARGET_FILE_NAME} "${TARGET_STRING}"
insert_lines_all_distros ${TARGET_FILE_NAME} ${INSERT_POINT_STRING} "${TARGET_STRING}"

echo ""
echo "Use OSC52 for clipboard."
echo "You can copy text from the container to the host clipboard using OSC52."
echo ""
