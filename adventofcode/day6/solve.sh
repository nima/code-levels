#!/bin/bash
: ${INPUT?}

function range() {
    if [ $1 -le $2 ]; then
        seq $1 $2
    else
        seq $2 $1
    fi
}

function adventofcode:d6p1:v1() {
    local -i e=0

    local -A lights1
    function light1() {
        local action=$1
        IFS=, read -a coord1 <<< "${2}"
        IFS=, read -a coord2 <<< "${3}"
        for x in $(seq ${coord1[0]} ${coord2[0]}); do
            for y in $(seq ${coord1[1]} ${coord2[1]}); do
                case ${action}:${lights1[$x,$y]:-0} in
                    on:0|toggle:0) lights1[$x,$y]=1 ;;
                    off:1|toggle:1) unset lights1[$x,$y] ;;
                    on:1|off:0) : noop ;;
                esac
            done
        done
    }

    while read -a instruction; do
        printf "%s..." "${instruction[*]}"
        light1 ${instruction[0]} ${instruction[1]} ${instruction[3]}
        echo "DONE [Lights:${#lights1[@]}]"
    done < <(sed 's/turn//' ${INPUT}) | cat -n

    return $e
}

function adventofcode:d6p2:v1() {
    local -i e=0

    local -A lights2
    function light2() {
        local action=$1
        IFS=, read -a coord1 <<< "${2}"
        IFS=, read -a coord2 <<< "${3}"
        for x in $(seq ${coord1[0]} ${coord2[0]}); do
            for y in $(seq ${coord1[1]} ${coord2[1]}); do
                case ${action} in
                    on) ((lights2[$x,$y]+=1)) ;;
                    off) ((lights2[$x,$y]-=1)) ;;
                    toggle) ((lights2[$x,$y]+=2)) ;;
                esac
                if [ ${lights2[$x,$y]:-0} -le 0 ]; then
                    unset lights2[$x,$y]
                fi
            done
        done
    }

    while read -a instruction; do
        printf "%s..." "${instruction[*]}"
        light2 ${instruction[0]} ${instruction[1]} ${instruction[3]}
        local -i s=0
        for i in ${lights2[@]}; do
            ((s+=i))
        done
        echo "DONE [Lights:${s}]"
    done < <(sed 's/turn//' ${INPUT}) | cat -n

    return $e
}
