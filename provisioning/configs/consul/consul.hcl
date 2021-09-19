datacenter = "cwdc-os-1"
data_dir = "/opt/consul"
encrypt = "{{ consul_key.stdout }}"
verify_incoming = false
verify_outgoing = false
verify_server_hostname = false
retry_join = ["{{ ip.stdout }}"]
ui = true
