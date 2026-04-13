#!/bin/sh 
# see https://phoenixtrap.com/2025/12/22/10-lines-to-better-docker-compose-secrets/
# exports compose secrets as environment variables when container starts up
set -eu

for secret_file in /run/secrets/*; do 
   [ -e "$secret_file" ] || continue 
   if [ -f "$secret_file" ]; then 
      name=$(basename "$secret_file") 
      export "$name=$(cat "$secret_file")" 
      echo "$name=$(cat "$secret_file")" 
   fi 
done 

exec "$@"
