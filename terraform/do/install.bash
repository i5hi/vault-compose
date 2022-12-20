#!/bin/bash

VERSION=1.84.0
wget https://github.com/digitalocean/doctl/releases/download/v${VERSION}/doctl-${VERSION}-linux-amd64.tar.gz
tar -xvf doctl-${VERSION}-linux-amd64.tar.gz && rm -rf doctl-${VERSION}-linux-amd64.tar.gz
sudo mv doctl /usr/local/bin
doctl -v