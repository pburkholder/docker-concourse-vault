

echo:
	echo "Whoops"

./keys/worker:
	mkdir -p keys/web keys/worker
	ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''
	ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''
	ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''
	cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
	cp ./keys/web/tsa_host_key.pub ./keys/worker

external:
	$f=$(echo 
	@echo export CONCOURSE_EXTERNAL_URL=${DOCKER_HOST}:8080

vault: ./keys/vault/server.crt ./keys/vault/vault.hcl

./keys/vault/server.crt:
	mkdir -p keys/vault
	openssl req -newkey rsa:4096 -nodes -sha256 -keyout ./keys/vault/server.key -x509 -days 365 -out ./keys/vault/server.crt

define HCL
listener "tcp" {
	address = "0.0.0.0:8200"
	tls_cert_file = "/vault/config/server.crt"
	tls_key_file = "/vault/confg/server.key"
}
endef 
export HCL

./keys/vault/vault.hcl:
	echo "$$HCL" > $@

