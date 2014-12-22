FROM fedora:latest
MAINTAINER Felix Massem <felix.massem@codecentric.de> 19.12.2014 16:26

ENV ES_PKG_NAME elasticsearch-1.3.4
RUN ["yum", "install", "-y", "/usr/bin/which"]
RUN ["yum", "install", "-y", "wget", "/usr/bin/which"]
RUN ["yum", "install", "-y", "jre >= 1.6.0", "/usr/bin/which"]

# Install ElasticSearch.
RUN \
cd / && \
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
tar xvzf $ES_PKG_NAME.tar.gz && \
rm -f $ES_PKG_NAME.tar.gz && \
mv /$ES_PKG_NAME /elasticsearch
# Define mountable directories.
VOLUME ["/data"]
# Mount elasticsearch.yml config
RUN /elasticsearch/bin/plugin -i elasticsearch/marvel/latest
RUN /elasticsearch/bin/plugin -i mobz/elasticsearch-head
ADD config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
# Define default command.
ADD run.sh /usr/local/bin/run.sh
RUN chmod -R 755 /usr/local/bin/run.sh
CMD ["/usr/local/bin/run.sh"]
# Expose ports.
# - 9200: HTTP
# - 9300: transport
EXPOSE 9200
EXPOSE 9300
