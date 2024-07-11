#!/bin/bash

dec2glag() {
    local input_number=$1
    local use_titlo=$2
    local result=""
    
    declare -A glagolitic_symbols
    glagolitic_symbols[1000]="ⱍⱎⱏⱑⱓ"
    glagolitic_symbols[100]="ⱃⱄⱅⱆⱇⱈⱉⱋⱌ"
    glagolitic_symbols[10]="ⰺⰻⰼⰽⰾⰿⱀⱁⱂ"
    glagolitic_symbols[1]="ⰰⰱⰲⰳⰴⰵⰶⰷⰸ"
    
    for divisor in 1000 100 10 1; do
        local symbols=${glagolitic_symbols[$divisor]}
        local quotient=$((input_number / divisor))
        local remainder=$((input_number % divisor))
        
        if [[ $quotient -gt 0 ]]; then
            if [[ $divisor -eq 10 && $quotient -ge 1 && $quotient -le 9 ]]; then
                local tens=${symbols:$((quotient-1)):1}
                local ones=""
                if [[ $remainder -gt 0 ]]; then
                    ones=${glagolitic_symbols[1]:$((remainder-1)):1}
                fi
                if [[ $((quotient * 10 + remainder)) -ge 11 && $((quotient * 10 + remainder)) -le 19 ]]; then
                    result+="${ones}${tens}"
                else
                    result+="${tens}${ones}"
                fi
                break
            else
                result+=${symbols:$((quotient-1)):1}
            fi
        fi
        
        input_number=$remainder
    done
    
    if [[ $use_titlo == true ]]; then
        local titlo="҃"
        if [[ ${#result} -eq 1 ]]; then
            result="${result}${titlo}"
        else
            result="${result:0:$((${#result}-1))}${titlo}${result:$((${#result}-1))}"
        fi
    fi
    
    echo "$result"
}

use_titlo=false
number=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--titlo)
            use_titlo=true
            shift
            ;;
        *)
            if [[ -z $number ]]; then
                number=$1
            else
                echo "Error: Too many arguments"
                echo "Usage: $0 [-t|--titlo] <number>"
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z $number ]]; then
    echo "Error: Number is required"
    echo "Usage: $0 [-t|--titlo] <number>"
    exit 1
fi

result=$(dec2glag "$number" "$use_titlo")
echo "$result"
