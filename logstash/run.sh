#!/bin/bash
# #################################################################
# NAME: kibana.sh
# DESC: Kibana/nginx startup file.
# #################################################################

exec /opt/logstash/bin/logstash agent --debug --verbose -f /etc/logstash/conf.d/logstash.conf
exec "$@"
