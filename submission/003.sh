# How many new outputs were created by block 123,456?
block=123456
stats=$(bitcoin-cli getblockstats $block)

echo $stats | jq '.["outs"]'
