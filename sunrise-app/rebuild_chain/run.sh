#!/bin/bash
set -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/../setup_node/env.sh
sudo systemctl stop cosmovisor
cd ~/sunrise-app
git pull
make install
# check file is exist rm file
if [ -f ~/.sunrise/cosmovisor/genesis/bin/sunrised ]; then
  rm ~/.sunrise/cosmovisor/genesis/bin/sunrised
fi
cp ~/go/bin/sunrised $DAEMON_HOME/cosmovisor/genesis/bin
# SCRIPT_DIR=$(cd $(dirname $0); pwd)
# $SCRIPT_DIR/../reset_debug_node/run.sh

sudo systemctl start cosmovisor
