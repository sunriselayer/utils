#!/bin/bash

# ATOM/RISE
$DAEMON_NAME tx liquiditypool create-pool --denom-base=ibc/uatom --denom-quote=urise \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test \
--yes --keyring-backend=test --fees="10000urise"
sleep 8

# RISE/USDC
$DAEMON_NAME tx liquiditypool create-pool --denom-base=urise --denom-quote=ibc/uusdc \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test \
--yes --keyring-backend=test --fees="10000urise"
sleep 8

# RISE/USDT
$DAEMON_NAME tx liquiditypool create-pool --denom-base=urise --denom-quote=ibc/uusdt \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test \
--yes --keyring-backend=test --fees="10000urise"
sleep 8

# USDT/USDC
$DAEMON_NAME tx liquiditypool create-pool --denom-base=ibc/uusdt --denom-quote=ibc/uusdc \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test \
--yes --keyring-backend=test --fees="10000urise"
sleep 8

# SHIB.axl/USDC
$DAEMON_NAME tx liquiditypool create-pool --denom-base=ibc/ushib --denom-quote=ibc/uusdc \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test \
--yes --keyring-backend=test --fees="10000urise"

# iBGT/USDC
$DAEMON_NAME tx liquiditypool create-pool --denom-base=ibc/uibgt --denom-quote=ibc/uusdc \
--fee-rate="0.001" --price-ratio="1.000100000000000000" --base-offset="0.500000000000000000" \
--from=my_validator --chain-id=sunrise-test \
--yes --keyring-backend=test --fees="10000urise"
