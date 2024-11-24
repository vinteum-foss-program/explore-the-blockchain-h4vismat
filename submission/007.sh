# Only one single output remains unspent from block 123,321. What address was it sent to?
hash=$(bitcoin-cli getblockhash 123321)
block=$(bitcoin-cli getblock $hash 2)

echo "$block" | jq -c '.tx[]' | while read tx; do
    txid=$(echo $tx | jq -r '.txid')
    echo "$tx" | jq -c '.vout[]' | while read vout; do
        vout_index=$(echo $vout | jq -r '.n')
        utxo=$(bitcoin-cli gettxout $txid $vout_index)
        if [[ ! -z "$utxo" ]]; then
            address=$(echo $vout | jq -r '.scriptPubKey.address')
            echo $address
        fi
    done
done
