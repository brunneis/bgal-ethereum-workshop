#!/usr/bin/env python
# -*- coding: utf-8 -*-

from easyweb3 import EasyWeb3
from urllib.request import urlopen, Request
from urllib.error import HTTPError


eweb3 = EasyWeb3('wallet.json')
address = eweb3.account.address

url = f'https://faucet.ropsten.be/donate/{address}'
try:
    response = urlopen(Request(url=url))
    print(response.read().decode('utf-8'))
except HTTPError as e:
    print(e.read().decode('utf-8'))