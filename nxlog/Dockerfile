FROM centos:centos7

MAINTAINER Olaf Goerlitz <olaf.goerlitz@gmail.com>

# install wget
RUN \
  yum -y -q update && \
  yum -y -q install wget

# -----------------------------------------------------------------------------
# Install NXlog (cf. http://nxlog-ce.sourceforge.net/nxlog-docs/en/nxlog-reference-manual.html#quickstart_linux_rpm)

# Note: Log forwarding via TLS 1.x requires NXlog 2.9.1347 or greater.
ENV NXLOG_VERSION ce-2.9.1347-1_rhel7

RUN wget -q http://nxlog.co/system/files/products/files/1/nxlog-$NXLOG_VERSION.x86_64.rpm
RUN yum -y -q localinstall nxlog-$NXLOG_VERSION.x86_64.rpm

# add certificate to docker image (as needed in nxlog.conf)
ADD logstash-ca.crt /etc/ssl/certs/

# -----------------------------------------------------------------------------
# define mount points for externally provided configuration and log folder.
# this allows for restarting the container with an updated configuraton.

ENV CFG_DIR /conf
ENV LOG_DIR /logs

VOLUME [ "$CFG_DIR", "$LOG_DIR" ]

# write IP address of linked logstash container into nxlog.conf and start nxlog in foreground
CMD perl -pe "s/localhost/$LOGSTASH_PORT_5000_TCP_ADDR/" `echo ${CFG_DIR}/nxlog.conf` >/etc/nxlog.conf && /usr/bin/nxlog -f

