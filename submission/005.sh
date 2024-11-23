# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
TXID=37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517

raw_tx=$(bitcoin-cli getrawtransaction $TXID)
decoded_tx=$(bitcoin-cli decoderawtransaction $raw_tx)
pub_keys=$(echo $decoded_tx | jq '.["vin"] | [.[] | .txinwitness[1]]')
encoded_json=$(echo $pub_keys | jq .)

multisig=$(bitcoin-cli createmultisig 1 "$encoded_json")

echo $multisig | jq -r '.["address"]'
