#!/bin/bash

url="https://api.binance.com/api/v3/ticker/price?symbols=\[\"BTCUSDT\",\"ETHUSDT\",\"LINKUSDT\",\"ROSEUSDT\"\]"
data=$(curl -s "$url")

if [[ $? -eq 0 ]]; then
  coin_names=$(echo "$data" | jq -r '.[].symbol | sub("\\.?USDT$"; "")')
  coin_prices=$(echo "$data" | jq -r '.[].price | sub("\\.?0*$"; "")')

  # Combine coin names and prices with space
  result=$(paste -d " " <(echo "$coin_names") <(echo "$coin_prices"))

  # Separate each group by " | " and remove trailing " | "
  printf "$result" | awk '{for (i=1; i<=NF; i+=2) printf "%s %s | ", $i, $(i+1)}' | sed 's/ | $//'
else
  echo "Failed to retrieve data from the URL."
fi

