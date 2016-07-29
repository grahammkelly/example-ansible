#!/usr/bin/env bash

if [ $# -lt 1 ]
then
    echo "Usage ./ansible.sh dev|qa|prod [extra-ansible-options]"
    exit 1
fi

script_dir=$(dirname $0)

ENV=$1
shift 1

if [ ! -f ${script_dir}/inventories/${ENV} ]; then
    echo "Environment ${ENV} is not configured"
    exit 1
fi

ANSIBLE_CONFIG="${script_dir}/ansible.cfg"
if [ -f "${script_dir}/ansible-${ENV}.cfg" ]
then
  ANSIBLE_CONFIG="${script_dir}/ansible-${ENV}.cfg"
fi

echo "ANSIBLE_CONFIG=${ANSIBLE_CONFIG}"
export EXEC="ansible-playbook -i ${script_dir}/inventories/${ENV} $@"
echo -e "Running: ${EXEC}\n"
${EXEC}
