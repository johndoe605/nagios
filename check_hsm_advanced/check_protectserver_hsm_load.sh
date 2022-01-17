#!/bin/bash
#####
# This allows to check the "Current percentage of HSM CPU capacity in use" (see too https://thalesdocs.com/gphsm/ptk/5.9/docs/Content/PTK-C_Admin/snmp.htm).
#####
# TODO review it, any error in this script should produce an error and exit.

HSMSTATE="/opt/safenet/protecttoolkit5/ptk/bin/hsmstate"

hsm_hostname=${1}
measure_time=${2}
warning=${3}
critical=${4}

export ET_HSM_NETCLIENT_SERVERLIST=${hsm_hostname}
# TODO instead of this, try to get load averages in a similar way to check_protectserver_appliance_load.sh. Maybe SNMP is an option for this.
declare -i sum=0
for (( i=0; i<$measure_time; ++i))
do
    cur_usage=$(${HSMSTATE} | sed -E 's/.*Usage Level=([0-9]*)%/\1/')
    sum=$((sum+cur_usage))
    sleep 1
done
# TODO check: the following math logic is not supporting float numbers.
average_usage=$((sum/measure_time))
output="load average: ${average_usage}%"
if [[ ${average_usage} -gt ${critical} ]]; then
    res=2 # CRITICAL
elif  [[ ${average_usage} -gt ${warning} ]]; then
    res=1 # WARNING
else
    res=0 # OK
fi
echo ${output}
exit ${res}
