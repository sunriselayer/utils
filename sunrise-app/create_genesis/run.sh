#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
#load env
source $SCRIPT_DIR/../setup_node/env.sh;

echo "Remove genesis.json and gentx"
rm -rf $DAEMON_HOME/config/genesis.json
rm -rf $DAEMON_HOME/config/gentx

echo "Initializing $CHAIN_ID..."
$DAEMON_NAME init "$MONIKER" --home=$DAEMON_HOME --chain-id=$CHAIN_ID 

VAL_MNEMONIC=$(cat $SCRIPT_DIR/../setup_node/mnt.txt)
FAUCET_MNEMONIC=$(cat $SCRIPT_DIR/../setup_node/faucet_mnt.txt)

sed -i '/\[api\]/,+3 s/enable = false/enable = true/' ~/.sunrise/config/app.toml;
sed -i 's/mode = "full"/mode = "validator"/' ~/.sunrise/config/config.toml;
sed -i 's/enabled-unsafe-cors = false/enabled-unsafe-cors = true/' ~/.sunrise/config/app.toml;

sed -i 's/address = "localhost:9090"/address = "0.0.0.0:9090"/' ~/.sunrise/config/app.toml;
sed -i 's#address = "tcp://localhost:1317"#address = "tcp://0.0.0.0:1317"#' ~/.sunrise/config/app.toml;
sed -i 's#laddr = "tcp://127.0.0.1:26657"#laddr = "tcp://0.0.0.0:26657"#' ~/.sunrise/config/config.toml;

echo "Update genesis time"
jq ".genesis_time = \"2025-07-30T12:00:00.000000000Z\"" $DAEMON_HOME/config/genesis.json > temp.json && mv temp.json $DAEMON_HOME/config/genesis.json

echo "Update gov params"
jq ".app_state.gov.params.voting_period = \"300s\""  ~/.sunrise/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;
jq ".app_state.gov.params.expedited_voting_period = \"150s\""  ~/.sunrise/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;
jq ".app_state.gov.params.min_deposit = [{\"denom\": \"uvrise\", \"amount\": \"100000000\"}]"  ~/.sunrise/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;
jq ".app_state.gov.params.expedited_min_deposit = [{\"denom\": \"uvrise\", \"amount\": \"200000000\"}]"  ~/.sunrise/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;

echo "Enable stable allowed addresses for user1"
jq ".app_state.stable.params.allowed_addresses = [\"$($DAEMON_NAME --home $DAEMON_HOME keys show faucet --keyring-backend test -a)\"]" $DAEMON_HOME/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;

echo "Enable tokenconverter allowed addresses"
jq ".app_state.tokenconverter.params.allowed_addresses = [\"$($DAEMON_NAME --home $DAEMON_HOME keys show faucet --keyring-backend test -a)\",\"$($DAEMON_NAME --home $DAEMON_HOME keys show val --keyring-backend test -a)\"]" $DAEMON_HOME/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;

echo "Add 1st validator account & gentx"
$DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME --home $DAEMON_HOME keys show val --keyring-backend test -a) 50000000000000urise,1000000000uusdrise,50000000000000uvrise
$DAEMON_NAME genesis gentx val 50000000000000uvrise --home $DAEMON_HOME --chain-id $CHAIN_ID --keyring-backend test \
--website="https://sunriselayer.io" --security-contact="https://discord.com/invite/sunrise" --identity="50DF45DC4BD5890A" \
--details="Sunrise Core Team's validator node. Delegate your RISE/vRISE and Start Earning Staking Rewards."
$DAEMON_NAME genesis collect-gentxs --home $DAEMON_HOME

echo "Add validator accounts"
jq --slurpfile validatorAccounts "$SCRIPT_DIR/validators/accounts_validator.json" '.app_state.auth.accounts += $validatorAccounts[0].accounts' $DAEMON_HOME/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;
jq --slurpfile validatorBalance "$SCRIPT_DIR/validators/balances_validator.json" '.app_state.bank.balances += $validatorBalance[0].balances' $DAEMON_HOME/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;
jq --slurpfile lockupMsgs "$SCRIPT_DIR/validators/init_lockup_msgs_validator.json" '.app_state.lockup.init_lockup_msgs += $lockupMsgs[0].init_lockup_msgs' $DAEMON_HOME/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;
# 417,111,702,585 genesis balances

echo "Add faucet accounts"
$DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME --home $DAEMON_HOME keys show faucet --keyring-backend test -a) 299582888297415urise,9000000000uusdrise,99999965000000uvrise

echo "Updating total supply..."
jq ".app_state.bank.supply = [{\"denom\": \"urise\", \"amount\": \"350000000000000\"}, {\"denom\": \"uusdrise\", \"amount\": \"10003500000\"}, {\"denom\": \"uvrise\", \"amount\": \"150000000000000\"}]" $DAEMON_HOME/config/genesis.json > temp.json && mv temp.json $DAEMON_HOME/config/genesis.json
