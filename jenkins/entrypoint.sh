#!/bin/bash
set -e

# Read secrets into environment variables
export ADMIN_USERNAME=$(cat /run/secrets/admin_username)
export ADMIN_PASSWORD=$(cat /run/secrets/admin_password)

# Start Jenkins (main process)
exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
