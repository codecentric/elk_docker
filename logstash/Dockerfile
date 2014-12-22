FROM fedora:latest
MAINTAINER Felix Massem <felix.massem@codecentric.de> 08.12.2014 14:58

RUN ["rpm", "--import", "http://packages.elasticsearch.org/GPG-KEY-elasticsearch"]
COPY logstash.repo /etc/yum.repos.d/
RUN ["yum", "install", "-y", "/usr/bin/which"]
RUN ["yum", "install", "-y", "jre >= 1.6.0", "/usr/bin/which"]
RUN ["yum", "install", "-y", "logstash"]
VOLUME ["/opt/conf"]
ADD start_logstash.sh /usr/local/bin/start_logstash.sh
RUN chmod -R 755 /usr/local/bin/start_logstash.sh
USER logstash
ADD config/logstash.conf /etc/logstash/conf.d/logstash.conf

# Start logstash
USER root
CMD /usr/local/bin/run.sh
# Kibana
EXPOSE 9292
