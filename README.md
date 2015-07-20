Software Heritage Puppet environment
====================================

This repository contains the metadata for Software Heritage's
puppet infrastructure git repositories.

The repositories are managed using [myrepos][1] (see the .mrconfig file), and
the `mr` command.

[1]: http://myrepos.branchable.com/

As our .mrconfig file contains "untrusted" checkout commands (to setup
the upstream repositories of our mirrors of third-party modules), you
need to add the .mrconfig file to your ~/.mrtrust file:

 readlink -f .mrconfig >> ~/.mrtrust
 
You can then checkout the repositories using `mr up`.

Module Layout
-------------

We use dynamic environments, and the role/profiles puppet workflow as
demonstrated by the following series of articles:

 - http://garylarizza.com/blog/2014/02/17/puppet-workflow-part-1/
 - http://garylarizza.com/blog/2014/02/17/puppet-workflow-part-2/
 - http://garylarizza.com/blog/2014/02/18/puppet-workflow-part-3/
 - http://garylarizza.com/blog/2014/03/07/puppet-workflow-part-3b/
 - http://garylarizza.com/blog/2014/10/24/puppet-workflows-4-using-hiera-in-anger/

Our main manifests are present in the `swh-site` repository. Each branch
of that repository corresponds to an environment. The default
environment is `production`. This repository contains the Puppetfile
referencing all the modules, the main manifest file `manifests/site.pp`,
and the hiera `data` directory.

Roles of Software Heritage servers are defined in the `swh-role` module.
Profiles are defined in the `swh-profile` module.

Our setup mirrors the git repositories of third-party Puppet modules on
the Software Heritage git server. We add an upstream remote to the
repositories through our mr configuration.

Deployment
----------

Deployment happens on the `pergamon.softwareheritage.org` server, using
the r10k command:

 sudo r10k deploy environment --puppetfile
 
This updates the dynamic environments according to the contents of the
branches of the git repository, and the Puppetfile inside. For each
third-party module, we pin the module definition in the Puppetfile to a
specific tag or revision.
