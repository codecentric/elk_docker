FROM centos:centos7

MAINTAINER Felix Massem <felix.massem@codecentric.de>, Olaf Goerlitz <olaf.goerlitz@gmail.com>

RUN \
  yum -y -q update && \
  yum -y -q install wget

# -----------------------------------------------------------------------------
# Install NXlog (cf. http://nxlog-ce.sourceforge.net/nxlog-docs/en/nxlog-reference-manual.html#quickstart_linux_rpm)
# Note: Log forwarding via TLS 1.x requires NXlog 2.9.1347 or later.

ENV NXLOG_VERSION ce-2.9.1347-1_rhel7

RUN wget -q http://nxlog.co/system/files/products/files/1/nxlog-$NXLOG_VERSION.x86_64.rpm
RUN yum -y -q localinstall nxlog-$NXLOG_VERSION.x86_64.rpm

# Add logstash's certificate to docker image (required in configuration of TLS connection)
ADD logstash-ca.crt /etc/ssl/certs/

# -----------------------------------------------------------------------------
# Expecting NXlog configuration in a mounted data volume (/conf/nxlog.conf).
# This allows for restarting the NXlog container with an updated configuration.

# Start NXlog in foreground using the provided configuration.
CMD [ "/usr/bin/nxlog", "-f", "-c", "/conf/nxlog.conf" ]

