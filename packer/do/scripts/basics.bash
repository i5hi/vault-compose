#!/bin/bash

# A few essential tools to get a fresh debian system 
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    gnupg-agent \
    make zlib1g-dev \
    libz-dev \
    default-libmysqlclient-dev libmariadb-dev-compat libsqlite3-dev \
    libz-dev libssl-dev libpcre2-dev libevent-dev \
    build-essential \
    software-properties-common \
    dirmngr \
    unzip \
    git \
    expect \
    jq  \
    python-pexpect \
    htop \
    auditd \
    dnsutils \
    ccze


exit 0

