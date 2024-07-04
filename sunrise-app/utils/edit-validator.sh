#!/bin/bash

sunrised tx staking edit-validator --new-moniker="cauchye-a" \
--website="https://sunriselayer.io" --chain-id=sunrise-test \
--fees=21000urise --gas=220000 --from=my_validator --keyring-backend=test