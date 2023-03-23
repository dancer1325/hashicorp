* Auth
  * `vault auth list`
    * List all the enabled Auth Methods
  * `vault auth enable okta`
    * Enable okta auth method, in the path 'okta'
    * `vault auth enable -path=anypath okta`
      * Enable okta in a custom path
    * `vault auth enable -description=DescriptionToAdd okta`
      * Enable and add some description.
    * `vault auth enable -path=anypathTwo -description=DescriptionToAdd okta`
      * Enable okta in a custom path, adding a description 
  * `vault auth disable okta`
    * Disable okta auth method
  * `vault auth tune -default-lease-ttl=24h anypath`
    * Modify some property of the auth method
    * Problem:
      * Problem1: "Error tuning auth method"
  * `vault auth enable approle`
    * Enable approle auth method
  * `vault auth enable -path=local userpass`
    * Enable approle auth method

* KV
  * `vault kv get Key`
    * Retrieve K/V secrets engine for Key
  * `vault kv list Path`
    * List all the K/V secrets under the Path
  * `vault kv put Path Key=Value`
    * Update an KV's entry
    
* List
  * `vault list auth/approle/role`
    * List the existing roles under approle
  * `vault list auth/userpass/users`
    * List the existing users under userpass
  * `vault list auth/token/accessors`
    * List all the accessors --> number of existing tokens

* Login
  * `vault login -method=userpass username=alfredo`
    * Login via userpass with alfredo user

* Operator
  * Group subcommands for operators interacting with Vault
  * `vault operator raft subcommands`
    * Groups subcommands for operators to manage the Integrated Storage Raft backend
    * `vault operator raft list-peers`
      * List set of unsealed peers in the Raft cluster
    * `vault operator raft join LeaderVaultNodeApiAddr`
      * Run in a Vault node to join ass peer of the Raft cluster
        * It also initializes the Vault node
  * `vault operator unseal`
    * Unseal a Vault server, providing unseal keys
  * `vault operator step-down`
    * Step down an active Vault node within an HA cluster, to pass to standBy and leaving to be leader Vault node.
  * `vault operator generate-root`
    * Create a root Token, based on unseal/recovery keys
    * `vault operator generate-root -init`
      * Initialize the process to create a root token
    * `vault operator generate-root -otp=OTPValueGot -decode=EncryptedRootToken`
      * Decrypt the encrypted root token

* Policy
  * `vault policy list`
  * `vault policy read kv-policy`
    * Read kv-policy
      * If the user whom we have logged, hasn't got permissions for some path --> get 403
  * `vault policy fmt PolicyFile`
    * Format the policy
  * `vault policy write PolicyNameToGive PolicyFile`
    * Create/Update a Vault policy

* Read
  * `vault read auth/approle/role/alfredo/role-id`
    * Read alfredo role's role-id
  * `vault read auth/okta/config`
    * Read okta configuration
  * `vault read auth/userpass/users/alfredo`
    * Read the alfredo user

* Secrets
  * `vault secrets enable aws`
    * Enable AWS secrets engine
  * `vault secrets list`
    * List the enabled secrets engines. 
      * If it's executed in Raft Cluster without enough quorum --> it will not work 

* Server
  * `vault server -dev`
    * Run Vault in dev mode. Not valid for production purposes
    * `vault server -dev &`
      * & to run in background

* Token
  * `vault token create`
    * Create a new root token, from another one
  * `vault token create -policy='kv-policy'`
    * Create a token, attaching a policy and the default policy
  * `vault token create -policy='kv-policy' -period=24h`
    * Create a periodic token, attaching a policy and the default policy
      * Periodic, because max_ttl isn't specified
  * `vault token create -policy='kv-policy' -ttl=60m`
    * Create a token, attaching a policy and the default policy, and specifying ttl
  * `vault token create -policy='kv-policy' -use-limit=2`
    * Create a token use limits, attaching a policy and the default policy
  * `vault token create -policy='kv-policy' -orphan`
    * Create a orphan token, attaching a policy and the default policy
  * `vault token lookup -accessor TokenAccessor`
    * Check token's properties
  * `vault token revoke RootTokenGenerated`
    * Revoke the token
  * `vault token revoke -accessor TokenAccessor`
    * Revoke the token
  * `vault token create -policy=PolicyToAssign -use-limit=1`
    * Create a token, assign a policy, limiting its use to 1 time
  * `vault token lookup TokenValue`
    * Display information about the token

* Write
  * `vault write auth/userpass/users/alfredo password=toledano policies=kv-policy`
    * Attach a policy to a user based on userpass auth method
  * `vault write auth/userpass/users/alfredo password=toledano token_ttl=8h token_max_ttl=24h policies=kv-policy`
    * Same as previously, but also adjusting token_ttl and token_max_ttl properties
  * `vault write identity/entity name="Alfredo Toledano" policies=kv-policy`
    * Create an entity, attaching a policy
  * `vault write identity/entity-alias name="Alfredo" canonical_id="c79593bd-062c-5fe3-ad95-a0f6630d957b" mount_accessor="auth_userpass_9160f822"`
    * Attach an alias to the entity. 
      * "name" is the name of the userpass
      * "canonical_id" is the id get, creating the entity
      * "mount_accessor" is the userpass' accessor
  * `vault write auth/approle/role/alfredo policies=alfredoPolicy token_ttl=20m`
    * Create a role which will have certain policy.
      * "alfredo" is the name of the role.
      * "alfredoPolicy" is the name of the policy.
  * `vault write auth/approle/role/engineering token_ttl=24h token_max_ttl=300h`
    * Update the role engineering with certain attributes
  * `vault write -force auth/approle/role/alfredo/secret-id`
    * Generate a secret-id for the alfredo role
  * `vault write auth/approle/login role_id=RoleIdPreviouslyGenerated secret_id=SecretIdPreviouslyGenerated` 
    * Login in Vault, using role_id (with _, different to - for generating) and secret_id (with _, different to - for generating)
  * `vault write auth/approle/login role_id=RoleIdPreviouslyGenerated secret_id=SecretIdPreviouslyGenerated | jq -r '.auth.client_token' > PathInWhichToStore`
    * Login as previously and formatting to json and writing in a file, the .auth.client_token response
  * `vault write auth/okta/config base_url="okta.com" org_name="guaperas" api_token="OktaTokenCreated"`
    * Configure okta authentication.
      * "base_url" is normally okta.com
      * "org_name" is different for each organization, and it's displayed in your okta account
  * `vault write auth/okta/users/YourAccountRelatedToOkta policies=alfredoOktaPolicy`
    * Create alfredo user related to the okta auth with the policy alfredoOktaPolicy
