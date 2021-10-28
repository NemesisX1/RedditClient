import requests
import requests.auth
client_auth = requests.auth.HTTPBasicAuth('bIKGByoTSU0esBOI9rNkpg', 'cZDIcwRJZoJS1yUCyoOymyeG_gg2tw')
post_data = {"grant_type": "password", "username": "NemesisX10", "password": "ZanarkandFF10"}
headers = {"User-Agent": "ChangeMeClient/0.1 by YourUsername"}
response = requests.post("https://www.reddit.com/api/v1/access_token", auth=client_auth, data=post_data, headers=headers)
res = response.json()
print(res)