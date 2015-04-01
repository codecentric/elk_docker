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
# define mount points for externally provided configuration and log folder
# this allows to restart the container with an updated logstash.conf file

ENV CFG_DIR /opt/conf/logstash
ENV LOG_DIR /var/logstash/logs

VOLUME [ "$CFG_DIR", "$LOG_DIR" ]

CMD /opt/logstash/bin/logstash agent -f `echo ${CFG_DIR}/logstash.conf`

EXPOSE 5000
