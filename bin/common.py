# Copyright (C) 2018-2021  The Software Heritage developers
# See the AUTHORS file at the top-level directory of this distribution
# License: GNU General Public License version 3, or any later version
# See top-level LICENSE file for more information

import os
import subprocess
import time
import copy


PHABRICATOR_EDITORS = "PHID-PROJ-w6dmg2vssgiimpjpduga"  # System administrators
PHABRICATOR_TAGS = [
    "PHID-PROJ-ailxer42p4nlkaikyhlo",  # Language-puppet
    "PHID-PROJ-ximqdentnggqkdbc2ycg",  # Sync to GitHub
    "PHID-PROJ-w6dmg2vssgiimpjpduga",  # System administrators
]
PHABRICATOR_DATA = [
    {"type": "space", "value": "PHID-SPCE-yrejny25ty3jfio326zt"},
    {"type": "vcs", "value": "git"},
    {"type": "status", "value": "active"},
    {"type": "view", "value": "public"},
    {"type": "edit", "value": PHABRICATOR_EDITORS},
    {"type": "policy.push", "value": PHABRICATOR_EDITORS},
    {"type": "projects.set", "value": PHABRICATOR_TAGS},
]

PHABRICATOR_REPO_URL = "https://forge.softwareheritage.org/source/"


def create_phab_repo(
    phabricator, module_name, release_metadata=None, upstream_forge_url=None
):
    """Create a repository on Software Heritage forge with proper metadata."""
    description = None
    if release_metadata:
        upstream_repo = release_metadata["source"]
        original_description = release_metadata["summary"]
        upstream_forge_url = upstream_forge_url or ""
        description = """\
    {description}
    {upstream_forge_url}
    {upstream_repo}
        """.format(
            description=original_description,
            upstream_forge_url=upstream_forge_url,
            upstream_repo=upstream_repo,
        )

    phabricator_data = copy.deepcopy(PHABRICATOR_DATA)
    phabricator_name = module_name
    phabricator_data.append({"type": "name", "value": phabricator_name})
    phabricator_data.append({"type": "shortName", "value": phabricator_name})
    if description:
        phabricator_data.append({"type": "description", "value": description.strip()})

    return phabricator.diffusion.repository.edit(transactions=phabricator_data)


def wait_phab_repo(phabricator, repo_id):
    """Wait for the repository with the given id to be ready."""
    backoff = 0.5
    while True:
        ret = phabricator.diffusion.repository.search(constraints={"ids": [repo_id]})
        repo = ret.data[0]
        if not repo["fields"]["isImporting"]:
            break
        print(
            f"Repository {repo_id} still importing, sleeping for {backoff} seconds..."
        )
        time.sleep(backoff)
        backoff = min(backoff * 2, 15.0)


def clone_and_push_repo(
    module_name,
    phabricator_repo,
    upstream_repo,
    default_branch="master",
    skip_clone=False,
):
    """Clone SWH repository, add the upstream remote and push to SWH."""
    if not skip_clone:
        subprocess.check_call(["git", "clone", phabricator_repo, module_name])
    os.chdir(module_name)
    try:
        subprocess.check_call(["git", "remote", "add", "upstream", upstream_repo])
    except subprocess.CalledProcessError:
        # already configured, skipping
        pass
    subprocess.check_call(["git", "fetch", "upstream", "--tags"])
    subprocess.check_call(["git", "checkout", default_branch])
    subprocess.check_call(["git", "merge", f"upstream/{default_branch}"])
    subprocess.check_call(
        [
            "git",
            "push",
            "--tags",
            "--set-upstream",
            "origin",
            f"{default_branch}:{default_branch}",
        ]
    )
    os.chdir("..")
