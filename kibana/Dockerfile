FROM fedora:21

MAINTAINER Felix Massem <felix.massem@codecentric.de>, Olaf Goerlitz <olaf.goerlitz@gmail.com>

RUN \
  yum -y -q update && \
  yum -y -q install \
    wget \
    tar \
    nginx

ENV KIBANA_VERSION 3.1.2

# install kibana app in nginx
RUN \
  wget -q https://download.elasticsearch.org/kibana/kibana/kibana-$KIBANA_VERSION.tar.gz -O /tmp/kibana.tar.gz && \
  tar zxf /tmp/kibana.tar.gz --strip 1 -C /usr/share/nginx/html

# replace nginx configuration with custom settings
ADD config/nginx.conf /etc/nginx/nginx.conf

# set logstash dashboard as default
RUN mv /usr/share/nginx/html/app/dashboards/logstash.json /usr/share/nginx/html/app/dashboards/default.json

CMD ["nginx"]

EXPOSE 80
