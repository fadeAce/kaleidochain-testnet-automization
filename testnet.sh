#!/bin/bash

#prepare dir
cd /usr/local
mkdir kaleido
cd kaleido
mkdir testnet
cd testnet
mkdir node1
cd node1
mkdir testnet
cd testnet
mkdir geth
mkdir keystore

#prepare compose file
cd /usr/local/kaleido/testnet
touch docker-compose.yml

echo 'version: "2"' >> docker-compose.yml
echo 'services:' >> docker-compose.yml
echo '  turn:' >> docker-compose.yml
echo '    image: harbor.headlines.pw/kaleido/turn-test:v0.0.4' >> docker-compose.yml
echo '    container_name: node1' >> docker-compose.yml
echo '    ports:' >> docker-compose.yml
echo '      - "2510:2510"' >> docker-compose.yml
echo '      - "38883:38883"' >> docker-compose.yml
echo '      - "38883:38883/udp"' >> docker-compose.yml
echo '    volumes:' >> docker-compose.yml
echo '      - $PWD/node1:/root/.ethereum' >> docker-compose.yml
echo "    entrypoint: geth -tnode enode://a5989375caad943d5c42a1c2e129cadacb94db2392d3aa22ee081f05f66bfb580a86d3b14f320399ecf6b3348ad06284a6ed038c44cda25630ef4027e7102a06@45.77.42.61:9992  --testnet --rpc --rpcaddr=0.0.0.0 --rpcvhosts='*' --rpcapi eth,net --ws --wsaddr=0.0.0.0 --wsorigins='*' --verbosity 3 --vmodule 'eth/*=5,consensus/*=5,core/*=5,miner/*=5,p2p/discv5/*=3,p2p/discover/*=3,p2p/*=5'" >> docker-compose.yml

#prepare compose itself
pip install docker-compose

#compose
docker-compose up -d