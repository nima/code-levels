#!/bin/bash
: ${INPUT?}

function adventofcode:d3p1:v1() {
    local -i x=0
    local -i y=0

    local -A grid
    grid[${x},${y}]=1
    cat ${INPUT} | {
        while IFS= read -n1 c; do
            case $c in
                \^) ((y++));;
                \>) ((x++));;
                \v) ((y--));;
                \<) ((x--));;
            esac
            (( grid["${x},${y}"]++ ))
        done
        echo ${#grid[@]}
    }
}

function adventofcode:d3p2:v1() {
    local -i x1=0
    local -i y1=0
    local -i x2=0
    local -i y2=0

    local -i i=0

    local -A grid
    grid[0,0]=2
    cat ${INPUT} | {
        while IFS= read -n1 c; do
            case $c in
                \^) if [ $i -eq 0 ]; then ((y1++)); else ((y2++)); fi;;
                \>) if [ $i -eq 0 ]; then ((x1++)); else ((x2++)); fi;;
                \v) if [ $i -eq 0 ]; then ((y1--)); else ((y2--)); fi;;
                \<) if [ $i -eq 0 ]; then ((x1--)); else ((x2--)); fi;;
            esac
            [ $i -eq 0 ] && (( grid["${x1},${y1}"]++ )) || (( grid["${x2},${y2}"]++ ))
            ((i=((i+1) % 2)))
        done
        echo ${#grid[@]}
    }
}
