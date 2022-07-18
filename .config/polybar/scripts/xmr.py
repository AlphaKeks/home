#!/usr/bin/env python3

import json,sys,requests

response = requests.get('https://api.huobi.pro/market/trade?symbol=xmrusdt')
data = response.json()
price = data['tick']['data'][0]['price']
sys.stdout.write("XMR: $" + str(price))
sys.stdout.flush()
