FROM fedora:latest
MAINTAINER Felix Massem <felix.massem@codecentric.de> 08.12.2014 14:58

RUN yum install -y nginx wget
RUN wget https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz -O /tmp/kibana.tar.gz && \
    tar zxf /tmp/kibana.tar.gz && mv kibana-3.1.0/* /usr/share/nginx/html
ADD run.sh /usr/local/bin/run.sh
ADD config/nginx.conf /etc/nginx/nginx.conf
RUN chmod -R 755 /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]
EXPOSE 80
