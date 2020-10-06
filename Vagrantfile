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

# Images configuration
$global_debian10_box = "debian10-20201006-0832"
$global_debian10_box_url = "https://annex.softwareheritage.org/public/isos/virtualbox/debian/swh-debian-10.6-amd64-20201006-0832.box"
# For local tests
#$global_debian10_box_url = "file:///path/to/packer/builds/swh-debian-10.6-amd64-20201006-0832.box"

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
    config.vm.network   :private_network, ip: "10.168.128.8", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "staging-webapp"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 512
      vb.cpus = 2
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
    config.vm.network   :private_network, ip: "10.168.128.9", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "staging-deposit"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 512
      vb.cpus = 2
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
    config.vm.network   :private_network, ip: "10.168.128.5", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "staging-worker0"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 4096
      vb.cpus = 2
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

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "bojimans"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 512
      vb.cpus = 2
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

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "worker01"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 4096
      vb.cpus = 2
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

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "test"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 512
      vb.cpus = 2
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
