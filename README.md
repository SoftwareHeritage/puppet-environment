Software Heritage Puppet environment
====================================

This repository contains the metadata for Software Heritage's puppet infrastructure git
repositories.

The repositories are managed using [myrepos][1] (see the .mrconfig file), and the `mr`
command.

[1]: http://myrepos.branchable.com/

As our .mrconfig file contains "untrusted" checkout commands (to setup the upstream
repositories of our mirrors of third-party modules), you need to add the .mrconfig file
to your ~/.mrtrust file:

 readlink -f .mrconfig >> ~/.mrtrust

You can then checkout the repositories using `mr up`.


For periodic updates after initial setup, you can use the `bin/update` helper:

    cd puppet-environment
    bin/update


Module Layout
-------------

We use dynamic environments, and the role/profiles puppet workflow as demonstrated by
the following series of articles:

 - http://garylarizza.com/blog/2014/02/17/puppet-workflow-part-1/
 - http://garylarizza.com/blog/2014/02/17/puppet-workflow-part-2/
 - http://garylarizza.com/blog/2014/02/18/puppet-workflow-part-3/
 - http://garylarizza.com/blog/2014/03/07/puppet-workflow-part-3b/
 - http://garylarizza.com/blog/2014/10/24/puppet-workflows-4-using-hiera-in-anger/

Our main manifests are present in the `swh-site` repository. Each branch of that
repository corresponds to an environment in the puppet workflow presented.

This repository contains the Puppetfile referencing all the modules, the main manifest
file `manifests/site.pp`, and the hiera `data` directory, as well as the two
"site-modules" for `profile`s and `role`s.

Our setup mirrors the git repositories of third-party Puppet modules on the Software
Heritage git server --- this is to avoid reliance on 3rd party *hosting* services in
order to be able to deploy. We add an upstream remote to the repositories through our mr
configuration.

Deployment
----------

Deployment happens on the `pergamon.softwareheritage.org` server, using our custom
deployment script:

 sudo /etc/puppet/environments/production/deploy.sh

This updates the dynamic environments according to the contents of the branches of the
git repository, and the Puppetfile inside. For each third-party module, we pin the
module definition in the Puppetfile to a specific tag or revision.

Our specific deploy script also fetches private repositories and merges them with the
public r10k setup.

Local puppet manifest diffing with octocatalog-diff
---------------------------------------------------

puppet-environment contains the whole scaffolding to be able to use
[octocatalog-diff][2] on our manifests. This allows for quick(er) local iterations while
developing complex puppet manifests. Dependencies

[2]: https://github.com/github/octocatalog-diff

You need the following packages installed on your machine:

    r10k octocatalog-diff puppet

### Running

The `bin/octocatalog-diff` script allows diffing the manifests between two environments
(that is, between two branches of the *swh-site* repository. By default it diffs between
production and staging.

Default usage:

    bin/octocatalog-diff pergamon

Limitations

Our setup for octocatalog-diff doesn't support exported resources, so you won't see your
fancy icinga checks there.

Integration of third party puppet modules
-----------------------------------------

We mirror external repositories to our own forge, to avoid having external dependencies
in our deployment.

In the `swh-site/Puppetfile`, we pin the installation of those modules to the highest
version (that works with our current puppet/facter version), by using the `:ref`
specifier.

### Adding a new external puppet module


In the *puppet-environment* repository, the `bin/import-puppet-module` takes care of the
following tasks:

* Getting metadata from the Puppet forge for the module (description, upstream git URL)
* Cloning the repository
* Creating a mirror repository on the Software Heritage forge, with the proper
  permissions and metadata (notably the Sync to GitHub flag)
* Pushing the clone to the forge
* Updating the `.mrconfig` and `.gitignore` files to know the new repository

To be able to use the script, you need to :

* Be a member of the System Administrators Phabricator group
* Have the Arcanist API key setup
* A pair of python dependencies : `python3-phabricator` and `python3-requests` (pull
  them from testing if needed).

Example usage to pull the `elastic/elasticsearch` module

    bin/import-module elastic-elasticsearch
    git diff # review changes
    git add .mrconfig .gitignore
    git commit -m "Add the elastic/elasticsearch module"
    git push

Once the module is added, you need to register it in `swh-site/Puppetfile`.

You should also check in the module metadata whether any dependencies need importing as
well, which you should do using the same procedure.

### Updating external puppet modules

There's two sides of this coin:

#### Updating our git clone of external puppet modules

The *puppet-environment* `.mrconfig` file has a pullup command which does the right thing.

To update all clones:

    mr -j4 pullup

#### Upgrading external puppet modules

Upgrading external puppet modules happens manually.

In the *puppet-environment* repository, the `bin/check-module-updates` script compares
the Puppetfile and the local clones and lists the available updates. (depends on `ruby
r10k`).

On a staging branch of the *swh-site* repository, update the `:ref` value for the module
in the `Puppetfile` to the latest tag. You can then run `octocatalog-diff` on a few
relevant servers and look for changes.

Deploy workflow
----------------

### Semi-automated

    you@localhost$ # hack on puppet Git repo
    you@localhost$ rake validate
    you@localhost$ git commit
    you@localhost$ git push
    you@localhost$ cd puppet-environment
    you@localhost$ bin/deploy-on machine1 machine2...

Remember to pass `--apt` to `bin/deploy-on` if freshly uploaded Software Heritage
packages are to be deployed. Also, `bin/deploy-on --help` is your friend.

### Manual

    you@localhost$ # hack on puppet Git repo
    you@localhost$ rake validate
    you@localhost$ git commit
    you@localhost$ git push
    you@pergamon$ sudo swh-puppet-master-deploy
    you@machine$ sudo apt-get update # if a new or updated version of a Debian package needs deploying
    you@machine$ sudo swh-puppet-test # to test/review changes
    you@machine$ sudo swh-puppet-apply # to apply

Local tests with vagrant
------------------------

> **_NOTE_**: The vagrant configuration uses a public image generated with packer. See
the dedicated readme[1] in the packer directory for more information to manage this
image.

### Setup


Vagrant tools must be installed.

```
apt install nfs-kernel-server libvirt-daemon-system qemu-kvm vagrant vagrant-libvirt
```

Note: `nfs-kernel-server` is needed to export and share the local /tmp/puppet
  to the vm

Multiple provisioners exist. We will focus on the one packaged within debian,
libvirt for now (we had an history of using this one in the past).

You may have to pin the vagrant version to the stable one (given that we use
the hashicorp repositories for packer and terraform, and tests on more recent
vagrant version failed to work):

```
$ cat /etc/apt/preferences.d/vagrant
Package: vagrant
Pin: release a=stable
Pin-Priority: 999
```

Note that you need to add your user to the `libvirt` group:

```
sudo usermod --append --groups libvirt `whoami`
```

### Usage

#### Prepare the puppet environment

The puppet directory structure needs to be prepared before starting a vm. It can be done
with the ``bin/prepare-vagrant-conf`` script. The script must be run each time a new
commit is done to refresh the code applied on the vms.

The working directory is ``/tmp/puppet``.

```
bin/prepare-vagrant-conf [-b branch]
```

The ``-b`` parameter allows to create a specific puppet environment based on the branch
with the same name.

It allows to test changes on feature branches (The ``environment`` variable in the
Vagrantfile has to be updated accordingly).

**_NOTE_**: This command only uses the **committed files**. The pending changes will not
be included on the configuration.

(**to be confirmed**) By convention, the vagrant names are prefixed by the environment for the core archive servers:
* staging-webapp0
* staging-worker0
* staging-db0
* production-worker0
* production-db0
* ...

#### Status
The status of all the vms present on the vagranfile can be checked with:

```
vagrant status
```

Example:
```
$ vagrant status
Current machine states:

staging-webapp            running (libvirt)
staging-worker0           running (libvirt)
staging-deposit           not created (libvirt)
prod-worker01             not created (libvirt)
test                      poweroff (libvirt)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

#### Start a vm

```
vagrant up <server name>
```

For example to start the worker0 of the staging:

```
$ # update the configuration
$ bin/prepare-vagrant-conf
$ # start the vm
$ vagrant up <vm name>
```

If it's the first time this vm is launched, vagrant will apply the puppet configuration
to init the server.

#### Apply the puppet configuration (through vagrant)

To speedup the tests, a scripts can be used to synchronize the changes made on the
working directories and the puppet configuration directories used by vagrant. This
script avoid to have to commit each change before being able to test it.

In one terminal, execute the preparatory steps:
```
bin/prepare-vagrant-conf
bin/watch-vagrant-conf
```

In another terminal:
```
vagrant rsync <vm-name> && vagrant provision <vm-name>
```

In this case, the configuration will always be up-to-date with the local directories.

> **_NOTE_**: It works for basic changes on the swh-site and data configurations. For
> other changes like declaring a new puppet module, the ``prepare-vagrant-conf`` must be
> called to completely rebuild the configuration.

> **_NOTE_**: The ``watch-vagrant-conf`` script uses inotify and especially the
> ``inotifywait`` command to detect the changes. The package ``inotify-tools`` needs to
> be installed on the local environment.

#### Apply the puppet configuration (standard puppet)

The preparatory steps mentioned in the previous paragraph still applies.

Providing the puppet master node ("pergamon") is up, connect to the vm to update and
execute the puppet agent command:

```
vagrant ssh <vm-name>
vagrant@vm-name$ sudo puppet agent --test
```

#### connect to a vm

A shell can be opened to a running vm with this command:

```
vagrant ssh <vm name>
```

#### Stop a vm

```
vagrant stop <vm name>
```

#### Update the configuration

If the vagrantfile is updated to change a property of a server, like the memory, cpu
configuration or network, the configuration has to be reloaded:

```
vagrant reload <vm name>
```

#### Cleanup

To recover space, the vms can be destroyed with:

```
vagrant destroy <vm name>
```

[1]: [packer/README.md][packer/README.md]
