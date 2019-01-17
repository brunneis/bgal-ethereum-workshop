#!/usr/bin/env python
# -*- coding: utf-8 -*-

from easysolc import Solc
import os
import logging


solc = Solc('./solc')
contracts_dir = 'contracts'
for contract in os.listdir(contracts_dir):
    if contract == 'base.sol':
        continue
    logging.info(f'Compiling {contract}...')
    solc.compile(f'{contracts_dir}/{contract}', output_dir='compiled')
    logging.info(f'{contract} compiled!')
