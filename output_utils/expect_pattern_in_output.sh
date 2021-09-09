#!/bin/bash
# TODO check if this parameter is supporting regex.
pattern=$1
command=$2
# TODO check if there is any way to make the following double 'shift' more brief.
shift
shift
output=$($command "$@" 2>&1)
echo "$output" | grep -q "$pattern"
if [[ $? == 0 ]]; then
    echo "OK: '$pattern' was found in '$output'";
else
    echo "CRITICAL: '$pattern' was not found in '$output'";
    exit 2;
fi
