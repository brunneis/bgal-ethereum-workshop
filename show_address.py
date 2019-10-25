#!/usr/bin/env python
# -*- coding: utf-8 -*-

from easyweb3 import EasyWeb3
from os import getenv
from dotenv import load_dotenv


load_dotenv()
INFURA_ENDPOINT = getenv("INFURA_ENDPOINT")
web3 = EasyWeb3('wallet.json', http_provider=INFURA_ENDPOINT)

address = web3.account.address
balance = web3.eth.getBalance(address)
print(f'Address: {address}')
print(f'Balance: {balance / 10e17} ETH')