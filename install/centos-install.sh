#!/bin/bash

. .functions

I_DOCKER_REPO="https://download.docker.com/linux/centos/docker-ce.repo"
I_DOCKER='run=i_docker'
I_DOCKER_VER="18.03.0"

I_DOCKER_ETC=/etc/docker
I_DOCKER_DAEMON=../docker/daemon.json

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
    openssl-devel python-devel python3*-devel
}

i_docker() {
  which docker
  if [ $? -ne 0 ]; then
    sudo yum install -y device-mapper-persistent-data lvm2
    wget $I_DOCKER_REPO
    sudo mv docker-ce.repo /etc/yum.repos.d/
    sudo yum install -y docker-ce-${I_DOCKER_VER}.ce
    sudo mkdir -p "$I_DOCKER_ETC"
    if [[ ! -e "${I_DOCKER_ETC}/daemon.json" ]]; then
      sudo cp "$I_DOCKER_DAEMON" "${I_DOCKER_ETC}/daemon.json"
    fi
    sudo systemctl start docker
  else
    echo "find installed docker, skip it ..." >&2
  fi
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
