echo "******************************************************************************"

POSTGRES_POD=$(kubectl get pods -l app=postgres-stf -o jsonpath="{.items[0].metadata.name}")
echo "$POSTGRES_POD"

sleep 20

echo "Creating databases..."

kubectl exec -i "$POSTGRES_POD" -- psql -U postgres <<EOF
DO \$\$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'dev_auth_server') THEN
      CREATE DATABASE "dev_auth_server";
   END IF;
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'dev_integration') THEN
      CREATE DATABASE "dev_integration";
   END IF;
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'dev_sandbox') THEN
      CREATE DATABASE "dev_sandbox";
   END IF;
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'dev_form_registry') THEN
      CREATE DATABASE "dev_form_registry";
   END IF;
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'dev_record_server') THEN
      CREATE DATABASE "dev_record_server";
   END IF;
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'dev_email_server') THEN
      CREATE DATABASE "dev_email_server";
   END IF;
END
\$\$;
EOF


