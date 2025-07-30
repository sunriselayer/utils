#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt update
sudo apt install golang -y
mkdir -p $HOME/.hermes/bin
wget https://github.com/informalsystems/hermes/releases/download/v1.13.2/hermes-v1.13.2-x86_64-unknown-linux-gnu.tar.gz
tar -C $HOME/.hermes/bin/ -vxzf hermes-v1.13.2-x86_64-unknown-linux-gnu.tar.gz 
rm hermes-v1.13.2-x86_64-unknown-linux-gnu.tar.gz
echo "export PATH=$PATH:$HOME/.hermes/bin" >> $HOME/.bashrc
source $HOME/.bashrc 
cp config.toml $HOME/.hermes/config.toml

# Create systemd service file
sudo tee /etc/systemd/system/hermes.service > /dev/null <<EOF
[Unit]
Description=Hermes Relayer Service
After=network-online.target

[Service]
User=ubuntu
ExecStart=$HOME/.hermes/bin/hermes --config $HOME/.hermes/config.toml start
Restart=on-failure
RestartSec=3
LimitNOFILE=1400000

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable hermes.service
# sudo systemctl start hermes.service
# sudo journalctl -u hermes -f -o cat