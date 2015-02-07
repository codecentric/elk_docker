# -*- mode: ruby -*-
# vi: set ft=ruby :

# Using Vagrant API version 2 configuration
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  # forward ports for elasticsearch and kibana (use 8080 instead of 80)
  config.vm.network "forwarded_port", guest: 80,   host: 8080
  config.vm.network "forwarded_port", guest: 9200, host: 9200

  # define VM configuration
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "docker" do |docker|

    # build images (automatically shared via '/vagrant' folder)
    docker.build_image "/vagrant/elasticsearch", args: "--tag elasticsearch"
    docker.build_image "/vagrant/logstash",      args: "--tag logstash"
    docker.build_image "/vagrant/kibana",        args: "--tag kibana"

    # start containers
    docker.run "elasticsearch", args: "-p 9200:9200 -p 9300:9300"
    docker.run "logstash",      args: "--link elasticsearch:elasticsearch"
    docker.run "kibana",        args: "-p 80:80"
  end

end
