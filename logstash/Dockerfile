FROM fedora:21

MAINTAINER Felix Massem <felix.massem@codecentric.de>, Olaf Goerlitz <olaf.goerlitz@gmail.com>

# Install Java + certtool
RUN yum -y -q update
RUN yum -y -q install jre
RUN yum -y -q install gnutls-utils

# -----------------------------------------------------------------------------
# Install Logstash 

ADD logstash.repo /etc/yum.repos.d/
RUN \
  rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
  yum install -y -q logstash

# -----------------------------------------------------------------------------
# Create TLS certificates for log forwarding

ADD tls /
RUN /create_certs.sh

# -----------------------------------------------------------------------------
# Expecting logstash configuration in a mounted data volume (/conf/logstash.conf).
# This allows for restarting the logstash container with an updated configuration.

CMD [ "/opt/logstash/bin/logstash", "agent", "-f", "/conf/logstash.conf" ]

# Expose TLS-secured port
EXPOSE 5000
