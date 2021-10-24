import requests

# note that CLIENT_ID refers to 'personal use script' and SECRET_TOKEN to 'token'
auth = requests.auth.HTTPBasicAuth('Az-vOK6dPexd1UlQxumtNA', 'MMMSpIb20phoGAt4pxVjKCYZdOmHMQ')

# here we pass our login method (password), username, and password
data = {'grant_type': 'authorization_code',
        'code': 'TprU40-yMMK4FuoWQtWUdRtVW8N2lg',
        'redirect_uri': 'https://www.twitter.com/juniormedehou_'}

# setup our header info, which gives reddit a brief description of our app
headers = {'User-Agent': 'reditech-nemkd22'}

# send our request for an OAuth token
res = requests.post('https://www.reddit.com/api/v1/access_token',
                    auth=auth, data=data, headers=headers)

print(res.url)
print(res.headers)
# convert response to JSON and pull access_token value
print(auth)
print(res.json())
# TOKEN = res.json()['access_token']

# # add authorization to our headers dictionary
# headers = {**headers, **{'Authorization': f"bearer {TOKEN}"}}

# # while the token is valid (~2 hours) we just add headers=headers to our requests
# requests.get('https://oauth.reddit.com/api/v1/me', headers=headers)

#identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread
#https://www.reddit.com/api/v1/authorize?client_id=Az-vOK6dPexd1UlQxumtNA&response_type=code&state=RANDOM_STRING&redirect_uri=https://www.twitter.com/juniormedehou_&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread
#https://twitter.com/juniormedehou_?state=RANDOM_STRING&code=TprU40-yMMK4FuoWQtWUdRtVW8N2lg#_