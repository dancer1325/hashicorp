* Auth
  * `vault auth list`
    * List all the enabled Auth Methods

* Login
  * userpass
    * `vault login -method=userpass username=alfredo`

* Policy
  * `vault policy list`
  * `vault policy read kv-policy`
    * Read kv-policy
      * If the user whom we have logged, hasn't got permissions for some path --> get 403

* Write
  * `vault write auth/userpass/users/alfredo password=toledano policies=kv-policy`
    * Attach a policy to a user based on userpass auth method
  * `vault write identity/entity name="Alfredo Toledano" policies=kv-policy`
    * Create an entity, attaching a policy
  * `vault write identity/entity-alias name="Alfredo" canonical_id="c79593bd-062c-5fe3-ad95-a0f6630d957b" mount_accessor="auth_userpass_9160f822"`
    * Attach an alias to the entity. 
      * "name" is the name of the userpass
      * "canonical_id" is the id get, creating the entity
      * "mount_accessor" is the userpass' accessor