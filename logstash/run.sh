#!/bin/bash

exec /opt/logstash/bin/logstash agent --debug --verbose -f /etc/logstash/conf.d/logstash.conf
exec "$@"
