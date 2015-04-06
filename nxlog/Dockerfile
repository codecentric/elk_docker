FROM centos:centos7

MAINTAINER Olaf Goerlitz <olaf.goerlitz@gmail.com>

RUN \
  yum -y -q update && \
  yum -y -q install wget

# -----------------------------------------------------------------------------
# Install NXlog (cf. http://nxlog-ce.sourceforge.net/nxlog-docs/en/nxlog-reference-manual.html#quickstart_linux_rpm)
# Note: Log forwarding via TLS 1.x requires NXlog 2.9.1347 or later.

ENV NXLOG_VERSION ce-2.9.1347-1_rhel7

RUN wget -q http://nxlog.co/system/files/products/files/1/nxlog-$NXLOG_VERSION.x86_64.rpm
RUN yum -y -q localinstall nxlog-$NXLOG_VERSION.x86_64.rpm

# add logstash's certificate to docker image (required to setup TLS connection)
ADD logstash-ca.crt /etc/ssl/certs/

# -----------------------------------------------------------------------------
# Expecting NXlog configuration in a mounted data volume (/conf/nxlog.conf).
# This allows for restarting the NXlog container with an updated configuration.

# set IP address of linked 'logstash' container, overwrite default nxlog.conf, and start nxlog in foreground
CMD perl -pe "s/localhost/$LOGSTASH_PORT_5000_TCP_ADDR/" /conf/nxlog.conf >/etc/nxlog.conf && /usr/bin/nxlog -f

