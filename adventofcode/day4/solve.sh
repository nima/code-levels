#!/bin/bash
: ${INPUT?}

function adventofcode:d4p1:v1() {
    local secret="bgvyzdsv"

    local -i i=${1:-1}
    local -i n=${2:-1}
    local -i l=${3:-5}

    local m
    local -i j=0
    local -i t=$(date +%s)

    while [ $j -eq 0 ]; do
        m=$(printf "${secret}${i}"|md5sum|cut -f1 -d\ )
        if [ ${m:0:$n} == $(printf %0${n}d 0) ]; then
            printf "n:%d md5:%s i:[%10d] (%ss)\n" $n $m $i "$(($(date +%s) - t))"
            if [ $n -eq $l ]; then
                ((j=i))
                ((++n))
            fi
        fi
        [ $n -eq $l ] && ((++i))
    done
    echo $j
}

function adventofcode:d4p2:v1() {
    local -i i=254575
    local -i n=5
    local -i l=6
    adventofcode:d4p1:v1 $i $n $l
}
