#!/bin/bash

# chain info
CHAIN_REPO=https://github.com/SunriseLayer/sunrise-app
CHAIN_REPO_BRANCHE=main
TARGET=sunrised
TARGET_HOME=.sunrise
# DL_CHAIN_BIN=https://github.com/mkXultra/share_gen/releases/download/v0.0.1/ununifid-v0.0.1-linux-amd64

# chain env info
CHAIN_ID=dawn-1
# SEEDS=
PEERS=b9488ee1f338aae256a3db0ca02e41cc349373db@35.75.8.125:26656
GENESIS_FILE_URL=https://raw.githubusercontent.com/UnUniFi/chain/develop/launch/ununifi-8-private-test/genesis.json

# DO NOT EDIT. script config
SETUP_NODE_CONFIG_ENV=TRUE
SETUP_NODE_ENV=TRUE
SETUP_NODE_MASTER=TRUE


# DO NOT EDIT. this is random moniker
MONIKER="CauchyE"


export CHAIN_REPO=$CHAIN_REPO
export CHAIN_REPO_BRANCHE=$CHAIN_REPO_BRANCHE
export TARGET=$TARGET
export TARGET_HOME=$TARGET_HOME
export CHAIN_ID=$CHAIN_ID
export DL_CHAIN_BIN=$DL_CHAIN_BIN
export MONIKER=$MONIKER
export PEERS=$PEERS
export GENESIS_FILE_URL=$GENESIS_FILE_URL
export SETUP_NODE_CONFIG_ENV=$SETUP_NODE_CONFIG_ENV
export SETUP_NODE_ENV=$SETUP_NODE_ENV
export SETUP_NODE_MASTER=$SETUP_NODE_MASTER

DAEMON_NAME=$TARGET
DAEMON_HOME=$HOME/$TARGET_HOME
export DAEMON_NAME=$DAEMON_NAME
export DAEMON_HOME=$DAEMON_HOME
export PATH="$PATH:/usr/local/go/bin:~/go/bin"