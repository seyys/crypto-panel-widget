#!/bin/bash

url="https://api.binance.com/api/v3/ticker/price?symbols=\[\"BTCUSDT\",\"ETHUSDT\",\"LINKUSDT\",\"ROSEUSDT\"\]"
data=$(curl -s "$url")

if [[ $? -eq 0 ]]; then
  echo $data | jq -r '.[] | "\(.symbol | sub("\\.?USDT$"; "")) \(.price | sub("\\.?0*$"; ""))"' | awk '{ORS=" | "} {print}' | sed 's/ | $//'
else
  echo "Failed to retrieve data from the URL."
fi

