#!/bin/bash

# Apply smartcash.conf configuration from environment variables
env | grep ^conf_ | sed -r 's/^conf_//g' > ${WALLET_CONF};

# Apply masternode.conf configuration from environment variables
env | grep ^mn_ | sed -r 's/^mn_//g' | sed 's/=/ /g' > ${MASTERNODE_CONF};

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