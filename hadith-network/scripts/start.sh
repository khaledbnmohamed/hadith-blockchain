#!/bin/bash
export IMAGE_TAG=1.4.3

echo "Creating containers... "

# TODO This approach is hacky; instead, identify where hyperledger/fabric-ccenv is pulled and update the tag to 1.4.3
docker pull hyperledger/fabric-ccenv:1.4.3
docker tag hyperledger/fabric-ccenv:1.4.3 hyperledger/fabric-ccenv:latest

docker-compose -f ./hadith-network/docker-compose-cli.yaml up -d
echo 
echo "Containers started" 
echo 
docker ps

docker exec -it cli ./scripts/channel/createChannel.sh

echo "Joining Islamicuniveristy to channel..."
docker exec -it cli ./scripts/channel/join-peer.sh peer0 islamicuniveristy IslamicuniveristyMSP 10051 1.0
echo "Joining Alazharuniversity to channel..."
docker exec -it cli ./scripts/channel/join-peer.sh peer0 alazhar-university AlazharuniversityMSP 9051 1.0
echo "Joining OmElkorauniversity to channel..." 
docker exec -it cli ./scripts/channel/join-peer.sh peer0 omelkorra-university OmElkorauniversityMSP 11051 1.0
