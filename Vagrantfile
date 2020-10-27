Vagrant.require_version ">= 2.2.0"
ENV["LC_ALL"] = "en_US.UTF-8"

# Default configuration for all defines node below
environment = "staging"
environment_path = "/tmp/puppet/environments"
manifest_file = "site.pp"
manifests_path = "swh-site/manifests"
puppet_options = "--fileserverconfig=/etc/puppet/fileserver.conf --verbose"  # --debug --trace for more
puppet_default_facts = {
  "vagrant_testing" => "1",
  "testing" => "vagrant",
  "deployment" => "staging",
  "subnet" => "vagrant"
}
# used to define the local vm template path
puppet_env_path=ENV["SWH_PUPPET_ENVIRONMENT_HOME"]

# Images/local configuration (libvirt)
$local_debian10_box = "debian10-20201012-1352"
$local_debian10_box_url = "file://#{puppet_env_path}/packer/builds/swh-debian-10.6-amd64-20201012-1352.qcow2"

# Images/remote configuration
$global_debian10_box = "debian10-20201012-1352"
$global_debian10_box_url = "https://annex.softwareheritage.org/public/isos/libvirt/debian/swh-debian-10.6-amd64-20201012-1352.qcow2"

unless Vagrant.has_plugin?("libvirt")
  $stderr.puts <<-MSG
  vagrant-libvirt plugin is required for this.
  To install: `$ sudo apt install vagrant-libvirt
MSG
  exit 1
end

Vagrant.configure("2") do |global_config|
  ################
  ## STAGING
  ################
  global_config.vm.define :"staging-webapp" do |config|
    # config.ssh.insert_key = false
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "webapp.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.30", netmask: "255.255.255.0"


    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 512
      provider.cpus = 2
      # local test run: https://github.com/vagrant-libvirt/vagrant-libvirt/issues/45
      provider.driver = 'kvm'
    end
    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "#{environment_path}"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera.yaml"
      puppet.manifest_file = "#{manifest_file}"
      puppet.manifests_path = "#{manifests_path}"
      puppet.options = "#{puppet_options}"
      puppet.facter = puppet_default_facts
    end
  end

  global_config.vm.define :"staging-deposit" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "deposit.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.31", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 512
      provider.cpus = 2
      # local test run: https://github.com/vagrant-libvirt/vagrant-libvirt/issues/45
      provider.driver = 'kvm'
    end
    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "#{environment_path}"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera.yaml"
      puppet.manifest_file = "#{manifest_file}"
      puppet.manifests_path = "#{manifests_path}"
      puppet.options = "#{puppet_options}"
      puppet.facter = puppet_default_facts
    end
  end

  global_config.vm.define :"staging-worker0" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "worker0.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.100", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 512
      provider.cpus = 2
      # local test run: https://github.com/vagrant-libvirt/vagrant-libvirt/issues/45
      provider.driver = 'kvm'
    end

    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "#{environment_path}"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera.yaml"
      puppet.manifest_file = "#{manifest_file}"
      puppet.manifests_path = "#{manifests_path}"
      puppet.options = "#{puppet_options}"
      puppet.facter = puppet_default_facts
    end
  end

  ################
  # ADMIN
  ################
  global_config.vm.define :"bojimans" do |config|
    # config.ssh.insert_key = false

    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "bojimans.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.199", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 512
      provider.cpus = 2
      # local test run: https://github.com/vagrant-libvirt/vagrant-libvirt/issues/45
      provider.driver = 'kvm'
    end

    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "#{environment_path}"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera.yaml"
      puppet.manifest_file = "#{manifest_file}"
      puppet.manifests_path = "#{manifests_path}"
      puppet.options = "#{puppet_options}"
      puppet.facter = puppet_default_facts
    end
  end

  ################
  ## PRODUCTION
  ################
  global_config.vm.define :"prod-worker01" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "worker01.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.21", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 4096
      provider.cpus = 2
      # local test run: https://github.com/vagrant-libvirt/vagrant-libvirt/issues/45
      provider.driver = 'kvm'
    end

    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "#{environment_path}"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera.yaml"
      puppet.manifest_file = "#{manifest_file}"
      puppet.manifests_path = "#{manifests_path}"
      puppet.options = "#{puppet_options}"
      puppet.facter = puppet_default_facts
    end
  end

  ################
  ## MISC
  ################
  global_config.vm.define :test do |config|
    config.ssh.insert_key = false

    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update = false
    config.vm.hostname                = "test.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.30", netmask: "255.255.255.0"
    config.vm.network   :private_network, ip: "10.168.101.30", netmask: "255.255.255.0"
    config.vm.network "forwarded_port", guest: 10030, host: 22

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 512
      provider.cpus = 2
      # local test run: https://github.com/vagrant-libvirt/vagrant-libvirt/issues/45
      provider.driver = 'kvm'
    end
    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "#{environment_path}"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera.yaml"
      puppet.manifest_file = "#{manifest_file}"
      puppet.manifests_path = "#{manifests_path}"
      puppet.options = "#{puppet_options}"
      puppet.facter = puppet_default_facts
    end
  end
end
