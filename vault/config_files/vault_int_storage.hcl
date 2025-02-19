# https://developer.hashicorp.com/vault/docs/configuration/storage/raft
storage "raft" {
  # Local path, since we are using internal storage backend
  path    = "/opt/vault/data"
  # node_id is unique per node
  node_id = "node-a-us-east-1.example.com"
  retry_join {
    auto_join = "provider=aws region=us-east-1 tag_key=vault tag_value=us-east-1"
  }
}
# https://developer.hashicorp.com/vault/docs/configuration/listener
listener "tcp" {
 address = "0.0.0.0:8200"
 cluster_address = "0.0.0.0:8201"
 tls_disable = 0
 tls_cert_file = "/etc/vault.d/client.pem"
 tls_key_file = "/etc/vault.d/cert.key"
 tls_disable_client_certs = "true"
}
# https://developer.hashicorp.com/vault/docs/configuration/seal
seal "awskms" {
  region = "us-east-1"
  kms_key_id = "12345678-abcd-1234-abcd-123456789101",
  endpoint = "example.kms.us-east-1.vpce.amazonaws.com"
}
# https://developer.hashicorp.com/vault/docs/configuration#high-availability-parameters
# HA parameters
api_addr = "https://vault-us-east-1.example.com:8200"
cluster_addr = " https://node-a-us-east-1.example.com:8201"
cluster_name = "vault-prod-us-east-1"
ui = true
log_level = "INFO"
license_path = "/opt/vault/vault.hcl"
disable_mlock=true
