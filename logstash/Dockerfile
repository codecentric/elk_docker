FROM fedora:21

MAINTAINER Felix Massem <felix.massem@codecentric.de>, Olaf Goerlitz <olaf.goerlitz@gmail.com>

# install java, certtool
RUN \
  yum -y -q update && \
  yum -y -q install \
    jre \
    gnutls-utils

# -----------------------------------------------------------------------------
# Install Logstash (cf. http://www.logstash.net/docs/1.4.2/repositories)

ADD logstash.repo /etc/yum.repos.d/
RUN \
  rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch && \
  yum install -y -q logstash

# -----------------------------------------------------------------------------
# Create TLS certificates for log forwarding

ADD tls /
RUN /create_certs.sh

# -----------------------------------------------------------------------------
# Expecting logstash configuration in a mounted data volume (/conf/logstash.conf).
# This allows for restarting the logstash container with an updated configuration.

CMD [ "/opt/logstash/bin/logstash", "agent", "-f", "/conf/logstash.conf" ]

EXPOSE 5000

