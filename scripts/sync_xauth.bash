#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/common.bash

TARGET_FILE_NAME="docker-compose.yml"

INSERT_POINT_STRING1="ws:"
# You should set unique element in the target file at the end of the array to avoid deleting other lines.
# TARGET_STRINGS is inserted once in the line following INSERT_POINT_STRING.
TARGET_STRINGS1=(
  "\    network_mode: host"
)

INSERT_POINT_STRING2=" environment:"
# You should set unique element in the target file at the end of the array to avoid deleting other lines.
# TARGET_STRINGS is inserted once in the line following INSERT_POINT_STRING.
TARGET_STRINGS2=(
  "\      XAUTHORITY: \$XAUTHORITY"
)

INSERT_POINT_STRING3=" volumes:"
# You should set unique element in the target file at the end of the array to avoid deleting other lines.
# TARGET_STRINGS is inserted once in the line following INSERT_POINT_STRING.
TARGET_STRINGS3=(
  "\      - type: bind"
  "\        source: \$XAUTHORITY"
  "\        target: \$XAUTHORITY"
)

function disable_xauth_sync() {
  delete_lines_all_distros ${TARGET_FILE_NAME} "${TARGET_STRINGS1[@]}"
  delete_lines_all_distros ${TARGET_FILE_NAME} "${TARGET_STRINGS2[@]}"
  delete_lines_all_distros ${TARGET_FILE_NAME} "${TARGET_STRINGS3[@]}"
}

function enable_xauth_sync() {
  disable_xauth_sync
  insert_lines_all_distros ${TARGET_FILE_NAME} ${INSERT_POINT_STRING1} "${TARGET_STRINGS1[@]}"
  insert_lines_all_distros ${TARGET_FILE_NAME} ${INSERT_POINT_STRING2} "${TARGET_STRINGS2[@]}"
  insert_lines_all_distros ${TARGET_FILE_NAME} ${INSERT_POINT_STRING3} "${TARGET_STRINGS3[@]}"
  echo "Enabled xauth sync"
}

function show_usage() {
    echo "Usage:"
    echo "    Enable xauth sync: $0"
    echo "    Disable xauth sync: $0 disable"
}

function main() {
  if [[ $1 == "-h" || $1 == "--help" ]]; then
    show_usage
  elif [[ $# -eq 0 ]]; then
    enable_xauth_sync
  elif [[ $1 == "disable" ]]; then
    disable_xauth_sync
    echo "Disabled xauth sync"
  else
    echo "Invalid option: $1"
    show_usage
  fi
}

main $@
