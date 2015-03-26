FROM fedora:21

MAINTAINER Felix Massem <felix.massem@codecentric.de>, Olaf Goerlitz <olaf.goerlitz@gmail.com>

# install java, wget, tar
RUN \
  yum -y -q update && \
  yum -y -q install \
    jre \
    gnutls-utils

# ---------------------------------------------------------
# Install Logstash
# (cf. http://www.logstash.net/docs/1.4.2/repositories)

ADD logstash.repo /etc/yum.repos.d/
RUN \
  rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch && \
  yum install -y -q logstash

# ---------------------------------------------------------
# Create TLS certificates for log forwarding
# (cf. https://help.ubuntu.com/community/GnuTLS)

ADD tls /

# create certificates (act as CA authority)
RUN /create_certs.sh


# SSLv3 has been disabled in Java since January 2015 due to the POODLE vulnerability.
# However, NXlog does not support TLS 1.x (yet). Hence, re-enabled SSLv3 assuming that logstash runs in a secure environment.
# http://www.oracle.com/technetwork/java/javase/7u75-relnotes-2389086.html
RUN sed -i 's/jdk.tls.disabledAlgorithms/#jdk.tls.disabledAlgorithms/' /usr/lib/jvm/java-*/jre/lib/security/java.security

# ---------------------------------------------------------

ENV CFG_DIR /opt/conf/logstash
ENV LOG_DIR /var/logstash/logs

# create volumes for the configuration folder (which allows for updating logstash.conf)
# and restarting the container) and for the watched log folder
VOLUME [ "$CFG_DIR", "$LOG_DIR" ]


CMD [ "/opt/logstash/bin/logstash", "agent", "-f", "/opt/conf/logstash/logstash.conf" ]

EXPOSE 5000
