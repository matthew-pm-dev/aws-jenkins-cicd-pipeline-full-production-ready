#!/bin/bash
set -e

#!/bin/bash
FLAG=/var/jenkins_home/init-done.flag
if [ ! -f "$FLAG" ]; then
    /usr/local/bin/init-scripts/fix-docker-group.sh
    /usr/local/bin/init-scripts/install-build-tools.sh
    touch "$FLAG"
    echo "All init scripts complete"
fi
