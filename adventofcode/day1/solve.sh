#!/bin/bash
: ${INPUT?}

function adventofcode:d1p1:v1() {
    let -i l=0; cat ${INPUT} | {
        while IFS= read -n1 c; do
            {
                [ "$c" == '(' ] && ((l+=1))
            } || {
                [ "$c" == ')' ] && ((l-=1))
            }
            echo $l
        done
    } | tail -n1
}

function adventofcode:d1p1:v2() {
    echo $(( $(grep -o '(' ${INPUT}|wc -c) - $(grep -o ')' ${INPUT}|wc -c) ))
}

function adventofcode:d1p1:v3() {
    echo $(( $(tr -cd '(' < ${INPUT}|wc -c) - $(tr -cd ')' < ${INPUT}|wc -c) ))
}

function adventofcode:d1p2:v1() {
    let -i i=0
    let -i l=0
    cat ${INPUT} | {
        while IFS= read -n1 c; do
            ((i++))
            {
                [ "$c" == '(' ] && ((l+=1))
            } || {
                [ "$c" == ')' ] && ((l-=1))
            }
            [ $l != -1 ] || break
        done
        echo $i
    }
}
