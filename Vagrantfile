Vagrant.require_version ">= 2.2.0"
ENV["LC_ALL"] = "en_US.UTF-8"

# Default configuration for all defines node below
environment_path = "/tmp/puppet/environments"
manifest_file = "site.pp"
manifests_path = "swh-site/manifests"
puppet_options = "--fileserverconfig=/etc/puppet/fileserver.conf --verbose" # --debug --trace"
# used to define the local vm template path
puppet_env_path = ENV["SWH_PUPPET_ENVIRONMENT_HOME"]
install_facts_script_path = "vagrant/puppet_agent/install_facts.sh"

# Images/local configuration (libvirt)
$local_debian10_box = "debian10-20210517-1348"
$local_debian10_box_url = "file://#{puppet_env_path}/packer/builds/swh-debian-10.9-amd64-20210517-1348.qcow2"

# Images/remote configuration
$global_debian10_box = "debian10-20210517-1348"
$global_debian10_box_url = "https://annex.softwareheritage.org/public/isos/libvirt/debian/swh-debian-10.9-amd64-20210517-1348.qcow2"

unless Vagrant.has_plugin?("libvirt")
  $stderr.puts <<-MSG
  vagrant-libvirt plugin is required for this.
  To install: `$ sudo apt install vagrant-libvirt
MSG
  exit 1
end

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
    "subnet"          => "vagrant"
  },
  ENV_PRODUCTION => {
    "vagrant_testing" => "1",
    "testing"         => "vagrant",
    "deployment"      => ENV_PRODUCTION,
    "subnet"          => "vagrant",
    "puppet_vardir"   => "/var/lib/puppet"
  },
  ENV_STAGING => {
    "vagrant_testing" => "1",
    "testing"         => "vagrant",
    "deployment"      => ENV_STAGING,
    "subnet"          => "vagrant"
  },
}

vms = {
  ################
  # STAGING
  ################
  "staging-webapp" => {
    :hostname    => "webapp.internal.staging.swh.network",
    :ip          => "10.168.130.30",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-rp0" => {
    :hostname    => "rp0.internal.staging.swh.network",
    :ip          => "10.168.130.20",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-db1" => {
    :hostname    => "db1.internal.staging.swh.network",
    :ip          => "10.168.130.11",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-storage1" => {
    :hostname    => "storage1.internal.staging.swh.network",
    :ip          => "10.168.130.41",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-objstorage0" => {
    :hostname    => "objstorage0.internal.staging.swh.network",
    :ip          => "10.168.130.110",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-deposit" => {
    :hostname    => "deposit.internal.staging.swh.network",
    :ip          => "10.168.130.31",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-worker0" => {
    :hostname    => "worker0.internal.staging.swh.network",
    :ip          => "10.168.130.100",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-worker3" => {
    :hostname    => "worker0.internal.staging.swh.network",
    :ip          => "10.168.130.103",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-scheduler0" => {
    :hostname    => "scheduler0.internal.staging.swh.network",
    :ip          => "10.168.130.50",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-journal0" => {
    :hostname    => "journal0.internal.staging.swh.network",
    :ip          => "10.168.130.70",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-esnode0" => {
    :hostname    => "search-esnode0.internal.staging.swh.network",
    :ip          => "10.168.130.80",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-search0" => {
    :hostname    => "search-search0.internal.staging.swh.network",
    :ip          => "10.168.130.90",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-counters0" => {
    :hostname    => "counters0.internal.staging.swh.network",
    :ip          => "10.168.130.95",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-mirror-test" => {
    :hostname    => "mirror-test.internal.staging.swh.network",
    :ip          => "10.168.130.160",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  ################
  # ADMIN
  ################
  "admin-bardo" => {
    :hostname    => "bardo.internal.admin.swh.network",
    :ip          => "10.168.50.10",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_ADMIN,
  },
  "admin-rp1" => {
    :hostname    => "rp1.internal.admin.swh.network",
    :ip          => "10.168.50.20",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_ADMIN,
  },
  ################
  # PUPPET MASTER
  ################
  "pergamon" => {
    :hostname    => "pergamon.internal.softwareheritage.org",
    :ip          => "10.168.100.29",
    :type        => TYPE_MASTER,
    :memory      => 3192,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  ################
  # PRODUCTION
  ################
  "bojimans" => {
    :hostname    => "bojimans.internal.softwareheritage.org",
    :ip          => "10.168.100.199",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-worker01" => {
    :hostname    => "worker01.internal.softwareheritage.org",
    :ip          => "10.168.100.21",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "esnode1" => {
    :hostname    => "esnode1.internal.softwareheritage.org",
    :ip          => "10.168.100.61",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "esnode2" => {
    :hostname    => "esnode2.internal.softwareheritage.org",
    :ip          => "10.168.100.62",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "esnode3" => {
    :hostname    => "esnode3.internal.softwareheritage.org",
    :ip          => "10.168.100.63",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "logstash" => {
    :hostname    => "logstash0.internal.softwareheritage.org",
    :ip          => "10.168.100.19",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-webapp1" => {
    :hostname    => "webapp1.internal.softwareheritage.org",
    :ip          => "10.168.100.71",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-moma" => {
    :hostname    => "webapp1.internal.softwareheritage.org",
    :ip          => "10.168.100.31",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-search1" => {
    :hostname    => "search1.internal.softwareheritage.org",
    :ip          => "10.168.100.85",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-search-esnode1" => {
    :hostname    => "search-esnode1.internal.softwareheritage.org",
    :ip          => "10.168.100.81",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-search-esnode2" => {
    :hostname    => "search-esnode2.internal.softwareheritage.org",
    :ip          => "10.168.100.82",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-search-esnode3" => {
    :hostname    => "search-esnode3.internal.softwareheritage.org",
    :ip          => "10.168.100.83",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-counters1" => {
    :hostname    => "counters1.internal.softwareheritage.org",
    :ip          => "10.168.100.95",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  ################
  ## MISC
  ################
  "test" => {
    :hostname    => "test.softwareheritage.org",
    :ip          => "10.168.100.130",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
}

vms.each { | vm_name, vm_props |
  Vagrant.configure("2") do |global_config|
    global_config.vm.define vm_name do |config|
      _environment = vm_props[:environment]
      _facts = ENVIRONMENT_FACTS[_environment]
      _mount_point_puppet = vm_props[:type] == TYPE_MASTER ? "/etc/puppet/code" : "/tmp/puppet"

      # config.ssh.insert_key = false
      config.vm.box                     = $global_debian10_box
      config.vm.box_url                 = $global_debian10_box_url
      config.vm.box_check_update        = false
      config.vm.hostname                = vm_props[:hostname]
      config.vm.network   :private_network, ip: vm_props[:ip], netmask: "255.255.0.0"

      config.vm.synced_folder "/tmp/puppet/", _mount_point_puppet, type: 'nfs'

      # ssl certificates share
      config.vm.synced_folder "vagrant/le_certs", "/var/lib/puppet/letsencrypt_exports", type: 'nfs'

      config.vm.provider :libvirt do |provider|
        provider.memory = vm_props[:memory]
        provider.cpus = vm_props[:cpus]
        # local test run: https://github.com/vagrant-libvirt/vagrant-libvirt/issues/45
        provider.driver = 'kvm'
      end
      # installs fact for `puppet agent --test` cli to work within the vm
      config.vm.provision :shell do |s|
        s.path = install_facts_script_path
        s.args = [
          _facts["deployment"],
          _facts["subnet"]
        ]
      end

      if vm_props[:type] == TYPE_MASTER
        config.vm.provision "file", source: "vagrant/puppet_master/", destination: "/tmp/"
        config.vm.provision :shell, :path => "vagrant/puppet_master/prepare_puppet_master.sh"
      end

      config.vm.provision "puppet" do |puppet|
        puppet.environment = _environment
        if vm_props[:type] == TYPE_AGENT
          puppet.environment_path = "#{environment_path}"
          puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera.yaml"
        end
        puppet.manifest_file = "#{manifest_file}"
        puppet.manifests_path = "#{manifests_path}"
        puppet.options = "#{puppet_options}"
        puppet.facter = _facts
        puppet.synced_folder_type = 'nfs'
      end
    end
  end
}
