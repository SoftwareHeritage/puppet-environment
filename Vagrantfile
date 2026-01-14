Vagrant.require_version ">= 2.2.0"
ENV["LC_ALL"] = "en_US.UTF-8"

tmpdir = "/var/tmp/puppet"
# Default configuration for all defines node below
environment_path = "#{tmpdir}/environments"
manifest_file = "site.pp"
manifests_path = "swh-site/manifests"
puppet_options = "--fileserverconfig=/etc/puppet/fileserver.conf --verbose" # --debug --trace"
# used to define the local vm template path
puppet_env_path = ENV["SWH_PUPPET_ENVIRONMENT_HOME"]
install_facts_script_path = "vagrant/puppet_agent/install_facts.sh"

debian12_box = "cloud-image/debian-12"
debian12_zfs_box = "cloud-image/debian-12"

TYPE_AGENT = "agent"
TYPE_MASTER = "master"
ENV_ADMIN = "admin"
ENV_PRODUCTION = "production"
ENV_STAGING = "staging"

ENVIRONMENT_FACTS = {
  ENV_ADMIN      => {
    "vagrant_testing" => "1",
    "testing"         => "vagrant",
    "deployment"      => ENV_ADMIN,
    "subnet"          => "vagrant",
    "environment"     => ENV_PRODUCTION,
  },
  ENV_PRODUCTION => {
    "vagrant_testing" => "1",
    "testing"         => "vagrant",
    "deployment"      => ENV_PRODUCTION,
    "subnet"          => "vagrant",
    "puppet_vardir"   => "/var/lib/puppet",
    "environment"     => ENV_PRODUCTION,
  },
  ENV_STAGING => {
    "vagrant_testing" => "1",
    "testing"         => "vagrant",
    "deployment"      => ENV_STAGING,
    "subnet"          => "vagrant",
    "environment"     => ENV_STAGING,
  },
}

vms = {
  ################
  # STAGING
  ################
  "staging-webapp" => {
    :enabled     => false,
    :hostname    => "webapp.internal.staging.swh.network",
    :ip          => "10.168.130.30",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-maven-exporter0" => {
    :enabled     => false,
    :hostname    => "maven-exporter0.internal.staging.swh.network",
    :ip          => "10.168.130.70",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :extra_disk  => 'vdb',
  },
  "staging-rp0" => {
    :enabled     => false,
    :hostname    => "rp0.internal.staging.swh.network",
    :ip          => "10.168.130.20",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-db1" => {
    :enabled     => false,
    :hostname    => "db1.internal.staging.swh.network",
    :ip          => "10.168.130.11",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-storage1" => {
    :enabled     => false,
    :hostname    => "storage1.internal.staging.swh.network",
    :ip          => "10.168.130.41",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-objstorage0" => {
    :enabled     => false,
    :hostname    => "objstorage0.internal.staging.swh.network",
    :ip          => "10.168.130.110",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-deposit" => {
    :enabled     => false,
    :hostname    => "deposit.internal.staging.swh.network",
    :ip          => "10.168.130.31",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-worker0" => {
    :enabled     => false,
    :hostname    => "worker0.internal.staging.swh.network",
    :ip          => "10.168.130.100",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-worker3" => {
    :enabled     => false,
    :hostname    => "worker0.internal.staging.swh.network",
    :ip          => "10.168.130.103",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-elastic-worker0" => {
    :enabled     => false,
    :hostname    => "elastic-worker0.internal.staging.swh.network",
    :ip          => "10.168.130.130",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :extra_disk  => 'vdb',
  },
  "staging-rancher-node-intern0" => {
    :enabled     => false,
    :hostname    => "rancher-node-intern0.internal.staging.swh.network",
    :ip          => "10.168.130.140",
    :type        => TYPE_AGENT,
    :memory      => 3096,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :extra_disk  => 'vdb',
  },
  "staging-scrubber0" => {
    :enabled     => false,
    :hostname    => "scrubber0.internal.staging.swh.network",
    :ip          => "10.168.130.120",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-scheduler0" => {
    :enabled     => false,
    :hostname    => "scheduler0.internal.staging.swh.network",
    :ip          => "10.168.130.50",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-esnode0" => {
    :enabled     => false,
    :hostname    => "search-esnode0.internal.staging.swh.network",
    :ip          => "10.168.130.80",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-search0" => {
    :enabled     => false,
    :hostname    => "search-search0.internal.staging.swh.network",
    :ip          => "10.168.130.90",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-counters0" => {
    :enabled     => false,
    :hostname    => "counters0.internal.staging.swh.network",
    :ip          => "10.168.130.95",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-mirror-test" => {
    :enabled     => false,
    :hostname    => "mirror-test.internal.staging.swh.network",
    :ip          => "10.168.130.160",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-cassandra1" => {
    :enabled     => false,
    :hostname    => "cassandra1.internal.staging.swh.network",
    :ip          => "10.168.130.181",
    :type        => TYPE_AGENT,
    :memory      => 3092,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-cassandra2" => {
    :enabled     => false,
    :hostname    => "cassandra2.internal.staging.swh.network",
    :ip          => "10.168.130.182",
    :type        => TYPE_AGENT,
    :memory      => 3092,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-cassandra3" => {
    :enabled     => false,
    :hostname    => "cassandra3.internal.staging.swh.network",
    :ip          => "10.168.130.183",
    :type        => TYPE_AGENT,
    :memory      => 3092,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },

  ################
  # ADMIN
  ################
  "bojimans" => {
    :enabled     => false,
    :hostname    => "bojimans.internal.admin.swh.network",
    :ip          => "10.168.50.60",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_ADMIN,
  },
  "dali" => {
    :enabled     => false,
    :hostname    => "dali.internal.admin.swh.network",
    :ip          => "10.168.50.50",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_ADMIN,
  },
  "admin-bardo" => {
    :enabled     => false,
    :hostname    => "bardo.internal.admin.swh.network",
    :ip          => "10.168.50.10",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_ADMIN,
  },
  "admin-rp1" => {
    :enabled     => false,
    :hostname    => "rp1.internal.admin.swh.network",
    :ip          => "10.168.50.20",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_ADMIN,
  },
  "admin-grafana0" => {
    :enabled     => false,
    :hostname    => "grafana0.internal.admin.swh.network",
    :ip          => "10.168.50.30",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_ADMIN,
  },
  "admin-backup01" => {
    :enabled     => false,
    :hostname    => "backup01.euwest.azure.internal.softwareheritage.org",
    :ip          => "10.168.200.50",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_ADMIN,
  },
  "admin-money" => {
    :enabled     => false,
    :hostname    => "money.internal.admin.swh.network",
    :ip          => "10.168.200.65",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 1,
    :environment => ENV_ADMIN,
  },

  ################
  # PUPPET MASTER
  ################
  "pergamon" => {
    :enabled     => true,
    :hostname    => "pergamon.softwareheritage.org",
    :ip          => "10.168.100.29",
    :type        => TYPE_MASTER,
    :memory      => 3192,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  ################
  # PRODUCTION
  ################
  "prod-ns0" => {
    :enabled     => false,
    :hostname    => "ns0.euwest.azure.internal.softwareheritage.org",
    :ip          => "10.168.200.22",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "saam" => {
    :enabled     => false,
    :hostname    => "saam.internal.softwareheritage.org",
    :ip          => "10.168.100.109",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "saatchi" => {
    :enabled     => false,
    :hostname    => "saatchi.internal.softwareheritage.org",
    :ip          => "10.168.100.104",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "riverside" => {
    :enabled     => false,
    :hostname    => "riverside.internal.admin.swh.network",
    :ip          => "10.168.50.70",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 4,
    :environment => ENV_PRODUCTION,
  },
  "thanos" => {
    :enabled     => false,
    :hostname    => "thanos.internal.admin.swh.network",
    :ip          => "10.168.50.90",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 4,
    :environment => ENV_PRODUCTION,
  },
  "kelvingrove" => {
    :enabled     => false,
    :hostname    => "kelvingrove.internal.softwareheritage.org",
    :ip          => "10.168.100.106",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "getty" => {
    :enabled     => false,
    :hostname    => "getty.internal.softwareheritage.org",
    :type        => TYPE_AGENT,
    :ip          => "10.168.100.102",
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "giverny" => {
    :enabled     => false,
    :hostname    => "giverny.softwareheritage.org",
    :type        => TYPE_AGENT,
    :ip          => "10.168.101.118",
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-worker01" => {
    :enabled     => false,
    :hostname    => "worker01.softwareheritage.org",
    :ip          => "10.168.100.21",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-worker17" => {
    :enabled     => false,
    :hostname    => "worker17.softwareheritage.org",
    :ip          => "10.168.100.43",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "esnode1" => {
    :enabled     => false,
    :hostname    => "esnode1.internal.softwareheritage.org",
    :ip          => "10.168.100.61",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "esnode2" => {
    :enabled     => false,
    :hostname    => "esnode2.internal.softwareheritage.org",
    :ip          => "10.168.100.62",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "esnode3" => {
    :enabled     => false,
    :hostname    => "esnode3.internal.softwareheritage.org",
    :ip          => "10.168.100.63",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-kibana0" => {
    :enabled     => false,
    :hostname    => "kibana0.internal.softwareheritage.org",
    :ip          => "10.168.100.50",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "logstash" => {
    :enabled     => false,
    :hostname    => "logstash0.internal.softwareheritage.org",
    :ip          => "10.168.100.19",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-cassandra01" => {
    :enabled     => false,
    :hostname    => "cassandra01.internal.softwareheritage.org",
    :ip          => "10.168.100.181",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-cassandra02" => {
    :enabled     => false,
    :hostname    => "cassandra02.internal.softwareheritage.org",
    :ip          => "10.168.100.182",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-cassandra03" => {
    :enabled     => false,
    :hostname    => "cassandra03.internal.softwareheritage.org",
    :ip          => "10.168.100.183",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-granet" => {
    :enabled     => false,
    :hostname    => "granet.internal.softwareheritage.org",
    :ip          => "10.168.100.51",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-webapp1" => {
    :enabled     => false,
    :hostname    => "webapp1.internal.softwareheritage.org",
    :ip          => "10.168.100.71",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-met" => {
    :enabled     => false,
    :hostname    => "met.internal.softwareheritage.org",
    :ip          => "10.168.100.110",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-moma" => {
    :enabled     => false,
    :hostname    => "moma.softwareheritage.org",
    :ip          => "10.168.100.31",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-search1" => {
    :enabled     => false,
    :hostname    => "search1.internal.softwareheritage.org",
    :ip          => "10.168.100.85",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-search-esnode4" => {
    :enabled     => false,
    :hostname    => "search-esnode4.internal.softwareheritage.org",
    :ip          => "10.168.100.86",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-search-esnode5" => {
    :enabled     => false,
    :hostname    => "search-esnode5.internal.softwareheritage.org",
    :ip          => "10.168.100.87",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-search-esnode6" => {
    :enabled     => false,
    :hostname    => "search-esnode6.internal.softwareheritage.org",
    :ip          => "10.168.100.88",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-counters1" => {
    :enabled     => false,
    :hostname    => "counters1.internal.softwareheritage.org",
    :ip          => "10.168.100.95",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-kafka1" => {
    :enabled     => false,
    :hostname    => "kafka1.internal.softwareheritage.org",
    :ip          => "10.168.100.201",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-kafka2" => {
    :enabled     => false,
    :hostname    => "kafka2.internal.softwareheritage.org",
    :ip          => "10.168.100.202",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-kafka3" => {
    :enabled     => false,
    :hostname    => "kafka3.internal.softwareheritage.org",
    :ip          => "10.168.100.203",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-kafka4" => {
    :enabled     => false,
    :hostname    => "kafka4.internal.softwareheritage.org",
    :ip          => "10.168.100.204",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "uffizi" => {
    :enabled     => false,
    :hostname    => "uffizi.internal.softwareheritage.org",
    :ip          => "10.168.100.101",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "branly" => {
    :enabled     => false,
    :hostname    => "branly.internal.softwareheritage.org",
    :ip          => "10.168.100.108",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "belvedere" => {
    :enabled     => false,
    :hostname    => "belvedere.internal.softwareheritage.org",
    :ip          => "10.168.100.210",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "somerset" => {
    :enabled     => false,
    :hostname    => "somerset.internal.softwareheritage.org",
    :ip          => "10.168.100.103",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "jenkins-debian1" => {
    :enabled     => false,
    :hostname    => "jenkins-debian1.internal.softwareheritage.org",
    :ip          => "10.168.100.150",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "thyssen" => {
    :enabled     => false,
    :hostname    => "thyssen.internal.softwareheritage.org",
    :ip          => "10.168.100.105",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "tate" => {
    :enabled     => false,
    :hostname    => "tate.softwareheritage.org",
    :ip          => "10.168.100.30",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  ################
  ## MISC
  ################
  "test" => {
    :enabled     => false,
    :hostname    => "test.softwareheritage.org",
    :ip          => "10.168.100.130",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "test-bullseye" => {
    :enabled     => false,
    :hostname    => "testbullseye.softwareheritage.org",
    :ip          => "10.168.100.131",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
}

Vagrant.configure("2") do |global_config|
  vms.each do | vm_name, vm_props |
      next unless vm_props[:enabled]
      global_config.vm.define vm_name do |config|
      _environment_name = vm_props[:environment]
      _vm_facts = ENVIRONMENT_FACTS[_environment_name]
      _mount_point_puppet = vm_props[:type] == TYPE_MASTER ? "/etc/puppet/code" : "/tmp/puppet"

      # config.ssh.insert_key = false
      config.vm.guest = :debian
      config.vm.box                     = vm_props[:box] ? vm_props[:box] : debian12_box
      config.vm.box_check_update        = false
      config.vm.hostname                = vm_props[:hostname]
      config.vm.network   :private_network, ip: vm_props[:ip], netmask: "255.255.0.0"

      # Using nfs v4 to avoid using the default nfs v3 on udp not supported by the debian 11 kernel
      config.vm.synced_folder tmpdir, _mount_point_puppet,
        type: 'nfs',
        nfs_version:4,
        linux__nfs_options:['rw', 'no_subtree_check', 'no_root_squash']  # needed for chown-ing
      # Hack to speed up the puppet provisioner rsync
      # It will synchronize between the same source and destination
      config.vm.synced_folder tmpdir, '/vagrant',
        type: 'nfs',
        nfs_version:4,
        linux__nfs_options:['rw', 'no_subtree_check', 'no_root_squash']
      config.vm.synced_folder tmpdir, '/vagrant-puppet',
        type: 'nfs',
        nfs_version:4,
        linux__nfs_options:['rw', 'no_subtree_check', 'no_root_squash']

      # ssl certificates share
      config.vm.synced_folder "vagrant/le_certs", "/var/lib/puppet/letsencrypt_exports", type: 'nfs', nfs_version:4

      config.vm.provider :libvirt do |provider|
        provider.memory = vm_props[:memory]
        provider.cpus = vm_props[:cpus]
        # local test run: https://github.com/vagrant-libvirt/vagrant-libvirt/issues/45
        provider.driver = 'kvm'
        if vm_props.has_key?(:extra_disk)
          # https://github.com/vagrant-libvirt/vagrant-libvirt#additional-disks
          provider.storage :file, :size => '20G', :device => vm_props[:extra_disk], :type => 'raw'
        end
      end

      config.vm.provision :file,
        :source => "vagrant/provision_at_reboot.sh",
        :destination => "/tmp/vagrant_provision_at_reboot.sh"
      config.vm.provision :shell, :path => "vagrant/provision.sh"
      config.vm.provision :reload

      # installs fact for `puppet agent --test` cli to work within the vm
      config.vm.provision :shell do |s|
        s.path = install_facts_script_path
        s.args = [
          _vm_facts["deployment"],
          _vm_facts["subnet"]
        ]
      end

      if vm_props[:type] == TYPE_MASTER
        config.vm.provision "file",
          source: "vagrant/puppet_server/",
          destination: "/tmp/vagrant_provisioning/"
        config.vm.provision :shell,
          :path => "vagrant/puppet_server/prepare_puppet_server.sh"
      end

      config.vm.provision "puppet" do |puppet|
        puppet.environment = _vm_facts["environment"]
        if vm_props[:type] == TYPE_AGENT
          puppet.environment_path = "#{environment_path}"
          puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera.yaml"
        end
        puppet.manifest_file = "#{manifest_file}"
        puppet.manifests_path = "#{manifests_path}"
        puppet.options = "#{puppet_options}"
        puppet.facter = _vm_facts
        # Dont use nfs mount as the nfs_version can't be
        # specified. The default is nfsv3 and udp which is not
        # supported by the debian 11 kernel
        puppet.synced_folder_type = 'rsync'
      end
    end
  end
end
