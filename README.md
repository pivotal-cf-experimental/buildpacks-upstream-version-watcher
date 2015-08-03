
# CF Buildpacks Upstream Version Watcher

Or, __BUVW__.


## Overview / What's the point?

The buildpacks team is responsible for responding in a timely manner
to any upstream updates that are included in either the buildpacks
themselves, or in the rootfs.

This project is an attempt to automate detection of, and response to,
upstream updates.

    As a Cloud Foundry user,
    I want the Buildpacks and RootFS to be as up-to-date as possible,
    So that my CF deployment is usable, stable, and secure.

    As a Buildpacks team member,
    I want to be automatically notified if there are updates to upstream packages,
    So that, every time, I can update Buildpacks and RootFS within the declared SLA.


## Metadata

Metadata about each upstream component is stored in the file `upstream.yml`.

### Format of `upstream.yml`

Top-level keys are either "buildpack" or "rootfs"

A "buildpack" must contain these keys:

- `git` → a git URL

A "buildpack" may contain these keys:

- `branch` → the branch that should be used to check `upstream.yml` metadata (default: `master`)



## Metametadata

A metadata sanity check, `upstream-sanity-checker`, runs to make sure
that any upstream dependencies that are added or removed to the
buildpacks or rootfs are present in `upstream.yml`.

For example, if we added support for Rubinius to the Ruby Buildpack,
then `upstream-sanity-checker`, when run, should detect that there's a
new name in `ruby-buildpack/manifest.yml` that's not present in `upstream.yml`.


## Tracker

If you'd like to create stories in Tracker, then set `TRACKER_PROJECT`
and `TRACKER_TOKEN` environment variables.


## Storing State / Receipts

BUVW just keeps receipts on disk in the `receipts` directory, so
git-commit after a successful run.


## Features

* create Tracker story when a new buildpack dependency is detected
* create Tracker story for each new upstream release of a buildpack dependency
* track a receipt for each upstream buildpack dependency
* create Tracker story for each update to an Ubuntu package due to a CVE


## Possible Future Features

* detect when an upstream release of a buildpack dependency is related to a CVE, and tag the Tracker story with `security`


## Clever Names Considered Harmful

You'll note that I have given this sensible-yet-boring software a
sensible-yet-boring name, and notably have not artifically glamorized
with something unnecessarily clever like "grizzly bear". Yes, this is
notable these days. Take heed.

