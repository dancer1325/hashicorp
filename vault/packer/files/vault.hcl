# https://developer.hashicorp.com/vault/docs/configuration/storage/raft
storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-a-us-east-1.example.com"
  retry_join {
    auto_join = "provider=aws region=us-east-1 tag_key=vault tag_value=us-east-1"
  }
}
# https://developer.hashicorp.com/vault/docs/configuration/listener
listener "tcp" {
 # 0.0.0.0        Used by the host as it's own source address    https://en.wikipedia.org/wiki/0.0.0.0
 address = "0.0.0.0:8200"
 cluster_address = "0.0.0.0:8201"
 # TLS is disabled for demo purposes
 tls_disable = 1
}
# https://developer.hashicorp.com/vault/docs/configuration/seal
seal "awskms" {
  region = "us-east-1"
  kms_key_id = "12345678-abcd-1234-abcd-123456789101",
  endpoint = "example.kms.us-east-1.vpce.amazonaws.com"
}
api_addr = "https://vault-us-east-1.example.com:8200"
cluster_addr = " https://node-a-us-east-1.example.com:8201"
cluster_name = "vault-prod-us-east-1"
ui = true
log_level = "INFO"
