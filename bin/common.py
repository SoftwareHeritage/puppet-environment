# Copyright (C) 2018-2025  The Software Heritage developers
# See the AUTHORS file at the top-level directory of this distribution
# License: GNU General Public License version 3, or any later version
# See top-level LICENSE file for more information

import copy
import os
import subprocess
import time

from gitlab.exceptions import GitlabGetError

GITLAB_REPO_NAMESPACE = "swh/infra/puppet/3rdparty"
GITLAB_REPO_ATTRIBUTES = {
    "visibility": "public",
    "initialize_with_readme": False,
    "auto_devops_enabled": False,
    "packages_enabled": False,
    "analytics_access_level": "disabled",
    "builds_access_level": "disabled",
    "container_registry_access_level": "disabled",
    "environments_access_level": "disabled",
    "feature_flags_access_level": "disabled",
    "infrastructure_access_level": "disabled",
    "issues_access_level": "disabled",
    "model_experiments_access_level": "disabled",
    "model_registry_access_level": "disabled",
    "monitor_access_level": "disabled",
    "pages_access_level": "disabled",
    "requirements_access_level": "disabled",
    "security_and_compliance_access_level": "disabled",
    "snippets_access_level": "disabled",
    "wiki_access_level": "disabled",
}


def create_gitlab_repo(gl, module_name, release_metadata=None, upstream_forge_url=None):
    try:
        repo = gl.projects.get(f"{GITLAB_REPO_NAMESPACE}/{module_name}")
        return repo
    except GitlabGetError:
        pass

    gitlab_data = copy.deepcopy(GITLAB_REPO_ATTRIBUTES)

    if release_metadata:
        upstream_repo = release_metadata["source"]
        upstream_forge_url = upstream_forge_url or ""
        gitlab_data["description"] = f"Mirror of {upstream_repo} ({upstream_forge_url})"

    gitlab_data["path"] = module_name

    group_id = gl.groups.get(GITLAB_REPO_NAMESPACE).id

    gitlab_data["namespace_id"] = group_id
    return gl.projects.create(gitlab_data)


def wait_gitlab_repo(gl, repo):
    """Wait for the given repository to be ready."""
    backoff = 0.5
    while True:
        repo = gl.projects.get(repo.id)
        if repo.import_status in ("finished", "none"):
            break
        print(
            f"Repository {repo.path} still importing, sleeping for {backoff} seconds..."
        )
        time.sleep(backoff)
        backoff = min(backoff * 2, 15.0)


def clone_and_push_repo(
    module_name,
    swh_repo,
    upstream_repo,
    default_branch="master",
    skip_clone=False,
):
    """Clone SWH repository, add the upstream remote and push to SWH."""
    if not skip_clone:
        subprocess.check_call(["git", "clone", swh_repo, module_name])
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
