#!/bin/bash
: ${INPUT?}

function adventofcode:d2p1:v1() {
    local -i A=0
    local -i l w h
    local -i a b c
    while read dim; do
        IFS=x read l w h <<< "${dim}"
        ((a=l*w))
        ((b=w*h))
        ((c=h*l))
        ((A += 2*(a+b+c) + $(min $a $b $c)))
    done < ${INPUT}
    echo $A
}

function adventofcode:d2p2:v1() {
    local -i L=0
    local -i l w h
    local -i a b c
    while read dim; do
        IFS=x read l w h <<< "${dim}"
        ((a=l+w))
        ((b=w+h))
        ((c=h+l))
        case $(min $a $b $c) in
            $a) ((L+=2*a));;
            $b) ((L+=2*b));;
            $c) ((L+=2*c));;
        esac
        ((L+=l*w*h))
    done < ${INPUT}
    echo $L
}
