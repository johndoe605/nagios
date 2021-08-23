#!/usr/bin/env bash

# TODO make these overridable from arguments. See hsm.sh.
CTC="/opt/safenet/protecttoolkit5/ptk/bin/ctcheck"
CTA="/opt/misc/hablutzel1_nagios_plugins/check_hsm_advanced/ctalarm_customized"

hsm_hostname=${1}
export ET_HSM_NETCLIENT_SERVERLIST=${hsm_hostname}

output=$($CTC -a | $CTA)
ctalaram_res=$?
if [[ ${ctalaram_res} == 0 ]]; then # OK coming from ctalarm
    res=0 # OK
elif [[ ${ctalaram_res} == 1 || ${ctalaram_res} == 2  ]]; then # NOTICE and WARNING coming from ctalarm
    res=1 # WARNING
else # ALARM (and anything else) coming from ctalarm
    res=2 # CRITICAL
fi
echo ${output}
exit ${res}
