#!/bin/bash

# Install dependencies
sudo apt-get update
sudo apt-get install -y jq git build-essential

# Install Go
wget https://go.dev/dl/go1.24.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz
rm go1.24.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bashrc
source $HOME/.bashrc

# Install sunrise
git clone https://github.com/sunriselayer/sunrise.git
cd sunrise  
git checkout v1.0.0

# Build sunrise
make install
