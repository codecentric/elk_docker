elk_docker
==========

ELK (Elasticsearch, Logstash, Kibana) as Docker Container

First of all build images from all the Dockerfiles. Therefore change dir into the subfolders and run
```
  *#/cd elasticsearch
  *#/sudo docker build -t elasticsearch .
  *#/cd ../logstash
  *#/sudo docker build -t logstash .
  *#/cd ../kibana
  *#/sudo docker build -t kibana .
```
Then start a container for elasticsearch
```
  *#/sudo docker run --name elasticsearch -d -p=9300:9300 -p=9200:9200 elasticsearch
  *#/sudo docker logs elasticsearch
  *#/sudo docker inspect elasticsearch
```

Start a container for logstash and link it to elasticsearch
```
  *#/sudo docker run --name logstash --link elasticsearch:elasticsearch -d -t logstash
  *#/sudo docker logs logstash
  *#/sudo docker inspect logstash
```
Start a container for Kibana link it to elasticsearch
```
  *#/sudo docker run --name kibana -d -p=80:80 kibana
  *#/sudo docker logs kibana
  *#/sudo docker inspect kibana
```
With the last command you can find out which ip the container is using. Enter it into your browser.
For testing start an container for logging:
```
  *#/sudo docker run --name logger --link elasticsearch:elasticsearch -t -i adaman79/logstash /bin/bash
```
Inside the container start logstash as follows:
```
  *#/cd opt/logstash/bin
  *#/./logstash agent -f /etc/logstash/conf.d/logstash.conf
```

Enter something like "Hello World"
Refresh you timespan at the kibana dashboard and see the log

Steps to go on with:
 - Use a volume where you are logging to and use the logstash container to read from this volume
