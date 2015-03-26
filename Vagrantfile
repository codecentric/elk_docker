# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  # define forwarded ports
  config.vm.network "forwarded_port", guest: 80,   host: 8080   # kibana dashboard (use port 8080 instead of 80)
  config.vm.network "forwarded_port", guest: 5000, host: 5000   # logstash log forwarding (TLS-protected port)
  config.vm.network "forwarded_port", guest: 9200, host: 9200   # elastisearch REST API

  # adjust VM configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name = "ELK Stack"
    vb.memory = 2048
    vb.cpus = 2
  end

  # build and run docker containers
  config.vm.provision "docker" do |docker|

    # Build docker images tagged with component name (each 'Dockerfile' is located in the respective sub folder).
    # Vagrant automatically shares the local folder (containing the Vagrantfile) as '/vagrant' within the guest machine.
    docker.build_image "/vagrant/elasticsearch", args: "--tag elasticsearch"
    docker.build_image "/vagrant/logstash",      args: "--tag logstash"
    docker.build_image "/vagrant/kibana",        args: "--tag kibana"

    # Start docker containers (automatically deamonized and using image name as container name)
    docker.run "elasticsearch", args: "-p 9200:9200"
    docker.run "logstash",      args: "-p 5000:5000 --link elasticsearch:elasticsearch -v /vagrant/logstash/config:/opt/conf/logstash -v /vagrant/logs:/var/logstash/logs"
    docker.run "kibana",        args: "-p 80:80"

  end

end
