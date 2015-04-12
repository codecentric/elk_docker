# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  # define forwarded ports
  config.vm.network "forwarded_port", guest: 5601, host: 5601   # kibana
  config.vm.network "forwarded_port", guest: 5000, host: 5000   # logstash log forwarding (TLS-protected)
  config.vm.network "forwarded_port", guest: 9200, host: 9200   # elastisearch REST API accessed by kibana

  # adjust VM configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name = "ELK Stack"
    vb.memory = 2048
    vb.cpus = 2
  end

  # create logs/ directory for logstash file watching
  config.vm.provision "shell", inline: "mkdir -p /vagrant/logs"

  # build and run docker containers for elk stack
  config.vm.provision "docker" do |docker|

    # Build docker images from Dockerfiles located in the respective sub directories.
    # Vagrant automatically mounts the current directory as '/vagrant' in the guest machine.
    docker.build_image "/vagrant/elasticsearch", args: "--tag elasticsearch"
    docker.build_image "/vagrant/logstash",      args: "--tag logstash"
    docker.build_image "/vagrant/kibana",        args: "--tag kibana"

    # Start docker containers (automatically deamonized and using the image name as container name)
    docker.run "elasticsearch", args: "-p 9200:9200"
    docker.run "logstash",      args: "-p 5000:5000 --link elasticsearch:elasticsearch -v /vagrant/logstash/config:/conf -v /vagrant/logs:/var/logstash/logs"
    docker.run "kibana",        args: "-p 5601:5601 --link elasticsearch:elasticsearch"

  end

  # suppress tty error when using shell provisioning (cf. https://github.com/mitchellh/vagrant/issues/1673)
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # copy logstash's CA certificate to local directory
  config.vm.provision "shell", inline: "docker cp logstash:/etc/pki/tls/certs/logstash-ca.crt /vagrant/nxlog/"

  # build docker image and run NXlog container linked to logstash
  config.vm.provision "docker" do |docker|
    docker.build_image "/vagrant/nxlog", args: "--tag nxlog"
    docker.run "nxlog", args: "--link logstash:logstash -v /vagrant/nxlog/config:/conf"
  end

end
