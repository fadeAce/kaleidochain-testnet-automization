#!/bin/bash
ARG=$1

if [[ -z ${ARG} ]]; then
    echo "Commands:"
    echo "    pull"
    echo "    start"
    echo "    stop"
    echo "    rm"
    echo "    up"
    echo "    ps"
    exit
fi

if [[ "$ARG" == "pull" ]]; then
   #Atlanta
   ssh root@144.202.20.161 "docker pull harbor.headlines.pw/kaleido/turn-test:v0.0.4"
   #Silicon
   ssh root@149.28.208.216 "docker pull harbor.headlines.pw/kaleido/turn-test:v0.0.4"
   #Paris
   ssh root@217.69.5.78 "docker pull harbor.headlines.pw/kaleido/turn-test:v0.0.4"
   #Franjfuirt
   ssh root@140.82.38.200 "docker pull harbor.headlines.pw/kaleido/turn-test:v0.0.4"
   #London
   ssh root@45.77.227.48 "docker pull harbor.headlines.pw/kaleido/turn-test:v0.0.4"
   #Tokyo
   ssh root@149.28.27.110 "docker pull harbor.headlines.pw/kaleido/turn-test:v0.0.4"
   #Sydney
   #ssh root@149.28.172.14 "docker pull harbor.headlines.pw/kaleido/turn-test:v0.0.4"
   #China
   ssh root@119.23.233.228 "docker pull harbor.headlines.pw/kaleido/turn-test:v0.0.4"
fi

if [[ "$ARG" == "start" ]]; then
   #Atlanta
   ssh root@144.202.20.161 "docker start node1"
   #Silicon
   ssh root@149.28.208.216 "docker start node1"
   #Paris
   ssh root@217.69.5.78 "docker start node1"
   #Franjfuirt
   ssh root@140.82.38.200 "docker start node1"
   #London
   ssh root@45.77.227.48 "docker start node1"
   #Tokyo
   ssh root@149.28.27.110 "docker start node1"
   #Sydney
   #ssh root@149.28.172.14 "docker start node1"
   #China
   ssh root@119.23.233.228 "docker start node1"
fi

if [[ "$ARG" == "stop" ]]; then
   #Atlanta
   ssh root@144.202.20.161 "docker stop node1"
   #Silicon
   ssh root@149.28.208.216 "docker stop node1"
   #Paris
   ssh root@217.69.5.78 "docker stop node1"
   #Franjfuirt
   ssh root@140.82.38.200 "docker stop node1"
   #London
   ssh root@45.77.227.48 "docker stop node1"
   #Tokyo
   ssh root@149.28.27.110 "docker stop node1"
   #Sydney
   #ssh root@149.28.172.14 "docker stop node1"
   #China
   ssh root@119.23.233.228 "docker stop node1"
fi

if [[ "$ARG" == "rm" ]]; then
   #Atlanta
   ssh root@144.202.20.161 "docker rm node1"
   #Silicon
   ssh root@149.28.208.216 "docker rm node1"
   #Paris
   ssh root@217.69.5.78 "docker rm node1"
   #Franjfuirt
   ssh root@140.82.38.200 "docker rm node1"
   #London
   ssh root@45.77.227.48 "docker rm node1"
   #Tokyo
   ssh root@149.28.27.110 "docker rm node1"
   #Sydney
   #ssh root@149.28.172.14 "docker rm node1"
   #China
   ssh root@119.23.233.228 "docker rm node1"
fi


if [[ "$ARG" == "up" ]]; then
   #Atlanta
   ssh root@144.202.20.161 "cd /usr/local/kaleido/testnet;docker-compose up -d"
   #Silicon
   ssh root@149.28.208.216 "cd /usr/local/kaleido/testnet;docker-compose up -d"
   #Paris
   ssh root@217.69.5.78 "cd /usr/local/kaleido/testnet;docker-compose up -d"
   #Franjfuirt
   ssh root@140.82.38.200 "cd /usr/local/kaleido/testnet;docker-compose up -d"
   #London
   ssh root@45.77.227.48 "cd /usr/local/kaleido/testnet;docker-compose up -d"
   #Tokyo
   ssh root@149.28.27.110 "cd /usr/local/kaleido/testnet;docker-compose up -d"
   #Sydney
   #ssh root@149.28.172.14 "cd /usr/local/kaleido/testnet;docker-compose up -d"
   #China
   ssh root@119.23.233.228 "cd /usr/local/kaleido/testnet;docker-compose up -d"
fi


if [[ "$ARG" == "ps" ]]; then
   #Atlanta
   ssh root@144.202.20.161 "docker ps"
   #Silicon
   ssh root@149.28.208.216 "docker ps"
   #Paris
   ssh root@217.69.5.78 "docker ps"
   #Franjfuirt
   ssh root@140.82.38.200 "docker ps"
   #London
   ssh root@45.77.227.48 "docker ps"
   #Tokyo
   ssh root@149.28.27.110 "docker ps"
   #Sydney
   #ssh root@149.28.172.14 "cd /usr/local/kaleido/testnet;docker-compose up -d"
   #China
   ssh root@119.23.233.228 "docker ps"
fi


if [[ "$ARG" == "update" ]]; then
   #Atlanta
   ssh root@144.202.20.161 "cd /usr/local/kaleido/testnet;git clone https://github.com/fadeAce/kaleidochain-testnet-automization.git;cp kaleidochain-testnet-automization/"
   #Silicon
   ssh root@149.28.208.216 "docker ps"
   #Paris
   ssh root@217.69.5.78 "docker ps"
   #Franjfuirt
   ssh root@140.82.38.200 "docker ps"
   #London
   ssh root@45.77.227.48 "docker ps"
   #Tokyo
   ssh root@149.28.27.110 "docker ps"
   #Sydney
   #ssh root@149.28.172.14 "cd /usr/local/kaleido/testnet;docker-compose up -d"
   #China
   ssh root@119.23.233.228 "docker ps"
fi


