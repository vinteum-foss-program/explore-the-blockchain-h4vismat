# Which tx in block 257,343 spends the coinbase output of block 256,128?
#!/bin/bash
hash=$(bitcoin-cli getblockhash 257343)
stats=$(bitcoin-cli getblock $hash 3)
txs=$(echo $stats | jq --arg lookup_hex "$vout_hex" '[.["tx"][]]')

heights_txs=$(echo $txs | jq -r '.[] | select(.vin[].prevout.height == 256128) | .txid')
echo $heights_txs
