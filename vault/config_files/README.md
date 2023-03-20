# Content
* "vault.hcl"
  * Vault configuration file -- [Link](https://developer.hashicorp.com/vault/docs/configuration) --
  * External Storage Backend such as Consul
* "vault_int_storage.hcl"
  * Integrated Storage Backend / Raft 


## How to run it?
* Create a 'vault.service'
  * `cd /etc/systemd/system`  /   `cd /lib/systemd/system`
    * Navigate to this path in which to place 'vault.service'
* Create the Vault configuration file
* `sudo systemctl start vault`
  * Run the vault service
* `systemctl status vault`
  * Check that Vault is running


## Notes:
* 'consul-client.json'
  * Sample configuration for the consul client, running locally in the Vault node
* 'consul-node.json'
  * Sample configuration for the consul node
* vault operator raft join https://LeaderNodePath:8200
  * manually join to the raft Vault cluster