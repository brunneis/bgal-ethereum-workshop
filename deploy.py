#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import logging
from easyweb3 import EasyWeb3
from os import getenv
from dotenv import load_dotenv
from easysolc import Solc


if len(sys.argv) < 2:
    logging.fatal('the contract name was not provided')
    raise SystemExit
contract_name = sys.argv[1]
contract_filename = f'{contract_name}.sol'

load_dotenv()
INFURA_ENDPOINT = getenv("INFURA_ENDPOINT")
web3 = EasyWeb3('wallet.json', http_provider=INFURA_ENDPOINT)
solc = Solc()

contract = solc.get_contract_instance(abi_file=f'compiled/{contract_name}.abi',
                                      bytecode_file=f'compiled/{contract_name}.bin')

receipt = web3.deploy(contract)
print(f"Transaction hash: {receipt['transactionHash'].hex()}")
print(f"Contract address: {receipt['contractAddress']}")

with open(f'compiled/{contract_name}.address', 'w') as address_file:
    address_file.write(receipt['contractAddress'])