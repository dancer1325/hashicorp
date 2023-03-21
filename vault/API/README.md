# Content
* 'auth.json'
  * Data to enable AppRole auth method via API
    * `curl \
      --header "X-Vault-Token: ..." \
      --request POST \
      --data @auth.json \
      http://127.0.0.1:8200/v1/sys/auth/approle
      `


## Notes:
* Main links to work with auth method via API
  * Choose the [corresponding case](https://developer.hashicorp.com/vault/docs/auth)
  * Choose each one [here](https://developer.hashicorp.com/vault/api-docs/auth) 