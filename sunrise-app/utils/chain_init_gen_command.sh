#!/bin/bash

# if not passing arguments to this script, execute init command
if [ $# -lt 1 ]; then
  execute_command="init"
else
  execute_command=$1
fi

echo "Executing $execute_command command..."

version=$($DAEMON_NAME version --long | grep cosmos_sdk_version | awk -F: '{print $2}' | tr -d '[:space:]')

# バージョン番号の "v" を削除
version=${version#v}

# バージョン番号を "." で分割
IFS='.' read -ra VERSION_PARTS <<< "$version"

# メジャーバージョンとマイナーバージョンを取得
major_version=${VERSION_PARTS[0]}
minor_version=${VERSION_PARTS[1]}


# check execute_command
if [ "$execute_command" = "init" ]; then
  if (( major_version > 0 || minor_version >= 47 )); then
    echo "This is version 0.47 or later."
    $DAEMON_NAME genesis add-genesis-account my_validator 1000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account faucet 500000000000000urise;
    $DAEMON_NAME genesis gentx my_validator 100000000000uvrise --chain-id $CHAIN_ID --keyring-backend test;
    $DAEMON_NAME genesis collect-gentxs;
  else
    echo "This is before version 0.47."
    $DAEMON_NAME add-genesis-account my_validator 1000000000000uvrise,10000000urise;
    $DAEMON_NAME add-genesis-account faucet 500000000000000urise;
    $DAEMON_NAME gentx my_validator 100000000000uvrise --chain-id $CHAIN_ID --keyring-backend test;
    $DAEMON_NAME collect-gentxs;
  fi
  exit 0;
elif [ "$execute_command" = "reset-node" ]; then
  VAL=my_validator
  FAUCET=faucet
  USER1=user1
  USER2=user2
  USER3=user3
  USER4=user4
  if (( major_version > 0 || minor_version >= 47 )); then
    echo "This is version 0.47 or later."
    $DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME keys show $VAL --keyring-backend test -a) 1000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME keys show $USER1 --keyring-backend test -a) 1000000000000uvrise,1000000000000urise,100000000000000000ibc/uusdc,100000000000000000ibc/uusdt,100000000000000000ibc/uatom,1000000000000000ibc/uweth,100000000000000000000000ibc/ushib,100000000000000000000ibc/uibgt,100000000000000000000ibc/uoas,100000000000000000000000ibc/upepe;
    $DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME keys show $USER2 --keyring-backend test -a) 1000000000000uvrise,1000000000000urise,100000000000000000ibc/uusdc,100000000000000000ibc/uusdt,100000000000000000ibc/uatom,1000000000000000ibc/uweth,100000000000000000000000ibc/ushib,100000000000000000000ibc/uibgt,100000000000000000000ibc/uoas,100000000000000000000000ibc/upepe;
    $DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME keys show $USER3 --keyring-backend test -a) 1000000000000uvrise,1000000000000urise,100000000000000000ibc/uusdc,100000000000000000ibc/uusdt,100000000000000000ibc/uatom,1000000000000000ibc/uweth,100000000000000000000000ibc/ushib,100000000000000000000ibc/uibgt,100000000000000000000ibc/uoas,100000000000000000000000ibc/upepe;
    $DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME keys show $USER4 --keyring-backend test -a) 1000000000000uvrise,1000000000000urise,100000000000000000ibc/uusdc,100000000000000000ibc/uusdt,100000000000000000ibc/uatom,1000000000000000ibc/uweth,100000000000000000000000ibc/ushib,100000000000000000000ibc/uibgt,100000000000000000000ibc/uoas,100000000000000000000000ibc/upepe;
    # faucet
    $DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME keys show $FAUCET --keyring-backend test -a) 100000000000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1fclku92ml8t8lsvyzed498vd40x9l3d3s6kgef 100000000000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1lm4d2fvhejg209wtjtznhj25xvwedza7kfvp9r 100000000000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1pgmjunt6vwras66ect0vxnpdvkwnvhpxx9aha7 100000000000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise184q90d6wvrj5n72h5gmsmz3gkmjgn8hyfgap4g 100000000000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise17yqk0jqpvdxsmm6tw3keth6n4d2ssvjwyut564 100000000000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1jwqg62h3a0dcdca0f6k9lf2skhx0scgxy36u72 100000000000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise18wm7x90y5p9dc96yusxedq69gnah0lcd2kr0z5 100000000000000urise;
    # validators
    $DAEMON_NAME genesis add-genesis-account sunrise1s35m8qtuhvecc47c2vjyml9cljvn3yrufh56sn 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1jll9zuas2qt7evcp7hj9gq8ldmtmdc46svcnqd 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1gtnvs6667awkpd80ltdxaptz3f7hsaat99l8a8 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise133fhqjfd3mmku3vwczsf5lyzuhavfmqly4f79w 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise12tppeqtaxtcddpjzguyfq7apnnljksnnvpszxq 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1007qgz36cp3z4vkm5k8tx0uyf59ey6jrmjv8qp 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1rl93uudq2l2lx54l7m54caycqenfj9reer4mlf 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1yvh0yvum6t2rc9xsv9cdw26xn393q5a0wxreq3 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1etx55kw7tkmnjqz0k0mups4ewxlr324t8c7704 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1jt9w26mpxxjsk63mvd4m2ynj0af09csl3v4hcz 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1lyktdeyh8ltt4ghc2fj8vgnkpt3lj4jf947npn 9000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account sunrise1jmtfcmfsjxzyp7hc8kscv35khvmdca8hgw2n8t 9000000000000uvrise,10000000urise;

    $DAEMON_NAME genesis gentx $VAL 100000000000uvrise --chain-id $CHAIN_ID --keyring-backend test;
    $DAEMON_NAME genesis gentx $USER1 100000000000uvrise --chain-id $CHAIN_ID --keyring-backend test;
    $DAEMON_NAME genesis collect-gentxs;
  else
    echo "This is before version 0.47."
    $DAEMON_NAME add-genesis-account my_validator 1000000000000uvrise,10000000urise;
    $DAEMON_NAME add-genesis-account user1 1000000000000uvrise,10000000urise;
    $DAEMON_NAME add-genesis-account user2 1000000000000uvrise,10000000urise;
    $DAEMON_NAME add-genesis-account user3 1000000000000uvrise,10000000urise;
    $DAEMON_NAME add-genesis-account user4 1000000000000uvrise,10000000urise;
    $DAEMON_NAME add-genesis-account faucet 1000000000000uvrise,10000000urise;
    $DAEMON_NAME gentx my_validator 1000000000uvrise --chain-id $CHAIN_ID --keyring-backend test;
    $DAEMON_NAME collect-gentxs;
  fi
  exit 0;
elif [ "$execute_command" = "exec-docker" ]; then
  VAL=val
  FAUCET=faucet
  USER1=user1
  PRICEFEED=pricefeed
  if (( major_version > 0 || minor_version >= 47 )); then
    echo "This is version 0.47 or later."
    $DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME keys show $VAL --keyring-backend test -a) 1000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME keys show $USER1 --keyring-backend test -a) 1000000000000uvrise,10000000urise;
    $DAEMON_NAME genesis add-genesis-account $($DAEMON_NAME keys show $FAUCET --keyring-backend test -a) 500000000000000urise;
    $DAEMON_NAME genesis gentx $VAL 1000000000uvrise --chain-id $CHAIN_ID --keyring-backend test;
    $DAEMON_NAME genesis collect-gentxs;
  else
    echo "This is before version 0.47."
    $DAEMON_NAME add-genesis-account $VAL 1000000000000uvrise,10000000urise;
    $DAEMON_NAME add-genesis-account $USER1 1000000000000uvrise,10000000urise;
    $DAEMON_NAME add-genesis-account $FAUCET 500000000000000urise;
    $DAEMON_NAME gentx $VAL 1000000000uvrise --chain-id $CHAIN_ID --keyring-backend test;
    $DAEMON_NAME collect-gentxs;
  fi
  exit 0;
fi
