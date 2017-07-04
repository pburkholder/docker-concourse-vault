# Explore/Demo Concourse + Hashicorp Vault

My choice of environment for playing with this is 
docker-machine on OsX with `docker-compose`


**Set up vault and a secret**

```
make vault
docker-compose up vault
export VAULT_ADDR=https://192.168.99.101:8200/
export VAULT_SKIP_VERIFY=true
vault init -check
vault init -key-shares=1 -key-threshold=1
vault unseal unsealkey
vault auth roottoken
vault write secret/concourse from-vault="a value from vault" 
```

**Set up AppRole**

see https://www.vaultproject.io/docs/auth/approle.html. These TTLs below are all way too high:

```
vault auth-enable approle
vault write auth/approle/role/concourse_role secret_id_ttl=60m token_num_uses=60 token_ttl=120m token_max_ttl=300m secret_id_num_uses=400

# Get the roleid ...
vault read auth/approle/role/concourse_role/role-id

# ... and secret-id (-f force continue w/o any data values specified)
vault write -f auth/approle/role/concourse_role/secret-id

# get tokens
vault write auth/approle/login role_id=12ff1a28-445f-9fc2-d453-959b43adbddc secret_id=a9d2fc5d-36fc-4035-94dd-6686a3cc442b