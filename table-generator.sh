#!/bin/bash

count_character() {
    local string=$1
    local character=$2

    local occurences
    occurences=$(grep -o "$character" <<<"$string" | grep -c .)

    echo "$occurences"
}

get_row_counting() {
    local rows=$1
    local splitter_counter
    splitter_counter=$(count_character "$rows" ":")

    echo $((splitter_counter + 1))
}

create_rows() {
    local rows=$1

    local total_rows
    local row_counter
    local parsed

    total_rows=$(get_row_counting "$rows")
    row_counter=0

    IFS='-' read -r -a rows_list <<<"${rows#-}"
    while [ $row_counter -lt "$total_rows" ]; do
        local row=${rows_list[$row_counter]}
        
        if [ -z "$row" ]; then
            ((row_counter++))
            continue
        fi

        local new_row="${row//:/" | "}"
        parsed+="| $new_row |\n"

        ((row_counter++))
    done

    echo -e "$parsed"
}

get_header_counting() {
    local columns=$1
    local splitter_counter
    splitter_counter=$(count_character "$columns" ":")

    echo $((splitter_counter + 1))
}

create_columns() {
    local columns=$1
    local separator
    local final_header
    local separators
    local new_header

    new_header="${columns//:/"** | **"}"
    final_header="| **${new_header^^}** |"
    separators=$(build_separator "$final_header")

    echo "$final_header"
    echo "$separators"
}


build_separator() {
    local rows=$1

    separator=""
    IFS='|' read -r -a rows_list <<<"${rows}"
    for row in "${rows_list[@]}"; do
        if [[ -z $row ]]; then
            continue
        fi
        # row="${row//"*"/""}"
        row=${row#" "}
        row=${row%" "}

        index=0
        separator+="|:"
        row_length=${#row}
        while [ $index -lt "$row_length" ]; do

            if [ "$index" -eq "$(("$row_length" - 1))" ]; then
                separator+="-:"
                ((index++))
                continue
            fi

            separator+="-"
            ((index++))
        done

    done
    separator+="|"

    echo "$separator"

}

create_table() {
    local columns="$1"
    local rows="$2"

    table_columns=$(create_columns "$columns")
    table_rows=$(create_rows "$rows")

    echo -e "$table_columns\n$table_rows"
}

sample_headers="header1:header2:header3"
sample_rows="-column1:column2:column3-columnA:columnB:columnC-columnX:columnY:columnZ"

create_table "${1:-"$sample_headers"}" "${2:-"$sample_rows"}"
