import urllib
import hashlib
import hmac

# Constantes e Parâmetros
# Do exemplo acima, '1ebda7d457ece1330dff1c9e04cd62c4e02d1835968ff89d2fb2339f06f73028'
MB_TAPI_SECRET = '1ebda7d457ece1330dff1c9e04cd62c4e02d1835968ff89d2fb2339f06f73028'
REQUEST_PATH = '/tapi/v3/'

# Parâmetros (variam de acordo com o método)
params = {
    # Do exemplo acima, 'list_orders'
    'tapi_method': 'get_account_info',
    # Do exemplo acima, 1
    'tapi_nonce': 1
}

# Parâmetros formatados
# Utilizado no request
params = urllib.urlencode(params)
# Utilizado apenas para gerar o MAC
params_string = REQUEST_PATH + '?' + params

# Gerar MAC
H = hmac.new(MB_TAPI_SECRET, digestmod=hashlib.sha512)
H.update(params_string)
tapi_mac = H.hexdigest()

print tapi_mac
