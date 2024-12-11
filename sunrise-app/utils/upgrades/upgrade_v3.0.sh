#!/bin/bash

sunrised tx upgrade software-upgrade v0_3_0_test \
--title "On-chain upgrade v0.3.0-test" \
--metadata "The public testnet upgrade to v0.3.0-test" \
--summary "The public testnet upgrade to v0.3.0-test. Fix memory leak problem in mempool. See https://github.com/sunriselayer/sunrise/releases/tag/v0.2.2 for more details." \
--upgrade-info "{\"binaries\":{\"linux/amd64\":\"https://github.com/Senna46/share-sunrised/releases/download/v0.3.0-rc2/sunrised?checksum=md5:a3a2ccde8ffdf3d102feeffcdb6c8e72\"}}" \
--deposit 2000000000urise,1000000000uvrise \
--upgrade-height 25 \
--from user1 \
--keyring-backend test \
--yes \
--gas "auto" \
--fees="10000urise" \
--chain-id=sunrise-private-3

sleep 12

sunrised tx gov vote 1 yes --from my_validator --chain-id sunrise-private-3 --keyring-backend test --yes --fees="10000urise"
sunrised tx gov vote 1 yes --from user1 --chain-id sunrise-private-3 --keyring-backend test --yes --fees="10000urise"
sunrised tx gov vote 1 yes --from user2 --chain-id sunrise-private-3 --keyring-backend test --yes --fees="10000urise"
sunrised tx gov vote 1 yes --from user3 --chain-id sunrise-private-3 --keyring-backend test --yes --fees="10000urise"
sunrised tx gov vote 1 yes --from user4 --chain-id sunrise-private-3 --keyring-backend test --yes --fees="10000urise"