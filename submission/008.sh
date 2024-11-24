# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
TXID=e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163

raw_transaction=$(bitcoin-cli getrawtransaction $TXID 1)
key=$(echo $raw_transaction | jq -r '.["vin"][] | .txinwitness[2]')
pubkey=$(bitcoin-cli decodescript $key | jq -r '.["asm"]' | awk '{print $2}')

echo $pubkey
