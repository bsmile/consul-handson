#!/bin/bash

CONSUL_SV=$1

/bin/cp -rp /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.org
/bin/sed -i -e "s/nginx!/$HOSTNAME/g" /usr/share/nginx/html/index.html

/usr/sbin/service nginx start

/usr/local/bin/consul agent \
-node=$HOSTNAME \
-data-dir=/opt/consul/dat \
-config-file=/opt/consul/conf \
-ui-dir=/opt/consul/webui/dist \
-client="0.0.0.0" \
-join=$CONSUL_SV
