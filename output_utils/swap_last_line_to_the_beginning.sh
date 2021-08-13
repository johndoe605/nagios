#!/bin/bash
command=$1
shift
# TODO understand exactly what is 'awk' doing here. See https://stackoverflow.com/a/52268535/320594.
$command "$@" | awk '{a[NR-1]=$0}END{for(i=0;i<NR;++i)print(a[(i-1+NR)%NR])}'
exit ${PIPESTATUS[0]}
