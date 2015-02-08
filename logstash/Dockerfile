FROM fedora:21

MAINTAINER Felix Massem <felix.massem@codecentric.de>, Olaf Goerlitz <olaf.goerlitz@gmail.com>

RUN \
  yum -y -q update && \
  yum -y -q install \
    wget \
    tar \
    jre >= 1.8.0

# install logstash, c.f. http://www.logstash.net/docs/1.4.2/repositories
ADD logstash.repo /etc/yum.repos.d/
RUN \
  rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch && \
  yum install -y -q logstash

# create volumes for the configuration folder (which allows for updating logstash.conf
# and restarting the container) and for the watched log folder
VOLUME [ "/opt/conf/logstash", "/var/logstash/logs" ]

CMD [ "/opt/logstash/bin/logstash", "agent", "-f", "/opt/conf/logstash/logstash.conf" ]
