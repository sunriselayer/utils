#!/bin/bash

# for debug
# set -xe

sudo systemctl stop cosmovisor
SCRIPT_DIR=$(cd $(dirname $0); pwd)
#load env
source $SCRIPT_DIR/../setup_node/env.sh;
# update util repo
cd $SCRIPT_DIR
git pull
# killall node
# clenup
rm -rf ~/.sunrise/config/;
rm -rf ~/.sunrise/data/;
rm -rf ~/.sunrise/keyring-test/;
export VAL=my_validator;
export FAUCET=faucet;
export USER1=user1;
export USER2=user2;
export USER3=user3;
export USER4=user4;
export USER_MNEMONIC_1="supply release type ostrich rib inflict increase bench wealth course enter pond spare neutral exact retire thing update inquiry atom health number lava taste";
export USER_MNEMONIC_2="canyon second appear story film people resist slam waste again race rifle among room hip icon marriage sea quality prepare only liquid column click";
export USER_MNEMONIC_3="among follow tooth egg unhappy city road expire solution visit visa skate allow network tissue slogan rose toddler develop utility negative peasant ostrich toward";
export USER_MNEMONIC_4="charge split umbrella day gauge two orphan random human clerk buzz funny cabin purse fluid lecture blouse keen twist loud animal supply hat scare";
export PRICEFEED_MNEMONIC="jelly fortune hire delay impose daughter praise amazing patch gesture easy achieve intact genre swamp gossip aisle arrest item seek inherit cradle hover involve";
export USER_ADDRESS_1=sunrise155u042u8wk3al32h3vzxu989jj76k4zcc6d03n
export USER_ADDRESS_2=sunrise1v0h8j7x7kfys29kj4uwdudcc9y0nx6tw2f955q
export USER_ADDRESS_3=sunrise1y3t7sp0nfe2nfda7r9gf628g6ym6e7d43k5288
export USER_ADDRESS_4=sunrise1pp2ruuhs0k7ayaxjupwj4k5qmgh0d72w8zu30p

$DAEMON_NAME init --chain-id $CHAIN_ID "$MONIKER";
# $DAEMON_NAME keys add my_validator --recover < $SCRIPT_DIR/../setup_node/mnt.txt;
# $DAEMON_NAME keys add faucet --recover < $SCRIPT_DIR/../setup_node/faucet_mnt.txt;
VAL_MNEMONIC=$(cat $SCRIPT_DIR/../setup_node/mnt.txt)
FAUCET_MNEMONIC=$(cat $SCRIPT_DIR/../setup_node/faucet_mnt.txt)

echo $VAL_MNEMONIC    | $DAEMON_NAME keys add $VAL    --recover --keyring-backend=test
echo $FAUCET_MNEMONIC | $DAEMON_NAME keys add $FAUCET --recover --keyring-backend=test
echo $USER_MNEMONIC_1    | $DAEMON_NAME keys add $USER1  --recover --keyring-backend=test
echo $USER_MNEMONIC_2    | $DAEMON_NAME keys add $USER2  --recover --keyring-backend=test
echo $USER_MNEMONIC_3    | $DAEMON_NAME keys add $USER3  --recover --keyring-backend=test
echo $USER_MNEMONIC_4    | $DAEMON_NAME keys add $USER4  --recover --keyring-backend=test

sed -i '/\[api\]/,+3 s/enable = false/enable = true/' ~/.sunrise/config/app.toml;
sed -i -e 's/\bstake\b/urise/g' ~/.sunrise/config/genesis.json
sed -i 's/minimum-gas-prices = ""/minimum-gas-prices = "0urise"/' ~/.sunrise/config/app.toml;
sed -i 's/mode = "full"/mode = "validator"/' ~/.sunrise/config/config.toml;
sed -i 's/enabled-unsafe-cors = false/enabled-unsafe-cors = true/' ~/.sunrise/config/app.toml;

sed -i 's/address = "localhost:9090"/address = "0.0.0.0:9090"/' ~/.sunrise/config/app.toml;
sed -i 's#address = "tcp://localhost:1317"#address = "tcp://0.0.0.0:1317"#' ~/.sunrise/config/app.toml;
sed -i 's#laddr = "tcp://127.0.0.1:26657"#laddr = "tcp://0.0.0.0:26657"#' ~/.sunrise/config/config.toml;

jq ".app_state.gov.params.voting_period = \"120s\""  ~/.sunrise/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;
jq ".app_state.gov.params.expedited_voting_period = \"3600s\""  ~/.sunrise/config/genesis.json > temp.json ; mv temp.json ~/.sunrise/config/genesis.json;


$SCRIPT_DIR/../utils/chain_init_gen_command.sh reset-node;

sudo systemctl restart cosmovisor
