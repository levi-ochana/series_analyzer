#!/bin/bash

# Function to get series input from the user
get_series_input() {
    read -p "Enter your series (e.g., 2 10 5 , at least 3 numbers!): " input
    echo "$input"
}

# Function to validate input as positive integers
validate() {
    local input="$1"
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to validate the entire series
validate_series() {
    local series=("$@")
    for num in "${series[@]}"; do
        if ! validate "$num"; then
            echo "Invalid number detected: $num. Please enter only positive integers."
            return 1
        fi
    done
    return 0
}

# Function to validate series length (at least 3 numbers)
validate_series_length() {
    local series=("$@")
    if (( ${#series[@]} >= 3 )); then
        return 0
    else
        echo "Series must contain at least 3 numbers."
        return 1
    fi
}

# Function to display the menu options
display_menu() {
    echo
    echo "Choose from the menu:"
    echo "1. Input a Series (Replace the current series)"
    echo "2. Display the series in the order it was entered"
    echo "3. Display the series in sorted order (from low to high)"
    echo "4. Display the Max value of the series"
    echo "5. Display the Min value of the series"
    echo "6. Display the Average of the series"
    echo "7. Display the Number of elements in the series"
    echo "8. Display the Sum of the series"
    echo "9. Exit"
}

# Function to handle user's menu choice
handle_menu_choice() {
    local choice="$1"
    local -n series_ref="$2" # Use nameref for series

    case $choice in
        1)
            local input
            input=$(get_series_input)
            IFS=', ' read -r -a new_series <<< "$input"
            if validate_and_process_series "${new_series[@]}"; then
                series_ref=("${new_series[@]}")
            fi
            ;;
        2)
            display_series "${series_ref[@]}"
            ;;
        3)
            display_sorted_series "${series_ref[@]}"
            ;;
        4)
            display_max_value "${series_ref[@]}"
            ;;
        5)
            display_min_value "${series_ref[@]}"
            ;;
        6)
            display_average "${series_ref[@]}"
            ;;
        7)
            display_count "${series_ref[@]}"
            ;;
        8)
            display_sum "${series_ref[@]}"
            ;;
        9)
            echo "Goodbye"
            exit 0
            ;;
        *)
            echo "Invalid option, please choose again."
            ;;
    esac
}

# Function to validate and process the series
validate_and_process_series() {
    local series=("$@")
    if validate_series "${series[@]}" && validate_series_length "${series[@]}"; then
        return 0
    else
        return 1
    fi
}

# Function to display the series in the order it was entered
display_series() {
    local series=("$@")
    echo
    echo "The series in the order it was entered: ${series[@]}"
    echo
}

# Function to display the series in sorted order (from low to high)
display_sorted_series() {
    local series=("$@")
    local sorted_numbers
    sorted_numbers=$(echo "${series[@]}" | tr ' ' '\n' | sort -n | tr '\n' ' ')
    echo
    echo "The numbers you entered from low to high are: $sorted_numbers"
    echo
}

# Function to display the max value of the series
display_max_value() {
    local series=("$@")
    local max_value
    max_value=$(echo "${series[@]}" | tr ' ' '\n' | sort -n | tail -1)
    echo
    echo "The Max value of the series is: $max_value"
    echo
}

# Function to display the min value of the series
display_min_value() {
    local series=("$@")
    local min_value
    min_value=$(echo "${series[@]}" | tr ' ' '\n' | sort -n | head -1)
    echo
    echo "The Min value of the series is: $min_value"
    echo
}

# Function to display the average of the series
display_average() {
    local series=("$@")
    local sum
    sum=$(calculate_sum "${series[@]}")
    local count
    count=$(calculate_count "${series[@]}")
    local average
    average=$(echo "scale=2; $sum / $count" | bc)
    echo
    echo "The Average of the series is: $average"
    echo
}

# Function to calculate and return the sum of the series
calculate_sum() {
    local series=("$@")
    echo "${series[@]}" | tr ' ' '\n' | awk '{s+=$1} END {print s}'
}

# Function to calculate and return the number of elements in the series
calculate_count() {
    local series=("$@")
    echo "${series[@]}" | tr ' ' '\n' | wc -l
}

# Function to display the number of elements in the series
display_count() {
    local count
    count=$(calculate_count "$@")
    echo
    echo "The Number of elements in the series: $count"
    echo
}

# Function to display the sum of the series
display_sum() {
    local sum
    sum=$(calculate_sum "$@")
    echo
    echo "The Sum of the series: $sum"
    echo
}

# Main function to analyze the series
Series_Analyzer() {
    # Check if arguments were passed through the command line
    local series=()
    if [[ $# -gt 0 ]]; then
        series=("$@")
        validate_and_process_series "${series[@]}" || return 1
    else
        local input
        input=$(get_series_input)
        IFS=', ' read -r -a series <<< "$input"
        validate_and_process_series "${series[@]}" || return 1
    fi

    while true; do
        display_menu
        read -p "Enter your choice: " choice
        handle_menu_choice "$choice" series
    done
}

Series_Analyzer "$@"
