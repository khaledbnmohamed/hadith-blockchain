#!/bin/bash
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

export COMPOSE_PROJECT_NAME=hadithchain

peer chaincode instantiate -o orderer.example.com:7050 --tls true --cafile $ORDERER_CA -C mychannel -l node -n supcc -v 1.0 -c '{"Args":[]}' >&log.txt

cat log.txt
