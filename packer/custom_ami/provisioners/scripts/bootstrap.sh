#!/bin/bash
set -ex

function Linux_Distro {
    sudo yum install -y epel-release
    sudo yum install -y ansible
}

function Ubuntu_Distro {
    sudo apt-get update -y
    sudo apt install -y ansible
}

## __Main__ ##

# Install global system dependencies
if  [[ -x "$(command -v yum)" ]]; then    # centos system
    Linux_Distro
fi

if  [[ -x "$(command -v apt-get)" ]]; then    # ubuntu system
    Ubuntu_Distro
fi