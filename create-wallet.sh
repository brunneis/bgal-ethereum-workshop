#!/bin/bash
if [ ! -f wallet.json ]; then
    docker run -ti -e "HOST_UID=$UID" -v "$(pwd)":/tmp/geth/keystore brunneis/alastria-geth account new
    mv UTC--* wallet.json
else
    echo wallet.json already exists
fi
