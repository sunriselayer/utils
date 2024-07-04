#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
nohup $SCRIPT_DIR/peer-monitor.sh > $SCRIPT_DIR/monitor.log 2>&1 &