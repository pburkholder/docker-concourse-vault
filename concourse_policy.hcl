path "sys/*" {
  policy = "deny"
}

path "secret/concourse/*" {
  policy = "read"
}