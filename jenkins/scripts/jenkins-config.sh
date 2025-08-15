#!/bin/bash
set -e

/usr/local/bin/init-scripts/fix-docker-group.sh
/usr/local/bin/init-scripts/install-build-tools.sh

echo "All init scripts complete"