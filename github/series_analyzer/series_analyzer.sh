#!/bin/bash

# Function to validate input as positive integers
validate() {
    local input="$1"
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to validate series length (at least 3 numbers)
validate_series_length() {
    local series=("$@")
    local count=${#series[@]}

    if (( count >= 3 )); then
        return 0
    else
        return 1
    fi
}

# Main function to analyze the series
Series_Analyzer() {
    while true; do
        read -p "Enter your operation (e.g., 2 10 5 , at least 3 numbers!): " input

        IFS=', ' read -r -a series <<< "$input"

        valid=true
        for num in "${series[@]}"; do
            if ! validate "$num"; then
                valid=false
                break
            fi
        done

        if $valid && validate_series_length "${series[@]}"; then
            echo "Choose from the menu:"
            options=("Input a Series (Replace the current series)"
                     "Display the series in the order it was entered"
                     "Display the series in sorted order (from low to high)"
                     "Display the Max value of the series"
                     "Display the Min value of the series"
                     "Display the Average of the series"
                     "Display the Number of elements in the series"
                     "Display the Sum of the series"
                     "Exit")

            select i in "${options[@]}"; do
                case $REPLY in
                    1)
                        break ;;
                    2)
                        echo
                        echo "The series in the order it was entered: $input"
                        echo
                        break ;;
                    3)
                        sorted_numbers=$(echo $input | tr ' ' '\n' | sort -n | tr '\n' ' ')
                        echo
                        echo "The numbers you entered from low to high are: $sorted_numbers"
                        echo
                        break ;;
                    4)
                        max_value=$(echo $input | tr ' ' '\n' | sort -n | tail -1)
                        echo
                        echo "The Max value of the series is: $max_value"
                        echo
                        break ;;
                    5)
                        min_value=$(echo $input | tr ' ' '\n' | sort -n | head -1)
                        echo
                        echo "The Min value of the series is: $min_value"
                        echo
                        break ;;
                    6)
                        sum=$(echo $input | tr ' ' '\n' | awk '{s+=$1} END {print s}')
                        count=$(echo $input | tr ' ' '\n' | wc -l)
                        average=$(echo "scale=2; $sum / $count" | bc)
                        echo
                        echo "The Average of the series is: $average"
                        echo
                        break ;;
                    7)
                        count=$(echo $input | tr ' ' '\n' | wc -l)
                        echo
                        echo "The Number of elements in the series: $count"
                        echo
                        break ;;
                    8)
                        sum=$(echo $input | tr ' ' '\n' | awk '{s+=$1} END {print s}')
                        echo
                        echo "The Sum of the series: $sum"
                        echo
                        break ;;
                    9)
                        echo "Goodbye"
                        return 0 ;;
                    *)
                        echo "Invalid option, please choose again."
                        ;;
                esac
            done
        else
            echo "Invalid numbers, please enter valid numbers"
        fi
    done
}

Series_Analyzer
