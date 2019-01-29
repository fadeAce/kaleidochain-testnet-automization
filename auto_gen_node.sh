#!/bin/bash

filename=gen.kal
echo "filename="${filename}



function initnode() {
    ip=$1
    seq=$2
    addr=$3
    exist=$(ssh root@${IP} "if [ -d "/usr/local/kaleido/testnet/node${seq}/testnet/geth/ephemeralkey-${addr}-0-1000000" ];then
        echo 'exist'")
    h=$4
    if [[ "$exist" == "exist" ]]; then
        return 1
    fi
    ssh root@${IP} "docker run --rm -v /usr/local/kaleido/testnet/node${seq}:/root/.ethereum kaleidochain/client:test --testnet makeminerkey --miner ${addr} --coinbase ${addr} --begin ${h}" > /tmp/node${seq}.dat.$$
    JS=`cat /tmp/node${seq}.dat.$$ | gawk '/miner:/{miner=$2;printf("personal.unlockAccount(\"%s\", \"1234\", 3000); ", miner);} /contract address/{minerdb=$3;} /Generate minerkey/{data=$3; printf("hash=eth.sendTransaction({from:\"%s\", to:\"%s\", gas:200000, gasPrice:20000000000, data:\"%s\"});admin.sleepBlocks(2);receipt=eth.getTransactionReceipt(hash);console.log(JSON.stringify(receipt, null, \"\\t\")); hash;\n",miner,minerdb,data)}'`
    cat /tmp/node${seq}.dat.$$
    rm /tmp/node${seq}.dat.$$

    docker exec node1 geth --testnet attach --exec "${JS}"
    return 0
}



while read IP SEQ ADDR NAME;
do
	if [[ "IP" == "127.0.0.1" ]]; then
        continue
    fi
    # find H
    H=$(docker exec node1 geth --testnet attach --exec eth.blockNumber)
    ssh root@${IP} "mkdir -p /usr/local/kaleido/testnet/node${SEQ}"
    res=$(initnode ${IP} ${SEQ} ${ADDR} ${H})
    echo "result for node is "${res}
    if [[ ${res} -eq 0 ]]; then
    # none fail here and inside ,directly start up
    echo "NODE_NAME=${NAME};KPORT=388$[${SEQ}+2];CONTAINER=node${SEQ};ADDRESS=${ADDR}"
    ssh root@${IP} "export ADDRESS=${ADDR};export NODE_NAME=${NAME};export KPORT=388$[${SEQ}+2];export CONTAINER=node${SEQ};docker stop ${CONTAINER};docker rm ${CONTAINER};docker run -d -p ${KPORT}:${KPORT} -p ${KPORT}:${KPORT}/udp --name="${CONTAINER}" -v $PWD/${CONTAINER}:/root/.ethereum kaleidochain/client:test geth -tnode enode://a5989375caad943d5c42a1c2e129cadacb94db2392d3aa22ee081f05f66bfb580a86d3b14f320399ecf6b3348ad06284a6ed038c44cda25630ef4027e7102a06@45.77.42.61:9992  --testnet --mine --etherbase ${ADDRESS} --gcmode archive --ethstats '${NODE_NAME}:1234@45.77.42.61:30303' --verbosity 3 --vmodule 'eth/*=5,consensus/*=5,core/*=5,miner/*=5,p2p/discv5/*=3,p2p/discover/*=3,p2p/*=5'"
    fi
done < ${filename}