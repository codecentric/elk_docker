FROM fedora:21

MAINTAINER Felix Massem <felix.massem@codecentric.de>, Olaf Goerlitz <olaf.goerlitz@gmail.com>

# Install wget + tar
RUN yum -y -q update
RUN yum -y -q install \
  wget \
  tar

ENV KIBANA_VERSION 4.2.0-linux-x64

# Install Kibana
RUN \
  wget -q https://download.elastic.co/kibana/kibana/kibana-$KIBANA_VERSION.tar.gz -O kibana.tar.gz && \
  mkdir kibana && \
  tar zxf kibana.tar.gz --owner=root --group=root --strip 1 -C /kibana

# Set elasticsearch container hostname in kibana configuration
#RUN sed -i "s/localhost:/elasticsearch:/" /kibana/config/kibana.yml
RUN sed -i '$ a\
elasticsearch.url: "http://172.17.0.1:9200"' /kibana/config/kibana.yml

CMD [ "/kibana/bin/kibana" ]

EXPOSE 5601
