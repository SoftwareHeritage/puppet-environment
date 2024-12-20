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

annex_url = "https://annex.softwareheritage.org/public/isos/libvirt/debian"

####################
# oldstable (buster)
####################

debian_oldstable_version = "10.10"
debian_oldstable_timestamp = "20210820-1622"

# Images/local configuration (libvirt)
debian10_box = "debian10-#{debian_oldstable_timestamp}"
debian_oldstable_qcow2 = "swh-debian-#{debian_oldstable_version}-amd64-#{debian_oldstable_timestamp}.qcow2"
local_debian10_box_url = "file://#{puppet_env_path}/packer/builds/#{debian_oldstable_qcow2}"

# Images/remote configuration
debian10_box_url = "#{annex_url}/#{debian_oldstable_qcow2}"

###################
# stable (bullseye)
###################

debian_stable_version = "11.4"

debian_stable_timestamp = "20220727-1040"
debian11_box = "debian11-#{debian_stable_version}"
debian_stable_qcow2 = "swh-debian-#{debian_stable_version}-amd64-#{debian_stable_timestamp}.qcow2"
debian11_box_url = "#{annex_url}/#{debian_stable_qcow2}"

# With zfs preinstalled
debian_stable_zfs_timestamp = "20220727-1050"
debian11_zfs_box = "debian11-zfs-#{debian_stable_zfs_timestamp}"
debian_stable_zfs_qcow2 = "swh-debian-zfs-#{debian_stable_version}-amd64-#{debian_stable_zfs_timestamp}.qcow2"
debian11_zfs_box_url = "#{annex_url}/#{debian_stable_zfs_qcow2}"

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
    :hostname    => "webapp.internal.staging.swh.network",
    :ip          => "10.168.130.30",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "staging-maven-exporter0" => {
    :hostname    => "maven-exporter0.internal.staging.swh.network",
    :ip          => "10.168.130.70",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :extra_disk  => 'vdb',
    :box         => debian11_zfs_box,
    :box_url     => debian11_zfs_box_url,
  },
  "staging-rp0" => {
    :hostname    => "rp0.internal.staging.swh.network",
    :ip          => "10.168.130.20",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "staging-db1" => {
    :hostname    => "db1.internal.staging.swh.network",
    :ip          => "10.168.130.11",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "staging-storage1" => {
    :hostname    => "storage1.internal.staging.swh.network",
    :ip          => "10.168.130.41",
    :type        => TYPE_AGENT,
    :memory      => 4096,
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
  "staging-elastic-worker0" => {
    :hostname    => "elastic-worker0.internal.staging.swh.network",
    :ip          => "10.168.130.130",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :box         => debian11_zfs_box,
    :box_url     => debian11_zfs_box_url,
    :extra_disk  => 'vdb',
  },
  "staging-rancher-node-intern0" => {
    :hostname    => "rancher-node-intern0.internal.staging.swh.network",
    :ip          => "10.168.130.140",
    :type        => TYPE_AGENT,
    :memory      => 3096,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :box         => debian11_zfs_box,
    :box_url     => debian11_zfs_box_url,
    :extra_disk  => 'vdb',
  },
  "staging-scrubber0" => {
    :hostname    => "scrubber0.internal.staging.swh.network",
    :ip          => "10.168.130.120",
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
  "staging-esnode0" => {
    :hostname    => "search-esnode0.internal.staging.swh.network",
    :ip          => "10.168.130.80",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
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
  "staging-cassandra1" => {
    :hostname    => "cassandra1.internal.staging.swh.network",
    :ip          => "10.168.130.181",
    :type        => TYPE_AGENT,
    :memory      => 3092,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "staging-cassandra2" => {
    :hostname    => "cassandra2.internal.staging.swh.network",
    :ip          => "10.168.130.182",
    :type        => TYPE_AGENT,
    :memory      => 3092,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "staging-cassandra3" => {
    :hostname    => "cassandra3.internal.staging.swh.network",
    :ip          => "10.168.130.183",
    :type        => TYPE_AGENT,
    :memory      => 3092,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },

  ################
  # ADMIN
  ################
  "bojimans" => {
    :hostname    => "bojimans.internal.admin.swh.network",
    :ip          => "10.168.50.60",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_ADMIN,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "dali" => {
    :hostname    => "dali.internal.admin.swh.network",
    :ip          => "10.168.50.50",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_ADMIN,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "admin-bardo" => {
    :hostname    => "bardo.internal.admin.swh.network",
    :ip          => "10.168.50.10",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_ADMIN,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "admin-rp1" => {
    :hostname    => "rp1.internal.admin.swh.network",
    :ip          => "10.168.50.20",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_ADMIN,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "admin-grafana0" => {
    :hostname    => "grafana0.internal.admin.swh.network",
    :ip          => "10.168.50.30",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_ADMIN,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "admin-backup01" => {
    :hostname    => "backup01.euwest.azure.internal.softwareheritage.org",
    :ip          => "10.168.200.50",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_ADMIN,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "admin-money" => {
    :hostname    => "money.internal.admin.swh.network",
    :ip          => "10.168.200.65",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 1,
    :environment => ENV_ADMIN,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },

  ################
  # PUPPET MASTER
  ################
  "pergamon" => {
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
    :hostname    => "ns0.euwest.azure.internal.softwareheritage.org",
    :ip          => "10.168.200.22",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "saam" => {
    :hostname    => "saam.internal.softwareheritage.org",
    :ip          => "10.168.100.109",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "saatchi" => {
    :hostname    => "saatchi.internal.softwareheritage.org",
    :ip          => "10.168.100.104",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "riverside" => {
    :hostname    => "riverside.internal.admin.swh.network",
    :ip          => "10.168.50.70",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 4,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "thanos" => {
    :hostname    => "thanos.internal.admin.swh.network",
    :ip          => "10.168.50.90",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 4,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "kelvingrove" => {
    :hostname    => "kelvingrove.internal.softwareheritage.org",
    :ip          => "10.168.100.106",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "getty" => {
    :hostname    => "getty.internal.softwareheritage.org",
    :type        => TYPE_AGENT,
    :ip          => "10.168.100.102",
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "giverny" => {
    :hostname    => "giverny.softwareheritage.org",
    :type        => TYPE_AGENT,
    :ip          => "10.168.101.118",
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-worker01" => {
    :hostname    => "worker01.softwareheritage.org",
    :ip          => "10.168.100.21",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-worker17" => {
    :hostname    => "worker17.softwareheritage.org",
    :ip          => "10.168.100.43",
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
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "esnode2" => {
    :hostname    => "esnode2.internal.softwareheritage.org",
    :ip          => "10.168.100.62",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "esnode3" => {
    :hostname    => "esnode3.internal.softwareheritage.org",
    :ip          => "10.168.100.63",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-kibana0" => {
    :hostname    => "kibana0.internal.softwareheritage.org",
    :ip          => "10.168.100.50",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "logstash" => {
    :hostname    => "logstash0.internal.softwareheritage.org",
    :ip          => "10.168.100.19",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-cassandra01" => {
    :hostname    => "cassandra01.internal.softwareheritage.org",
    :ip          => "10.168.100.181",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-cassandra02" => {
    :hostname    => "cassandra02.internal.softwareheritage.org",
    :ip          => "10.168.100.182",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-cassandra03" => {
    :hostname    => "cassandra03.internal.softwareheritage.org",
    :ip          => "10.168.100.183",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-granet" => {
    :hostname    => "granet.internal.softwareheritage.org",
    :ip          => "10.168.100.51",
    :type        => TYPE_AGENT,
    :memory      => 1024,
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
  "prod-met" => {
    :hostname    => "met.internal.softwareheritage.org",
    :ip          => "10.168.100.110",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-moma" => {
    :hostname    => "moma.softwareheritage.org",
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
  "prod-search-esnode4" => {
    :hostname    => "search-esnode4.internal.softwareheritage.org",
    :ip          => "10.168.100.86",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-search-esnode5" => {
    :hostname    => "search-esnode5.internal.softwareheritage.org",
    :ip          => "10.168.100.87",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-search-esnode6" => {
    :hostname    => "search-esnode6.internal.softwareheritage.org",
    :ip          => "10.168.100.88",
    :type        => TYPE_AGENT,
    :memory      => 4096,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-counters1" => {
    :hostname    => "counters1.internal.softwareheritage.org",
    :ip          => "10.168.100.95",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
  },
  "prod-kafka1" => {
    :hostname    => "kafka1.internal.softwareheritage.org",
    :ip          => "10.168.100.201",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-kafka2" => {
    :hostname    => "kafka2.internal.softwareheritage.org",
    :ip          => "10.168.100.202",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-kafka3" => {
    :hostname    => "kafka3.internal.softwareheritage.org",
    :ip          => "10.168.100.203",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "prod-kafka4" => {
    :hostname    => "kafka4.internal.softwareheritage.org",
    :ip          => "10.168.100.204",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "uffizi" => {
    :hostname    => "uffizi.internal.softwareheritage.org",
    :ip          => "10.168.100.101",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "branly" => {
    :hostname    => "branly.internal.softwareheritage.org",
    :ip          => "10.168.100.108",
    :type        => TYPE_AGENT,
    :memory      => 1024,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "belvedere" => {
    :hostname    => "belvedere.internal.softwareheritage.org",
    :ip          => "10.168.100.210",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "somerset" => {
    :hostname    => "somerset.internal.softwareheritage.org",
    :ip          => "10.168.100.103",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "jenkins-debian1" => {
    :hostname    => "jenkins-debian1.internal.softwareheritage.org",
    :ip          => "10.168.100.150",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "thyssen" => {
    :hostname    => "thyssen.internal.softwareheritage.org",
    :ip          => "10.168.100.105",
    :type        => TYPE_AGENT,
    :memory      => 2048,
    :cpus        => 2,
    :environment => ENV_PRODUCTION,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
  "tate" => {
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
    :hostname    => "test.softwareheritage.org",
    :ip          => "10.168.100.130",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
  },
  "test-bullseye" => {
    :hostname    => "testbullseye.softwareheritage.org",
    :ip          => "10.168.100.131",
    :type        => TYPE_AGENT,
    :memory      => 512,
    :cpus        => 2,
    :environment => ENV_STAGING,
    :box         => debian11_box,
    :box_url     => debian11_box_url,
  },
}

Vagrant.configure("2") do |global_config|
  vms.each do | vm_name, vm_props |
      global_config.vm.define vm_name do |config|
      _environment_name = vm_props[:environment]
      _vm_facts = ENVIRONMENT_FACTS[_environment_name]
      _mount_point_puppet = vm_props[:type] == TYPE_MASTER ? "/etc/puppet/code" : "/tmp/puppet"

      # config.ssh.insert_key = false
      config.vm.guest = :debian
      config.vm.box                     = vm_props[:box] ? vm_props[:box] : debian10_box
      config.vm.box_url                 = vm_props[:box_url] ? vm_props[:box_url] : debian10_box_url
      config.vm.box_check_update        = false
      config.vm.hostname                = vm_props[:hostname]
      config.vm.network   :private_network, ip: vm_props[:ip], netmask: "255.255.0.0"

      # Using nfs v4 to avoid using the default nfs v3 on udp not supported by the debian 11 kernel
      config.vm.synced_folder tmpdir, _mount_point_puppet, type: 'nfs', nfs_version:4
      # Hack to speed up the puppet provisioner rsync
      # It will synchronize between the same source and destination
      config.vm.synced_folder tmpdir, '/vagrant', type: 'nfs', nfs_version:4
      config.vm.synced_folder tmpdir, '/vagrant-puppet', type: 'nfs', nfs_version:4

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
      # installs fact for `puppet agent --test` cli to work within the vm
      config.vm.provision :shell do |s|
        s.path = install_facts_script_path
        s.args = [
          _vm_facts["deployment"],
          _vm_facts["subnet"]
        ]
      end

      if vm_props[:type] == TYPE_MASTER
        config.vm.provision "file", source: "vagrant/puppet_master/", destination: "/tmp/"
        config.vm.provision :shell, :path => "vagrant/puppet_master/prepare_puppet_master.sh"
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
