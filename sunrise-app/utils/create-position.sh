#!/bin/bash

# ATOM/RISE
sunrised tx liquiditypool create-position --pool-id=1 \
--lower-tick="-8210" --upper-tick="-100" \
--token-base=500000000000ibc/uatom --token-quote=330000000000urise \
--min-amount-base="0" --min-amount-quote="0" \
--from=user1 --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# RISE/USDC
sunrised tx liquiditypool create-position --pool-id=2 \
--lower-tick=18972 --upper-tick=27081 \
--token-base=800000000000urise --token-quote=8000000000000ibc/uusdc \
--min-amount-base="0" --min-amount-quote="0" \
--from=user2 --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# RISE/USDT
sunrised tx liquiditypool create-position --pool-id=3 \
--lower-tick=18972 --upper-tick=27081 \
--token-base=100000000000urise --token-quote=1000000000000ibc/uusdt \
--min-amount-base="0" --min-amount-quote="0" \
--from=user2 --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# USDT/USDC
sunrised tx liquiditypool create-position --pool-id=4 \
--lower-tick="-4155" --upper-tick=4054 \
--token-base=50000000000000ibc/uusdt --token-quote=50000000000000ibc/uusdc \
--min-amount-base="0" --min-amount-quote="0" \
--from=user2 --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# SHIB.axl/USDC
sunrised tx liquiditypool create-position --pool-id=5 \
--lower-tick="-114489" --upper-tick="-106379" \
--token-base=100000000000000000ibc/ushib --token-quote=1600000000000ibc/uusdc \
--min-amount-base="0" --min-amount-quote="0" \
--from=user2 --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# iBGT/USDC
sunrised tx liquiditypool create-position --pool-id=6 \
--lower-tick=20795 --upper-tick=25258 \
--token-base=200000000000ibc/uibgt --token-quote=2000000000000ibc/uusdc \
--min-amount-base="0" --min-amount-quote="0" \
--from=user2 --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# stATOM/ATOM
sunrised tx liquiditypool create-position --pool-id=7 \
--lower-tick="-4155" --upper-tick=4054 \
--token-base=5000000000000ibc/stuatom --token-quote=5000000000000ibc/uatom \
--min-amount-base="0" --min-amount-quote="0" \
--from=user2 --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20