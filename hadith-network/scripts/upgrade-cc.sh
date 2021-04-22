#!/bin/bash
echo $1
echo "Installing chaincode for producer..."
docker exec -it cli ./scripts/install-cc/install-producer.sh $1
echo "Installing chaincode for alazhar-university..."
docker exec -it cli ./scripts/install-cc/install-alazhar-university.sh $1
echo "Installing chaincode for islamicuniveristy..."
docker exec -it cli ./scripts/install-cc/install-islamicuniveristy.sh $1
echo "Installing chaincode for omelkorra-university..."
docker exec -it cli ./scripts/install-cc/install-omelkorra-university.sh $1
echo "Instanciating the chaincode..."
docker exec -it cli ./scripts/install-cc/upgrade.sh $1
