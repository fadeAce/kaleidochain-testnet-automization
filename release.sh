#!/bin/bash
ARG=$1

#Atlanta
arry_net[0]="144.202.20.161"
#SiliconValley
arry_net[1]="119.23.233.228"
#China
arry_net[2]="149.28.208.216"
#Paris
arry_net[3]="217.69.5.78"
#Franjfuirt
arry_net[4]="140.82.38.200"
#London
arry_net[5]="45.77.227.48"
#Tokyo
arry_net[6]="149.28.27.110"
#Sydney
arry_net[7]="45.76.114.125"
#Sydney
arry_net[8]="127.0.0.1"


if [[ -z ${ARG} ]]; then
    echo "Commands:"
    echo "    pull                  pull the latest image for testnet"
    echo "    start                 start all dead nodes (skip alive)"
    echo "    stop                  stop all living nodes (skip dead)"
    echo "    rm                    rm all dead nodes (remove all need a preliminary of stop)"
    echo "    up                    up create new container for all nodes then run it"
    echo "    ps                    show all nodes"
    echo "    update                update compose file which decided how lifecycle runs in kal up"
    echo "    add [IP nickname]     add new node works as miner"
    exit
fi

if [[ "$ARG" == "add" ]]; then
    IP=$2
    addr=$3

    exit 0
fi


for var in ${arry_net[@]};
do
    if [[ "$var" == "127.0.0.1" ]]; then
        if [[ "$ARG" == "pull" ]]; then
        docker pull kaleidochain/client:test
        fi
        if [[ "$ARG" == "start" ]]; then
        docker start node1
        fi
        if [[ "$ARG" == "stop" ]]; then
        docker stop node1
        fi
        if [[ "$ARG" == "rm" ]]; then
        docker rm node1
        fi
        if [[ "$ARG" == "up" ]]; then
        cd /usr/local/kaleido/testnet;docker-compose up -d
        fi
        if [[ "$ARG" == "ps" ]]; then
        docker ps
        fi
        if [[ "$ARG" == "update" ]]; then
        docker pull kaleidochain/client:test
        fi
        continue
    fi
     if [[ "$ARG" == "pull" ]]; then
        ssh root@${var} "docker pull kaleidochain/client:test"
        fi
        if [[ "$ARG" == "start" ]]; then
        ssh root@${var} "docker start node1"
        fi
        if [[ "$ARG" == "stop" ]]; then
        ssh root@${var} "docker stop node1"
        fi
        if [[ "$ARG" == "rm" ]]; then
        ssh root@${var} "docker rm node1"
        fi
        if [[ "$ARG" == "up" ]]; then
        ssh root@${var} "cd /usr/local/kaleido/testnet;docker-compose up -d"
        fi
        if [[ "$ARG" == "ps" ]]; then
        ssh root@${var} "docker ps"
        fi
        if [[ "$ARG" == "update" ]]; then
        ssh root@${var} "docker pull kaleidochain/client:test"
        fi
done