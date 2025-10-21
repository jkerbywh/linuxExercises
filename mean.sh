#!/bin/bash
# usage: ./mean.sh <column> [file.csv]

if [ $# -lt 1 ]; then
    echo "usage: $0 <column> [file.csv]" 1>&2
    exit 1
fi

col=$1
file=${2:-/dev/stdin}

# --- Compute mean ---
cut -d, -f"$col" "$file" | tail -n +2 | { 
    sum=0
    count=0
    while read val; do
        # skip empty values (if any)
        if [[ -n $val ]]; then
            sum=$(echo "$sum + $val" | bc -l)
            count=$((count + 1))
        fi
    done
    if [ $count -eq 0 ]; then
        echo "No numeric values found in column $col" 1>&2
        exit 1
    fi
    mean=$(echo "$sum / $count" | bc -l)
    echo "$mean"
}
