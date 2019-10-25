#!/bin/bash
source .env
wget https://github.com/ethereum/solidity/releases/download/v$SOLC_VERSION/solc-static-linux -O solc
chmod +x solc
