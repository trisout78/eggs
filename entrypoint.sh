#!/bin/bash
sleep 1

cd /etc/nginx

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/etc/nginx$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}