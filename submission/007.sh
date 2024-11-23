# Only one single output remains unspent from block 123,321. What address was it sent to?
hash=$(bitcoin-cli getblockhash 123321)
block=$(bitcoin-cli getblock $hash 2)
#txids=$(bitcoin-cli getblock $hash | jq -r '.tx[]')
#txids=$(echo $block | jq -r '.tx[]')
echo $block | jq .
