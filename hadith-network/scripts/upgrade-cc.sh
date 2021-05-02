#!/bin/bash
echo $1
echo "Installing chaincode for producer..."
docker exec -it cli ./scripts/install-cc/install-producer.sh $1
echo "Installing chaincode for alazharuniversity..."
docker exec -it cli ./scripts/install-cc/install-alazharuniversity.sh $1
echo "Installing chaincode for islamicuniveristy..."
docker exec -it cli ./scripts/install-cc/install-islamicuniveristy.sh $1
echo "Installing chaincode for omelkorrauniversity..."
docker exec -it cli ./scripts/install-cc/install-omelkorrauniversity.sh $1
echo "Instanciating the chaincode..."
docker exec -it cli ./scripts/install-cc/upgrade.sh $1
