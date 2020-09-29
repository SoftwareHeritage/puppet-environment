Vagrant.require_version ">= 2.2.0"
ENV["LC_ALL"] = "en_US.UTF-8"

environment="staging"

# local configuration
#$global_debian10_box     = "debian10-20200922-0913"
#$global_debian10_box_url = "file:///path/to/packer/builds/swh-debian-10.5-amd64-20200922-0913.box"

# http configuration
$global_debian10_box = "debian10-20200922-0913"
$global_debian10_box_url = "https://annex.softwareheritage.org/public/isos/virtualbox/debian/swh-debian-10.5-amd64-20200922-0913.box"

################
## STAGING
################
Vagrant.configure("2") do |config|
  config.vm.define :"staging-webapp" do |config|

    # config.ssh.insert_key = false

    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "webapp.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.128.8", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "staging-webapp"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 512
      vb.cpus = 2
    end
    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "/tmp/puppet/environments"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera-vagrant.yaml"
      puppet.manifest_file = "site.pp"
      puppet.manifests_path = "swh-site/manifests"
      puppet.options = "--verbose"
      # puppet.options = "--verbose --debug"
      # puppet.options = "--verbose --debug --trace"
      puppet.facter = {
        "vagrant_testing" => "1",
        "testing" => "vagrant",
        "location" => "vagrant"
      }
    end
  end
end

Vagrant.configure("2") do |config|
  config.vm.define :"staging-worker0" do |config|

    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "worker0.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.128.5", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "staging-worker0"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 4096
      vb.cpus = 2
    end

    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "/tmp/puppet/environments"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera-vagrant.yaml"
      puppet.manifest_file = "site.pp"
      puppet.manifests_path = "swh-site/manifests"
      puppet.options = "--verbose"
      # puppet.options = "--verbose --debug"
      # puppet.options = "--verbose --debug --trace"
      puppet.facter = {
        "vagrant_testing" => "1",
        "testing" => "vagrant",
        "location" => "vagrant"
      }
    end
  end
end

################
## ADMIN
################
Vagrant.configure("2") do |config|
  config.vm.define :"admin-inventory" do |config|

    # config.ssh.insert_key = false

    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "inventory.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.101.5", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "admin-inventory"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 512
      vb.cpus = 2
    end
    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "/tmp/puppet/environments"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera-vagrant.yaml"
      puppet.manifest_file = "site.pp"
      puppet.manifests_path = "swh-site/manifests"
      puppet.options = "--verbose"
      # puppet.options = "--verbose --debug"
      # puppet.options = "--verbose --debug --trace"
      puppet.facter = {
        "vagrant_testing" => "1",
        "testing" => "vagrant",
        "location" => "vagrant"
      }
    end
  end
end

################
## PRODUCTION
################
Vagrant.configure("2") do |config|
  config.vm.define :"prod-worker01" do |config|

    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "worker01.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.21", netmask: "255.255.255.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "worker01"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 4096
      vb.cpus = 2
    end

    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "/tmp/puppet/environments"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera-vagrant.yaml"
      puppet.manifest_file = "site.pp"
      puppet.manifests_path = "swh-site/manifests"
      puppet.options = "--verbose"
      # puppet.options = "--verbose --debug"
      # puppet.options = "--verbose --debug --trace"
      puppet.facter = {
        "vagrant_testing" => "1",
        "testing" => "vagrant",
        "location" => "vagrant"
      }
    end
  end
end

################
## MISC
################
Vagrant.configure("2") do |config|
  config.vm.define :test do |config|

    config.ssh.insert_key = false

    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update = false
    config.vm.hostname                = "test.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.30", netmask: "255.255.255.0"
    config.vm.network   :private_network, ip: "10.168.101.30", netmask: "255.255.255.0"
    config.vm.network "forwarded_port", guest: 10030, host: 22

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'

    config.vm.provider  "virtualbox" do |vb|
      vb.name = "test"
      vb.gui = false
      vb.check_guest_additions = false
      vb.linked_clone = true
      vb.memory = 512
      vb.cpus = 2
    end
    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "/tmp/puppet/environments"
      puppet.environment = "#{environment}"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera-vagrant.yaml"
      puppet.manifest_file = "site.pp"
      puppet.manifests_path = "swh-site/manifests"
      puppet.options = "--verbose"
      # puppet.options = "--verbose --debug"
      # puppet.options = "--verbose --debug --trace"
      puppet.facter = {
        "vagrant_testing" => "1",
        "testing" => "vagrant",
        "location" => "vagrant"
      }
    end
  end
end
