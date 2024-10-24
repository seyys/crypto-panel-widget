#!/bin/bash

base_urls=(
  "https://data-api.binance.vision"
  "https://api.binance.com"
  "https://api1.binance.com"
  "https://api2.binance.com"
  "https://api3.binance.com"
  "https://api4.binance.com"
)

endpoint="/api/v3/ticker/price?symbols=[\"BTCUSDT\",\"ETHUSDT\",\"LINKUSDT\",\"ROSEUSDT\"]"

for url in "${base_urls[@]}"; do
  data=$(curl -sg "$url$endpoint")
  if [[ $? -eq 0 ]] && [[ -n "$data" ]]; then
    echo $data | \
      jq -r '.[] | "\(.symbol | sub("\\.?USDT$"; "")) \(.price | sub("\\.?0*$"; ""))"' | \
      awk '{ORS=" | "} {print}' | \
      sed 's/ | $//'
    exit 0
  fi
done

echo "Failed to retrieve data from the URL."
