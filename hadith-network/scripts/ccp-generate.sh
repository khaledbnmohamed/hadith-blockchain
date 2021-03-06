#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $5)
    local CP=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${ORGMSP}/$2/" \
        -e "s/\${P0PORT}/$3/" \
        -e "s/\${CAPORT}/$4/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ./connections/ccp-template.json 
}


ORG=producer
ORGMSP=Producer
P0PORT=7051
CAPORT=7054
PEERPEM=./hadith-network/crypto-config/peerOrganizations/producer.example.com/tlsca/tlsca.producer.example.com-cert.pem
CAPEM=./hadith-network/crypto-config/peerOrganizations/producer.example.com/ca/ca.producer.example.com-cert.pem

echo "$(json_ccp $ORG $ORGMSP $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./connections/connection-producer.json

ORG=alazharuniversity
ORGMSP=Alazharuniversity
P0PORT=9051
CAPORT=8054
PEERPEM=./hadith-network/crypto-config/peerOrganizations/alazharuniversity.example.com/tlsca/tlsca.alazharuniversity.example.com-cert.pem
CAPEM=./hadith-network/crypto-config/peerOrganizations/alazharuniversity.example.com/ca/ca.alazharuniversity.example.com-cert.pem

echo "$(json_ccp $ORG $ORGMSP $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./connections/connection-alazharuniversity.json
ORG=islamicuniveristy
ORGMSP=Islamicuniveristy
P0PORT=10051
CAPORT=9054
PEERPEM=./hadith-network/crypto-config/peerOrganizations/islamicuniveristy.example.com/tlsca/tlsca.islamicuniveristy.example.com-cert.pem
CAPEM=./hadith-network/crypto-config/peerOrganizations/islamicuniveristy.example.com/ca/ca.islamicuniveristy.example.com-cert.pem

echo "$(json_ccp $ORG $ORGMSP $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./connections/connection-islamicuniveristy.json

ORG=omelkorrauniversity
ORGMSP=Omelkorrauniversity
P0PORT=11051
CAPORT=10054
PEERPEM=./hadith-network/crypto-config/peerOrganizations/omelkorrauniversity.example.com/tlsca/tlsca.omelkorrauniversity.example.com-cert.pem
CAPEM=./hadith-network/crypto-config/peerOrganizations/omelkorrauniversity.example.com/ca/ca.omelkorrauniversity.example.com-cert.pem

echo "$(json_ccp $ORG $ORGMSP $P0PORT $CAPORT $PEERPEM $CAPEM)" > ./connections/connection-omelkorrauniversity.json
