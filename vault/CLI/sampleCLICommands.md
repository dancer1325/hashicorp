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
  * `vault kv get Path`
    * Retrieve K/V secrets engine for Key
    * `vault kv get -format=json Path`
      * Retrieve K/V secrets in json format
    * `vault kv get -format=json Path | jq -r ".data.Key1"`
      * Retrieve K/V secrets in json format, and just filter by .data.Key1
    * `vault kv get -version=ValueToRetrieve Path`
      * Retrieve K/V secrets under a Path, specifying the version
  * `vault kv list Path`
    * List all the K/V secrets under the Path
    * If Path isn't the final Path with the secrets --> it displays all the sub paths
  * `vault kv put Path Key=Value`
    * Update/Create all entries in the Path
    * `vault kv put Path Key1=Value1 Key2=Value2`
      * Several entries can be passed
  * `vault kv enable-versioning Path`
    * Upgrade from KV v1 to KV v2
  * `vault kv rollback -version=VersionToRollback Path`
    * Rollback to a specific version
  * `vault kv patch Path Key=ValueToUpdate`
    * Update just that Key, without deleting the rest of entries
  * `vault kv delete Path`
    * Delete the secret.
      * If you use KV v1 ⟶ You can return it from the backend system
      * If you use KV v2 ⟶ You can return metadata (!=data). But data can be returned via undelete / rollback
  * `vault kv undelete -versions=SpecifyVersionsToUndelete Path`
    * Undelete secrets. It's "versionS", because you can undelete several
  * `vault kv destroy Path`
    * Destroy / Delete data (!=metadata) forever
    * `vault kv destroy -versions=SpecifyVersionsToDestroy Path`
      * Specify versions to destroy
  * `vault kv metadata delete Path`
    * Delete even the metadata
  * `vault kv metadata get Path`
    * Retrieve all the metadata
  * `vault kv metadata put metadataToCustomize=Key=Value Path`
    * Update custom metadata


* Lease
  * `vault lease revoke SecretEngine/creds/VaultRole`
    * Revoke a created dynamic credentials
    * `vault lease revoke -prefix SecretEngine/creds/VaultRole`
      * Revoke several dynamic credentials at the same time, with certain prefix


* List
  * `vault list auth/approle/role`
    * List the existing roles under approle
  * `vault list auth/userpass/users`
    * List the existing users under userpass
  * `vault list auth/token/accessors`
    * List all the accessors --> number of existing tokens
  * `vault list auth/token/accessors`
    * List all the existing Token accessors
  * `vault list transitOrPathInWhichIsEnabled/keys`
    * List all the existing Transit's keys

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
  * `vault read transitOrPathInWhichIsEnabled/keys/NameOfTheEncriptionKey`
    * Read encryption key information

* Read
  * `vault read auth/approle/role/alfredo/role-id`
    * Read alfredo role's role-id
  * `vault read auth/okta/config`
    * Read okta configuration
  * `vault read auth/userpass/users/alfredo`
    * Read the alfredo user
  * `vault read SecretEngine/creds/VaultRole`
    * Generate dynamic credentials to the Secret Engine
    * `vault read aws/creds/VaultRoleName`
    * `vault read database/creds/VaultRoleName`
  * `vault read database/config/DatabaseNameGiven`
    * Read DDBB's configuration
  * `vault read totp/code/aws`
    * Read TOTP's code

* Secrets
  * `vault secrets enable aws`
    * Enable AWS secrets engine at the default path
    * `vault secrets enable aws -path=PathInWhichSecretsEngineIsAccesible aws`
      * Enable AWS secrets engine in a specific path
    * `vault secrets enable -description="Add description about the secrets engine" aws`
      * Enable it, adding some description
  * `vault secrets enable transit`
    * Enable Transit secrets engine at the default path
  * `vault secrets enable kv`
    * Enable KV version 1
  * `vault secrets enable -version=2 kv` / `vault secrets enable kv-v2`
    * Enable KV version 2
  * `vault secrets enable database`
    * Enable Database Secrets Engine
  * `vault secrets list`
    * List the enabled secrets engines. 
      * If it's executed in Raft Cluster without enough quorum --> it will not work
    * `vault secrets list -detailed`
      * Give additional information
  * `vault secrets tune -default-lease-ttl=72h pki`
    * Modify some property of the secrets engine

* Server
  * `vault server -dev`
    * Run Vault in dev mode. Not valid for production purposes
    * `vault server -dev &`
      * & to run in background

* Token
  * `vault token create`
    * Create a new root token, from another one
  * `vault token create -type=batch`
    * Create a batch token (By default a service token would be created)
  * `vault token create -policy='kv-policy'`
    * Create a token, attaching a policy and the default policy
  * `vault token create -policy='kv-policy' -period=24h`
    * Create a periodic token, attaching a policy and the default policy
      * Periodic, because max_ttl isn't specified
  * `vault token create -policy='kv-policy' -ttl=60m -explicit-max-ttl=24h`
    * Create a token, attaching a policy and the default policy, and specifying ttl and max_ttl
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
  * `vault write aws/config/root access_key=Value secret_key=Value region=RegionValue`
    * Give access to Vault to AWS
  * `vault write -f aws/config/rotate-root`
    * Rotate the credentials used by Vault to communicate with AWS
  * `vault write aws/roles/NameOfTheVaultRoleToCreate someAWSResourceToAuthenticate=Value credential_type=SpecifyWhichOneToUse`
    * Generate dynamic credentials to access to AWS 
    * `vault write aws/roles/NameOfTheVaultRoleToCreate policy_arns=PolicyARNSValueToPass credential_type=iam_user`
      * Create a new IAM user, to give access to
    * `vault write aws/roles/NameOfTheVaultRoleToCreate roles_arns=RolesARNSValueToPass credential_type=assumed_role`
      * Call to sts:AssumeRole, returning some keys to get access
  * `vault write aws/sts/VaultRoleCreated ttl=Value`
    * Get dynamic credentials if you have authenticated via assumed_role
  * `vault write database/config/DatabaseNameGiven plugin_name=NamePlugin connection_url=DDBBPort allowed_roles=Roles username=UserName password=Password`
    * Give access to Vault to a database
    * `vault write database/config/DatabaseNameGiven plugin_name=mysql-rds-database-plugin connection_url=DDBBPort allowed_roles=Roles username=UserName password=Password`
      * Give access to Vault to RDS
  * `vault write database/roles/NameOfTheVaultRoleToCreate db_name=DatabaseNameGiven creation_statements="SQLToRun"`
    * Create a role with certain permissions to interact with the DDBB
    * `vault write database/roles/hcvop-role db_name=mysql01 default_ttl=1h max_ttl=4h creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON hcvop.* TO '{{name}}'@'%';"
      Success! Data written to: database/roles/hcvop-role`
      * Example of role creation
  * `vault write -f database/rotate-root/DatabaseNameGiven`
    * Rotate credentials used previously to connect
  * `vault write -f transitOrPathInWhichIsEnabled/keys/NameOfTheEncriptionKey type=EncryptionKeyType`
    * Create an encryption key using Transit Secrets Engine, specifying the type
    * `vault write -f transitOrPathInWhichIsEnabled/keys/NameOfTheEncriptionKey/rotate`
      * Rotate the encryption key
  * `vault write transitOrPathInWhichIsEnabled/DesiredAction/NameOfTheEncriptionKey plainOrCiphertext=Value`
    * `vault write transitOrPathInWhichIsEnabled/encrypt/NameOfTheEncriptionKey plaintext=PlaintextDataEncryptedInBase64`
      * Encrypt data
      * `base64 <<< "SomethingToBeConvertedToBase64"`
        * Convert from string to Base64
    * `vault write transitOrPathInWhichIsEnabled/decrypt/NameOfTheEncriptionKey ciphertext=ValueIncludingAll`
      * Decrypt
      * `vault write transitOrPathInWhichIsEnabled/decrypt/NameOfTheEncriptionKey ciphertext="$(cat PathInWhichWasStoredAll | jq -r '.data.ciphertext')"`
      * `base64 -d SomethingInBase64`
        * Convert from Base64 to string 
    * `vault write transitOrPathInWhichIsEnabled/rewrap/NameOfTheEncriptionKey ciphertext=ValueIncludingAll`
      * Rewrap ciphertext with the new key version
  * `vault write transitOrPathInWhichIsEnabled/keys/NameOfTheEncriptionKey/config min_decryption_version=Value`
    * Specify the minimum key version in Transit Secrets Engine
  * Ways to format the output to json
    * `vault write ... -format=json`
    * `vault write ... | tee -a PathToStoreFormatedToJson`
    * `vault write ... | jq -r 'SpecificPropertyToStore' > PathInWhichToStore` 
  * `vault write -field=certificate pki/root/generate/internal common_name="example.com" issuer_name="root-2022" ttl=87600h > CertificateName.crt`
    * Generate a certificate and store it in a file
  * `vault write pki/config/urls issuing_certificates="$VAULT_ADDR/v1/pki/ca" crl_distribution_points="$VAULT_ADDR/v1/pki/crl"`
    * Configure CA and CRL URLs
  * `vault write totp/keys/aws url="UrlGenerated""`
    * Generate a TOTP key
      `
      
