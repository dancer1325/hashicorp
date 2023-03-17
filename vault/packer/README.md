Build AMI in AWS with Vault (downloaded locally)via Packer.

## How to deploy safely?
* `packer validate vault.pkr.hcl`
  * Check https://developer.hashicorp.com/packer/docs/commands/validate
* `packer build vault.pkr.hcl`
  * Check https://developer.hashicorp.com/packer/docs/commands/build
  *  Create all in AWS
* Go to your AWS console and launch it
* Once it's launched, connect to that EC2 machine (putty or however)
* Once you are in the terminal
  * `cd /tmp`
    * Navigate to the path in which Vault has been placed
  * `sudo unzip vault.zip`
    * Unzip vault file
  * `sudo mv vault /usr/local/bin`
    * Move unzipped vault to another path
  * `cd /usr/local/bin`
    * Navigate to that path
  * ``