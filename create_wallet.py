from easyweb3 import EasyWeb3
import json

private_key = EasyWeb3().web3.eth.account.create()
private_key_dict = private_key.encrypt('')
with open(f'./wallet.json', 'w') as output_file:
    json.dump(private_key_dict, output_file)