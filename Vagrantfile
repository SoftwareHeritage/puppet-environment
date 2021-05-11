Vagrant.require_version ">= 2.2.0"
ENV["LC_ALL"] = "en_US.UTF-8"

# Default configuration for all defines node below
environment = "staging"
environment_path = "/tmp/puppet/environments"
manifest_file = "site.pp"
manifests_path = "swh-site/manifests"
puppet_options = "--fileserverconfig=/etc/puppet/fileserver.conf --verbose" # --debug --trace"
puppet_staging_facts = {
  "vagrant_testing" => "1",
  "testing"         => "vagrant",
  "deployment"      => "staging",
  "subnet"          => "vagrant"
}
puppet_production_facts = {
  "vagrant_testing" => "1",
  "testing"         => "vagrant",
  "deployment"      => "production",
  "subnet"          => "vagrant"
}
puppet_admin_facts = {
  "vagrant_testing" => "1",
  "testing"         => "vagrant",
  "deployment"      => "admin",
  "subnet"          => "vagrant"
}
# used to define the local vm template path
puppet_env_path = ENV["SWH_PUPPET_ENVIRONMENT_HOME"]

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
    config.vm.network   :private_network, ip: "10.168.130.30", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-rp0" do |config|
    # config.ssh.insert_key = false
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "rp0.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.20", netmask: "255.255.0.0"

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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-db1" do |config|
    # config.ssh.insert_key = false
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "db1.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.11", netmask: "255.255.0.0"

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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-storage1" do |config|
    # config.ssh.insert_key = false
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "storage1.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.41", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-objstorage0" do |config|
    # config.ssh.insert_key = false
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "objstorage0.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.110", netmask: "255.255.0.0"

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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-deposit" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "deposit.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.31", netmask: "255.255.0.0"

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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-worker0" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "worker0.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.100", netmask: "255.255.0.0"

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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  # indexer worker
  global_config.vm.define :"staging-worker3" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "worker3.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.103", netmask: "255.255.0.0"

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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-scheduler0" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "scheduler0.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.50", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-journal0" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "journal0.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.70", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-esnode0" do |config|
    # config.ssh.insert_key = false
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "search-esnode0.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.80", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-search0" do |config|
    # config.ssh.insert_key = false
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "search0.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.90", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-counters0" do |config|
    # config.ssh.insert_key = false
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "counters0.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.95", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"staging-mirror-test" do |config|
    # config.ssh.insert_key = false
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "mirror-test.internal.staging.swh.network"
    config.vm.network   :private_network, ip: "10.168.130.160", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
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
    config.vm.network   :private_network, ip: "10.168.100.199", netmask: "255.255.0.0"

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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"pergamon" do |config|
    # config.ssh.insert_key = false

    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "pergamon.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.29", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    # As a puppet master, the path is different compared to the other servers
    config.vm.synced_folder "vagrant/le_certs", "/var/lib/puppet/letsencrypt_exports", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 512
      provider.cpus = 2
      # local test run: https://github.com/vagrant-libvirt/vagrant-libvirt/issues/45
      provider.driver = 'kvm'
    end

    config.vm.provision "puppet" do |puppet|
      puppet.environment_path = "#{environment_path}"
      puppet.environment = "production"
      puppet.hiera_config_path = "#{puppet.environment_path}/#{puppet.environment}/hiera.yaml"
      puppet.manifest_file = "#{manifest_file}"
      puppet.manifests_path = "#{manifests_path}"
      puppet.options = "#{puppet_options}"
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  ################
  ## PRODUCTION
  ################
  global_config.vm.define :"prod-worker01" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "worker01.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.21", netmask: "255.255.0.0"

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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"esnode1" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "esnode1.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.61", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"esnode2" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "esnode2.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.62", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"esnode3" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.box_check_update        = false
    config.vm.hostname                = "esnode3.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.63", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"logstash" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "logstash0.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.19", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 2048
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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"admin-bardo" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "bardo.internal.admin.swh.network"
    config.vm.network   :private_network, ip: "10.168.50.10", netmask: "255.255.0.0"

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
      puppet.facter = puppet_admin_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"admin-rp1" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "rp1.internal.admin.swh.network"
    config.vm.network   :private_network, ip: "10.168.50.20", netmask: "255.255.0.0"

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
      puppet.facter = puppet_admin_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"prod-webapp1" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "webapp1.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.71", netmask: "255.255.0.0"

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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"prod-moma" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "moma.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.31", netmask: "255.255.0.0"

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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"prod-search1" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "search1.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.85", netmask: "255.255.0.0"

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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"prod-search-esnode1" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "search-esnode1.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.81", netmask: "255.255.0.0"

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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"prod-search-esnode2" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "search-esnode2.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.82", netmask: "255.255.0.0"

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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"prod-search-esnode3" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "search-esnode3.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.83", netmask: "255.255.0.0"

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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
    end
  end

  global_config.vm.define :"prod-counters1" do |config|
    config.vm.box                     = $global_debian10_box
    config.vm.box_url                 = $global_debian10_box_url
    config.vm.hostname                = "counters1.internal.softwareheritage.org"
    config.vm.network   :private_network, ip: "10.168.100.95", netmask: "255.255.0.0"

    config.vm.synced_folder "/tmp/puppet/", "/tmp/puppet", type: 'nfs'
    # ssl certificates share
    config.vm.synced_folder "vagrant/le_certs", "/etc/puppet/le_certs", type: 'nfs'

    config.vm.provider :libvirt do |provider|
      provider.memory = 1024
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
      puppet.facter = puppet_production_facts
      puppet.synced_folder_type = 'nfs'
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
    config.vm.network   :private_network, ip: "10.168.100.30", netmask: "255.255.0.0"
    config.vm.network   :private_network, ip: "10.168.101.30", netmask: "255.255.0.0"
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
      puppet.facter = puppet_staging_facts
      puppet.synced_folder_type = 'nfs'
    end
  end
end
