#!/bin/sh 
# simply returns the password from docker secrets to standard out
# can be used with ANSIBLE_VAULT_PASSWORD_FILE environment variable
# note must be saved in git with execute permissions see https://adamj.eu/tech/2023/01/31/git-add-remove-execute-permissions/
# git add --chmod +x vault-password-client.sh

cat /run/secrets/VAULT_PASSWORD_FILE