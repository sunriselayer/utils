#!/bin/bash
set -xe

cd ~
sudo apt update -y
sudo apt install -y jq git build-essential

## go install
wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
# vim ~/.bashrc
# export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
# source ~/.bashrc


git clone https://github.com/SunriseLayer/sunrise-node.git
cd sunrise-node
git checkout v0.13.1-sunrise
make build
sudo make install

# init with validator node (sunrise-app)
sunrise bridge init --core.ip sunrise-private-2.cauchye.net --p2p.network private
# Register the service
sudo tee <<EOF >/dev/null /etc/systemd/system/sunrise-bridge.service
[Unit]                                                               
Description=sunrise-bridge Cosmos daemon
After=network-online.target

[Service]
User=$USER
ExecStart=$(which sunrise) bridge start --core.ip sunrise-private-2.cauchye.net --p2p.network private
Restart=on-failure
RestartSec=3
LimitNOFILE=1400000

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable sunrise-bridge
sudo systemctl start sunrise-bridge && sudo journalctl -u sunrise-bridge.service -f