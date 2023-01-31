vault write database/config/postgres \
     plugin_name=postgresql-database-plugin \
     connection_url="postgresql://{{username}}:{{password}}@psql-postgresql.postgres:5432/postgres?sslmode=disable" \
     allowed_roles="*" \
     username="postgres" \
     password="password"


vault write database/config/postgres \
     plugin_name=postgresql-database-plugin \
     connection_url="postgresql://{{username}}:{{password}}@psql-postgresql.postgres:5432/postgres?sslmode=disable" \
     allowed_roles="*" \
     username="postgres" \
     password="password"


vault write database/roles/db-app \
    db_name=postgres \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
    revocation_statements="ALTER ROLE \"{{name}}\" NOLOGIN;"\
    default_ttl="5s" \
    max_ttl="10s"


vault policy write db-app-policy -<<EOF
path "database/creds/db-app" {
  capabilities = ["read"]
}
EOF

vault write auth/kubernetes/role/db-app-role \
    bound_service_account_names=db-app \
    bound_service_account_namespaces=app \
    policies=db-app-policy \
    ttl=1h