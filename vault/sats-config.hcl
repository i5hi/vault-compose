storage "raft" {
  path    = "/vault/raft"
  node_id = "vnode1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

api_addr = "http://0.0.0.0:8200"
cluster_addr = "https://0.0.0.0:8201"
ui = true
disable_mlock = true
