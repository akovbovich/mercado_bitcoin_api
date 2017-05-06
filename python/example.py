# -*- coding: utf-8 -*-

import hashlib
import hmac
import httplib
import json
import urllib
import os
import time

from collections import OrderedDict


# Constantes
MB_TAPI_ID = os.environ['MB_TAPI_ID']
MB_TAPI_SECRET = os.environ['MB_TAPI_SECRET']
REQUEST_HOST = 'www.mercadobitcoin.net'
REQUEST_PATH = '/tapi/v3/'

# Nonce
# Para obter variação de forma simples
# timestamp pode ser utilizado:
#     import time
#     tapi_nonce = str(int(time.time()))
tapi_nonce = 1

# Parâmetros
params = {
    'tapi_method': 'get_account_info',
    'tapi_nonce': str(int(time.time()))
}
params = urllib.urlencode(params)

# Gerar MAC
params_string = REQUEST_PATH + '?' + params
H = hmac.new(MB_TAPI_SECRET, digestmod=hashlib.sha512)
H.update(params_string)
tapi_mac = H.hexdigest()

# Gerar cabeçalho da requisição
headers = {
    'Content-type': 'application/x-www-form-urlencoded',
    'TAPI-ID': MB_TAPI_ID,
    'TAPI-MAC': tapi_mac
}

# Realizar requisição POST
try:
    conn = httplib.HTTPSConnection(REQUEST_HOST)
    print REQUEST_PATH
    print params
    print headers
    conn.request("POST", REQUEST_PATH, params, headers)
    
    # Print response data to console
    response = conn.getresponse()
    response = response.read()

    # É fundamental utilizar a classe OrderedDict para preservar a ordem dos elementos
    response_json = json.loads(response, object_pairs_hook=OrderedDict)
    print "status: %s" % response_json['status_code']
    print(json.dumps(response_json, indent=4))
finally:
    if conn:
        conn.close()
