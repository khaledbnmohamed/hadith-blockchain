#!/bin/bash
export IMAGE_TAG=1.4.3
echo "Generating cryto material for peers..."
[ -d ./hadith-network/channel-artifacts ] || mkdir ./hadith-network/channel-artifacts

../bin/cryptogen generate --config=./hadith-network/crypto-config.yaml --output="./hadith-network/crypto-config"

[ -d ./hadith-network/crypto-config ] || mkdir ./hadith-network/crypto-config

echo "Generating channel artifacts and genesis block..."
../bin/configtxgen -configPath ./hadith-network -profile SupplyOrdererGenesis -outputBlock ./hadith-network/channel-artifacts/genesis.block
../bin/configtxgen -configPath ./hadith-network -profile SupplyChannel -outputCreateChannelTx ./hadith-network/channel-artifacts/channel.tx -channelID mychannel

 CURRENT_DIR=$PWD
 cd ./hadith-network/base
 cp docker-compose-base-template.yaml docker-compose-base.yaml
 OPTS="-i"
 cd $CURRENT_DIR
 cd ./hadith-network/crypto-config/peerOrganizations/producer.example.com/ca/
 PRIV_KEY=$(ls *_sk)
 cd $CURRENT_DIR
 cd ./hadith-network/base
 sed $OPTS "s/CA1_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose-base.yaml
 
 cd $CURRENT_DIR
 cd ./hadith-network/crypto-config/peerOrganizations/alazhar-university.example.com/ca/
 PRIV_KEY=$(ls *_sk)
 cd $CURRENT_DIR
 cd ./hadith-network/base
 sed $OPTS "s/CA2_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose-base.yaml
 
 
 cd $CURRENT_DIR
 cd ./hadith-network/crypto-config/peerOrganizations/islamicuniveristy.example.com/ca/
 PRIV_KEY=$(ls *_sk)
 cd $CURRENT_DIR
 cd ./hadith-network/base
 sed $OPTS "s/CA3_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose-base.yaml
 
 
 cd $CURRENT_DIR
 cd ./hadith-network/crypto-config/peerOrganizations/omelkorra-university.example.com/ca/
 PRIV_KEY=$(ls *_sk)
 cd $CURRENT_DIR
 cd ./hadith-network/base
 sed $OPTS "s/CA4_PRIVATE_KEY/${PRIV_KEY}/g" docker-compose-base.yaml
  
  
 cd $CURRENT_DIR
 ./hadith-network/scripts/ccp-generate.sh
