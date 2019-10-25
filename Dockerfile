FROM catenae/link:2.0.0
RUN pip install easysolc easyweb3 python-dotenv && mkdir /contracts
ADD contracts /contracts
COPY .env solc claim_ropsten_eth.py compile.py deploy.py interact_copyright.py show_address.py wallet.json /
WORKDIR /
ENTRYPOINT bash
