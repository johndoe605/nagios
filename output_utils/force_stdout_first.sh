#!/bin/bash
tmp_stderr_file=$(mktemp);
command=$1
shift
$command "$@" 2>$tmp_stderr_file
exit_status=$?
cat $tmp_stderr_file;
rm $tmp_stderr_file
exit $exit_status
