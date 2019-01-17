#!/usr/bin/env python
# -*- coding: utf-8 -*-

from easyweb3 import EasyWeb3
from os import getenv
from dotenv import load_dotenv
from easysolc import Solc
import logging
import binascii


load_dotenv()
INFURA_ENDPOINT = getenv("INFURA_ENDPOINT")
web3 = EasyWeb3('wallet.json', http_provider=INFURA_ENDPOINT)
solc = Solc()

contract_name = 'CopyrightRegistry'

with open(f'compiled/{contract_name}.address', 'r') as address_file:
    contract_address = next(address_file)
logging.info(f'Contract address: {contract_address}')

contract = solc.get_contract_instance(w3=web3,
                                      address=contract_address,
                                      abi_file=f'compiled/{contract_name}.abi')

# addLicense
gplv3_hash = bytes.fromhex('38d290a6790cc2d5fd9c26aef474521a0f2d01661247bd8ee6d8e836d93d20b4')
parameters = [gplv3_hash, 'The GNU General Public License v3.0']
logging.info('Executing addLicense()')
tx_hash = web3.write(contract, 'addLicense', parameters)['transactionHash'].hex()
logging.info(f'tx_hash: {tx_hash}\n')

# getLicense
parameters = [gplv3_hash]
logging.info('Executing getLicense()')
result = web3.read(contract, 'getLicense', parameters)
logging.info(f'result: {result}\n')

# addRecord
file_hash = bytes.fromhex('50fe940b052d377ffe063c1877343b913f8a0f19c0365589b79e51ee2e83995e')
parameters = [file_hash, 'Bitcoin', 'The Bitcoin original logo', gplv3_hash]
logging.info('Executing addRecord()')
tx_hash = web3.write(contract, 'addRecord', parameters)['transactionHash'].hex()
logging.info(f'tx_hash: {tx_hash}\n')

# getRecord
parameters = [file_hash]
logging.info('Executing getRecord()')
result = web3.read(contract, 'getRecord', parameters)
processed_result = []
for item in result:
    if type(item) == bytes:
        item = binascii.b2a_hex(item).decode('utf-8')
    processed_result.append(item)
logging.info(f'result: {processed_result}\n')