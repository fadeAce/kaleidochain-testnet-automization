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
    /tmp/node${seq}.dat.$$ < ssh root@${IP} "docker run --rm -v /usr/local/kaleido/testnet/node${seq}:/root/.ethereum kaleidochain/client:test --testnet makeminerkey --miner ${addr} --coinbase ${addr} --begin ${h}"
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
    ssh root@${IP} "mkdir -p /usr/local/kaleido/testnet/node${seq}"
    res=$(initnode ${IP} ${SEQ} ${ADDR} ${H})
    echo "result for node is "${res}
    if [[ ${res} -eq 0 ]]; then
    # none fail here and inside ,directly start up
    echo "NODE_NAME=${NAME};KPORT=388$[${SEQ}+2];CONTAINER=node${SEQ};ADDRESS=${ADDR}"
    ssh root@${IP} "export ADDRESS=${ADDR};export NODE_NAME=${NAME};export KPORT=388$[${SEQ}+2];export CONTAINER=node${SEQ};wget https://raw.githubusercontent.com/fadeAce/kaleidochain-testnet-automization/master/testnet.sh;chmod +x testnet.sh;bash testnet.sh"
    fi
done < ${filename}
