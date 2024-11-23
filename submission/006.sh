# Which tx in block 257,343 spends the coinbase output of block 256,128?
#!/bin/bash
# block 256128
hash=$(bitcoin-cli getblockhash 256128)
stats=$(bitcoin-cli getblock $hash)
txs=$(echo $stats | jq -r '.["tx"]')
coinbase=$(echo $txs | jq -r '.[0]')
raw_coinbase_info=$(bitcoin-cli getrawtransaction $coinbase)
coinbase_info=$(bitcoin-cli decoderawtransaction $raw_coinbase_info)
vout_hex=$(echo $coinbase_info | jq -r '.["vout"][] | .scriptPubKey.hex')
vout_script=$(bitcoin-cli decodescript $vout_hex)
address=$(echo $coinbase_info | jq -r '.["vout"][] | .scriptPubKey.address')
value=$(echo $coinbase_info | jq -r '.["vout"][] | .value')

# block 257343

hash=$(bitcoin-cli getblockhash 257343)
stats=$(bitcoin-cli getblock $hash 3)
txs=$(echo $stats | jq --arg lookup_hex "$vout_hex" '[.["tx"][]]')

heights_txs=$(echo $txs | jq -r '.[] | select(.vin[].prevout.height == 256128) | .txid')
echo $heights_txs
