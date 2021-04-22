#!/bin/bash
if [ "$1" == "start" ]; then
    echo "***********************************"
    echo "       Generating artifacts        "
    echo "***********************************"
    ./hadith-network/scripts/generate.sh
    echo "***********************************"
    echo "       Starting network            "
    echo "***********************************"
    ./hadith-network/scripts/start.sh
    echo "***********************************"
    echo "       Installing chaincodes       "
    echo "***********************************"
    ./hadith-network/scripts/install-cc.sh
    echo "***********************************"
    echo "       Registering users           "
    echo "***********************************"
    ./hadith-network/scripts/register-users.sh
elif [ "$1" == "stop" ]; then
    ./hadith-network/scripts/stop.sh
elif [ "$1" == "install" ]; then
    cd ./chaincode
    npm install
    cd ..
    npm install
fi
