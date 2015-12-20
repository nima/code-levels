#!/bin/bash
: ${INPUT?}

function grep_fail() {
    GREP_COLORS="mt=01;31" grep --color -E "$@"
}

function grep_pass() {
    GREP_COLORS="mt=01;32" grep --color -E "$@"
}

function adventofcode:d5p1:v1() {
    local -i words=0
    local -i naughty=0
    local -i nice=0
    cat ${INPUT} | {
        for word in $(<${INPUT}); do
            ((words++))
            if ! grep -qE 'ab|cd|pq|xy' <<< "${word}"; then
                if [ $(grep -oE '[aeiou]' <<< "${word}" | wc -l) -ge 3 ]; then
                    if grep -qE '(.)\1+' <<< "${word}"; then
                        ((nice++))
                    else
                        ((naughty++))
                    fi
                else
                    ((naughty++))
                fi
            else
                ((naughty++))
            fi
        done
        echo "words:${words} naughty:${naughty} nice:${nice}"
    }
}

function adventofcode:d5p2:v1() {
    local -i words=0
    local -i naughty=0
    local -i nice=0
    cat ${INPUT} | {
        for word in $(<${INPUT}); do
            ((words++))
            if grep -qE --color '(.).\1' <<< "${word}"; then
                if grep -qE --color '(..).*\1' <<< "${word}"; then
                    ((nice++))
                else
                    ((naughty++))
                fi
            else
                ((naughty++))
            fi
        done
        echo "words:${words} naughty:${naughty} nice:${nice}"
    }
}

