# https://developer.hashicorp.com/vault/docs/configuration#storage
# https://developer.hashicorp.com/vault/docs/configuration/storage/consul
storage "consul" {
  # Machine with it's port in which by default Consul runs
  address = "127.0.0.1:8500"
  # Path in Consul's node to store the data
  path    = "vault/"
  # Consul ACL token
  token   = "1a2b3c4d-1234-abdc-1234-1a2b3c4d5e6a"
}
listener "tcp" {
 address = "0.0.0.0:8200"
 cluster_address = "0.0.0.0:8201"
 tls_disable = 0
 tls_cert_file = "/etc/vault.d/client.pem"
 tls_key_file = "/etc/vault.d/cert.key"
 tls_disable_client_certs = "true"
}
# https://developer.hashicorp.com/vault/docs/configuration#seal
# https://developer.hashicorp.com/vault/docs/configuration/seal/awskms
seal "awskms" {
  region = "us-east-1"
  # https://developer.hashicorp.com/vault/docs/configuration/seal/awskms#kms_key_id
  # If Vault lives in the same account that KMS key created --> Just necessary the key
  # else --> All whole ARN
  kms_key_id = "12345678-abcd-1234-abcd-123456789101",
  endpoint = "example.kms.us-east-1.vpce.amazonaws.com"
}

# It's like the primary API address  https://developer.hashicorp.com/vault/docs/configuration#api_addr
api_addr = "https://vault-us-east-1.example.com:8200"
cluster_addr = " https://node-a-us-east-1.example.com:8201"
cluster_name = "vault-prod-us-east-1"
ui = false
log_level = "INFO"
license_path = "/opt/vault/vault.hcl"
disable_mlock=true