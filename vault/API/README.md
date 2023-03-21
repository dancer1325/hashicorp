# Content
* 'auth.json'
  * Data to enable AppRole auth method via API
    * `curl \
      --header "X-Vault-Token: ..." \
      --request POST \
      --data @auth.json \
      http://127.0.0.1:8200/v1/sys/auth/approle
* 'sampleRequests.http'
  * Sample HTTP requests
      `

## How to test requests?
* Install AWS CLI
* Deploy the Vault Dev Server
  * `vault server -dev`

## Notes:
* Main links to work with auth method via API
  * Choose the [corresponding case](https://developer.hashicorp.com/vault/docs/auth)
  * Choose each one [here](https://developer.hashicorp.com/vault/api-docs/auth)
* 