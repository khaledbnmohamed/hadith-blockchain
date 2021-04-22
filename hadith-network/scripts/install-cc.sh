#!/bin/bash

echo "Installing chaincode for producer..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 producer ProducerMSP 7051 1.0
echo "Installing chaincode for alazhar-university..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 alazhar-university AlazharuniversityMSP 9051 1.0
echo "Installing chaincode for islamicuniveristy..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 islamicuniveristy IslamicuniveristyMSP 10051 1.0
echo "Installing chaincode for omelkorra-university..."
docker exec -it cli ./scripts/install-cc/install-peer.sh peer0 omelkorra-university OmElkorauniversityMSP 11051 1.0
echo "Instanciating the chaincode..."
docker exec -it cli ./scripts/install-cc/instanciate.sh 
