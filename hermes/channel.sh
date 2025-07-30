#!/bin/bash
SRC_CHAIN=dawn-1
DST_CHAIN=provider

hermes create client --host-chain $SRC_CHAIN --reference-chain $DST_CHAIN
hermes create connection --a-chain $SRC_CHAIN --b-chain $DST_CHAIN
hermes create channel --a-chain $SRC_CHAIN --a-connection connection-0 --a-port transfer --b-port transfer