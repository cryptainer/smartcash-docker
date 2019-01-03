#!/bin/bash

# add differnt aliases for differnet commands
alias getblockcount='smartcash-cli -conf=$WALLET_CONF -datadir=$WALLET_DATA getblockcount'
alias getinfo='smartcash-cli -conf=$WALLET_CONF -datadir=$WALLET_DATA getinfo'
alias nodestatus='smartcash-cli -conf=$WALLET_CONF -datadir=$WALLET_DATA smartnode status'

# Apply smartcash.conf configuration from environment variables
env | grep ^conf_ | sed -r 's/^conf_//g' > ${WALLET_CONF};

# Apply masternode.conf configuration from environment variables
env | grep ^mn_ | sed -r 's/^mn_//g' | sed 's/=/ /g' > ${MASTERNODE_CONF};

# make sure cron deamon is running
service cron start

# Create a cronjob for making sure smartcashd is always running
if ! crontab -l | grep "${WALLET_RUN}/keepalive.sh"; then
  (crontab -l ; echo "*/5 * * * * ${WALLET_RUN}/keepalive.sh") | crontab -
fi

# Create a cronjob for making sure the daemon is never stuck
if ! crontab -l | grep "${WALLET_RUN}/checkdaemon.sh"; then
  (crontab -l ; echo "*/30 * * * * ${WALLET_RUN}/checkdaemon.sh") | crontab -
fi

# Create a cronjob for clearing the log file
if ! crontab -l | grep "${WALLET_RUN}/clearlog.sh"; then
  (crontab -l ; echo "0 0 */2 * * ${WALLET_RUN}/clearlog.sh") | crontab -
fi

# If the container was restarted / the data directory is mounted from the host, there may be an old lock file
rm -f ${WALLET_DATA}/.lock

echo "Starting SmartCash Wallet."

if [ ${DEBUG} ]
then
    echo "smartcash.conf:"
    cat ${WALLET_CONF}
    echo "masternode.conf:"
    cat ${MASTERNODE_CONF}
else
    echo "Set DEBUG=1 to dump configs here."
fi

exec smartcashd -conf=$WALLET_CONF -datadir=$WALLET_DATA
