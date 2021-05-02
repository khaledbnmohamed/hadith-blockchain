#!/bin/bash

echo "Installing chaincode for producer..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 producer ProducerMSP 7051 1.0
echo "Installing chaincode for alazharuniversity..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 alazharuniversity AlazharuniversityMSP 9051 1.0
echo "Installing chaincode for islamicuniveristy..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 islamicuniveristy IslamicuniveristyMSP 10051 1.0
echo "Installing chaincode for omelkorrauniversity..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 omelkorrauniversity OmelkorrauniversityMSP 11051 1.0
echo "Instanciating the chaincode..."
docker exec -it cli ./scripts/install-cc/instanciate.sh 
