#!/opt/homebrew/bin/bash

set -uo pipefail

args="$*"
k=$(echo "$args" | cut -f1 -d' ')
dirs=$(echo "$args" | cut -f2- -d' ')

top_k_files="$(find $dirs -type f | grep -v git | grep -v main.sh | xargs ls -l | cut -f8- -d' '| sort -r | head -n "$k")"

readarray top_k_files_arr < <(echo "$top_k_files")
for entry in "${top_k_files_arr[@]}"; do
    entry=$(echo "$entry" | tr -d '\n')
    size=$(echo "$entry" | cut -f1 -d' ')
    dir_name=$(echo "$entry" | cut -f5 -d' ' | xargs dirname)
    base_name=$(echo "$entry" | cut -f5 -d' ' | xargs basename)
    printf "dirname=%s\tbasename=%s\tsize=%s\n" "$dir_name" "$base_name" "$size"
done

