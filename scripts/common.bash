SCRIPT_DIR=$(cd $(dirname $0); pwd)
DISTROS=$(ls -d ${SCRIPT_DIR}/../*/ | sed 's|'${SCRIPT_DIR}\/..\/'||g' | sed 's/\///g')
INVALID_DISTROS=(
    "scripts"
)

ERROR_COUNT_OF_DELETE_LINES=0
ERROR_COUNT_OF_INSERT_LINES=0

function get_distro() {
    if [[ "$(uname)" == "Linux" ]] && [[ -e /etc/os-release ]]; then
        source /etc/os-release
        echo ${ID}
    elif [[ "$(uname)" == "Darwin" ]]; then
        echo "mac"
    else
        echo ""
    fi
}

function is_invalid_distro() {
    local distro=$1
    if [[ -z ${distro} ]]; then
        printf "\e[31mError: distro is empty\e[m\n"
        return 0
    fi
    for invalid_distro in ${INVALID_DISTROS[@]}; do
        if [[ ${distro} == ${invalid_distro} ]]; then
            return 0
        fi
    done
    return 1
}

# You should set unique element in the target file at the end of the array 'target_strings' to avoid deleting other lines.
function delete_lines() {
    local target_file=$1
    if [[ -z ${target_file} ]]; then
        printf "\e[31mError: target_file is empty\e[m\n"
        return
    fi
    shift 1
    local target_strings=("$@")
    if [[ ${#target_strings[@]} -eq 0 ]]; then
        printf "\e[31mError: target_strings is empty\e[m\n"
        return
    fi
    local search_string=$(echo ${target_strings[${#target_strings[@]}-1]} | sed 's/\\//g' | sed 's/^ *//g')

    if grep -Fq "${search_string}" ${target_file}; then
        while grep -Fq "${search_string}" ${target_file}; do
            target_line=$(grep -Fn "${search_string}" ${target_file} | cut -d ":" -f 1 | head -n 1)
            if [[ $(get_distro) == "mac" ]]; then
                sed -i '' "$((target_line - ${#target_strings[@]} + 1)),$((target_line))d" ${target_file}
            else
                sed -i "$((target_line - ${#target_strings[@]} + 1)),$((target_line))d" ${target_file}
            fi
        done
    else
        ERROR_COUNT_OF_DELETE_LINES=$((ERROR_COUNT_OF_DELETE_LINES + 1))
    fi
}

function delete_lines_all_distros() {
    local file_name=$1
    if [[ -z ${file_name} ]]; then
        printf "\e[31mError: file_name is empty\e[m\n"
        return
    fi
    shift 1
    local target_strings=("$@")
    if [[ ${#target_strings[@]} -eq 0 ]]; then
        printf "\e[31mError: target_strings is empty\e[m\n"
        return
    fi

    for distro in ${DISTROS[@]}; do
        if ! is_invalid_distro ${distro}; then
            local target_file=${SCRIPT_DIR}/../${distro}/${file_name}
            delete_lines ${target_file} "${target_strings[@]}"
        fi
    done
}

# The array 'target_strings' is inserted once in the line following 'search_string'.
function insert_lines() {
    local target_file=$1
    if [[ -z ${target_file} ]]; then
        printf "\e[31mError: target_file is empty\e[m\n"
        return
    fi
    local search_string=$2
    if [[ -z ${search_string} ]]; then
        printf "\e[31mError: search_string is empty\e[m\n"
        return
    fi
    shift 2
    local target_strings=("$@")
    if [[ ${#target_strings[@]} -eq 0 ]]; then
        printf "\e[31mError: target_strings is empty\e[m\n"
        return
    fi

    for ((i=${#target_strings[@]}-1; i>=0; i--)); do
        local target_line=$(grep -Fn "${search_string}" ${target_file} | cut -d ":" -f 1 | head -n 1)
        if [[ -n ${target_line} ]]; then
            if [[ $(get_distro) == "mac" ]]; then
                sed -i '' "${target_line}a\\
${target_strings[i]}\\
" ${target_file}
            else
                sed -i "${target_line}a ${target_strings[i]}" ${target_file}
            fi
        else
            printf "\e[33mError: '${search_string}' not found in ${target_file}. Failed to insert target strings.\e[m\n"
            ERROR_COUNT_OF_INSERT_LINES=$((ERROR_COUNT_OF_INSERT_LINES + 1))
        fi
    done
}

function insert_lines_all_distros() {
    local file_name=$1
    if [[ -z ${file_name} ]]; then
        printf "\e[31mError: file_name is empty\e[m\n"
        return
    fi
    local search_string=$2
    if [[ -z ${search_string} ]]; then
        printf "\e[31mError: search_string is empty\e[m\n"
        return
    fi
    shift 2
    local target_strings=("$@")
    if [[ ${#target_strings[@]} -eq 0 ]]; then
        printf "\e[31mError: target_strings is empty\e[m\n"
        return
    fi

    for distro in ${DISTROS[@]}; do
        if ! is_invalid_distro ${distro}; then
            local target_file=${SCRIPT_DIR}/../${distro}/${file_name}
            insert_lines ${target_file} ${search_string} "${target_strings[@]}"
        fi
    done
}
