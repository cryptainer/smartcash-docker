#!/bin/bash
# checkdaemon.sh
# Make sure the daemon is not stuck.
# Add the following to the crontab (i.e. crontab -e)
# */30 * * * * $WALLET_RUN/checkdaemon.sh

previousBlock=$(cat $WALLET_DATA/blockcount)
currentBlock=$(getblockcount)

getblockcount > $WALLET_DATA/blockcount

if [ "$previousBlock" == "$currentBlock" ]; then
  smartcash-cli -conf=$WALLET_CONF -datadir=$WALLET_DATA stop
  sleep 10
  smartcashd -conf=$WALLET_CONF -datadir=$WALLET_DATA
fi
