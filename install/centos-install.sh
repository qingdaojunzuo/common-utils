#!/bin/bash

set -eo pipefail

. .functions

usage() {
  echo "Usage: $0 [-h] [-p proxy] ${I_ALL}|all"
  echo ""
  echo "  -h|--help,   print usage"
  echo "  -p|--proxy,  proxy server"
  echo ""
  exit 0
}

while [[ $# -gt 0 ]]; do
o=$1
case "$o" in
  -h|--help)  usage ;;
  -p|--proxy) G_PROXY="$2"; shift ;;
  *) G_RUNS="$o,$G_RUNS" ;;
esac
shift
done

G_RUNS=${G_RUNS::-1}
[ -z "$G_RUNS" ] && usage
[ "$G_RUNS" = "all" ] && G_RUNS="$I_ALL"

i_common() {
  sudo yum install -y epel-release yum-utils
  sudo yum groupinstall -y 'Development Tools'
  sudo yum install -y sudo nodejs vsftpd git \
    clang cmake ctags cscope ssh screen \
    htop iotop wget zlib-devel ncurses-devel \
    openssl-devel
}

i_pre
i_common
IFS=',' read -ra runs <<< "$G_RUNS"
for i in ${runs[@]}; do
  _run=I_${i^^}
  if [[ -z "${!_run}" ]]; then
    echo "[$i] can't find, please choose following ones to install, [$I_ALL]"
    exit 1
  fi
done
i_export_envs ${runs[@]}
i_runs ${runs[@]}
i_post
