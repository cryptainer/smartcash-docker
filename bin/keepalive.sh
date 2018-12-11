#!/bin/bash
# Make sure smartcashd is always running.
# Add the following to the crontab (i.e. crontab -e)
# */5 * * * * $WALLET_RUN/makerun.sh

if ps -A | grep smartcashd > /dev/null
then
  exit
else
  smartcashd -conf=$WALLET_CONF -datadir=$WALLET_DATA &
fi
