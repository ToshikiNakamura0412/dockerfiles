SCRIPT_DIR=$(cd $(dirname $0); pwd)
DISTROS=$(ls -d ${SCRIPT_DIR}/../*/ | sed 's|'${SCRIPT_DIR}\/..\/'||g' | sed 's/\///g')
INVALID_DISTROS=(
    "scripts"
    "alpine3.17"
    "debian"
    "fedora"
    "opensuse"
)

ERROR_COUNT_OF_DELETE_LINES=0
ERROR_COUNT_OF_INSERT_LINES=0

function is_invalid_distro() {
    local distro=$1
    for invalid_distro in ${INVALID_DISTROS[@]}; do
        if [[ ${distro} == ${invalid_distro} ]]; then
            return 0
        fi
    done
    return 1
}

# You should set unique element in the target file at the end of the array 'target_strings' to avoid deleting other lines.
function delete_lines_all_distros() {
    local file_name=$1
    shift 1
    local target_strings=("$@")
    local search_string=$(echo ${target_strings[-1]} | sed 's/\\//g' | sed 's/^ *//g')

    for distro in ${DISTROS[@]}; do
        if ! is_invalid_distro ${distro}; then
            local target_file=${SCRIPT_DIR}/../${distro}/${file_name}
            if grep -Fq "${search_string}" ${target_file}; then
                while grep -Fq "${search_string}" ${target_file}; do
                    target_line=$(grep -Fn "${search_string}" ${target_file} | cut -d ":" -f 1 | head -n 1)
                    sed -i "$((target_line - ${#target_strings[@]} + 1)),$((target_line))d" ${target_file}
                done
            else
                ERROR_COUNT_OF_DELETE_LINES=$((ERROR_COUNT_OF_DELETE_LINES + 1))
            fi
        fi
    done
}

# The array 'target_strings' is inserted once in the line following 'search_string'.
function insert_lines() {
    local target_file=$1
    local search_string=$2
    shift 2
    local target_strings=("$@")

    for ((i=${#target_strings[@]}-1; i>=0; i--)); do
        local target_line=$(grep -Fn "${search_string}" ${target_file} | cut -d ":" -f 1 | head -n 1)
        if [[ -n ${target_line} ]]; then
            sed -i "${target_line}a ${target_strings[i]}" ${target_file}
        else
            echo -e "\e[33mError: '${search_string}' not found in ${target_file}. Failed to insert target strings.\e[m"
            ERROR_COUNT_OF_INSERT_LINES=$((ERROR_COUNT_OF_INSERT_LINES + 1))
        fi
    done
}

function insert_lines_all_distros() {
    local file_name=$1
    local search_string=$2
    shift 2
    local target_strings=("$@")

    for distro in ${DISTROS[@]}; do
        if ! is_invalid_distro ${distro}; then
            local target_file=${SCRIPT_DIR}/../${distro}/${file_name}
            insert_lines ${target_file} ${search_string} "${target_strings[@]}"
        fi
    done
}
