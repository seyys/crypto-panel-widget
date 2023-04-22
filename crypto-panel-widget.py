import requests
import json

url = 'https://api.binance.com/api/v3/ticker/price?symbols=["BTCUSDT","ETHUSDT","LINKUSDT","ROSEUSDT"]'
res = requests.get(url)
d = json.loads(res.text)
output = []
for currency in d:
    output.append(f'{str.replace(currency["symbol"], "USDT", "")} {float(currency["price"])}')
print(' | '.join(output))