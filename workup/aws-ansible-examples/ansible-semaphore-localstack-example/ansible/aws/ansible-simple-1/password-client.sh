#!/bin/sh 
# simply returns the password from docker secrets

cat /run/secrets/VAULT_PASSWORD_FILE