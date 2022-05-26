#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ccp-template.json 
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
     sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ccp-template.yaml | sed -e $'s/\\\\n/\\\n        /g'
}

ORG=1
P0PORT=11051
CAPORT=7054
PEERPEM=crypto-config/peerOrganizations/org1.supply.com/tlsca/tlsca.org1.supply.com-cert.pem
CAPEM=crypto-config/peerOrganizations/org1.supply.com/ca/ca.org1.supply.com-cert.pem

echo "entered org1 connection"

echo "$(json_ccp $ORG $P0PORT  $CAPORT $PEERPEM $CAPEM)" > connection-org1.json
echo "$(yaml_ccp $ORG $P0PORT  $CAPORT $PEERPEM $CAPEM)" > connection-org1.yaml

ORG=2
P0PORT=12051
CAPORT=8054
PEERPEM=crypto-config/peerOrganizations/org2.supply.com/tlsca/tlsca.org2.supply.com-cert.pem
CAPEM=crypto-config/peerOrganizations/org2.supply.com/ca/ca.org2.supply.com-cert.pem

echo "entered org2 connection"

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org2.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org2.yaml