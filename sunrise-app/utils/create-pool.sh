#!/bin/bash

# ATOM/RISE
sunrised tx liquiditypool create-pool --denom-base=ibc/uatom --denom-quote=urise \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# RISE/USDC
sunrised tx liquiditypool create-pool --denom-base=urise --denom-quote=ibc/uusdc \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# RISE/USDT
sunrised tx liquiditypool create-pool --denom-base=urise --denom-quote=ibc/uusdt \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# USDT/USDC
sunrised tx liquiditypool create-pool --denom-base=ibc/uusdt --denom-quote=ibc/uusdc \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# SHIB.axl/USDC
sunrised tx liquiditypool create-pool --denom-base=ibc/ushib --denom-quote=ibc/uusdc \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 30

# iBGT/USDC
sunrised tx liquiditypool create-pool --denom-base=ibc/uibgt --denom-quote=ibc/uusdc \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# stATOM/ATOM
sunrised tx liquiditypool create-pool --denom-base=ibc/stuatom --denom-quote=ibc/uatom \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test-0.1 \
--yes --keyring-backend=test --fees="10000urise"
sleep 20

# Gauge Vote
sunrised tx liquidityincentive vote-gauge --weights='{"pool_id":1,"weight":"100000000000000000"}' --weights='{"pool_id":2,"weight":"100000000000000000"}' \
--weights='{"pool_id":3,"weight":"100000000000000000"}' --weights='{"pool_id":4,"weight":"100000000000000000"}' \
--weights='{"pool_id":5,"weight":"100000000000000000"}' --weights='{"pool_id":6,"weight":"100000000000000000"}' \
--weights='{"pool_id":7,"weight":"100000000000000000"}'  --from=my_validator \
--chain-id=sunrise-test-0.1 --yes --keyring-backend=test --fees="10000urise"