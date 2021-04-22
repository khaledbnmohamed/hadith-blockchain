#!/bin/bash

echo "***********************************"
echo "       Stopping network            "
echo "***********************************"
docker-compose -f ./hadith-network/docker-compose-cli.yaml down --volumes --remove-orphans
rm -r ./hadith-network/crypto-config
rm -r ./hadith-network/channel-artifacts
rm -r ./hadith-network/base/docker-compose-base.yaml
rm -r ./wallet
