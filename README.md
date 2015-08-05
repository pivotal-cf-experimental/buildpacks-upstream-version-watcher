
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


## Usage

Primary usage should be through two scripts in the `bin` directory.

The first, `detect-upstream-updates`, will iterate over a set of known
dependencies in `upstream.yml` and check upstream if there are newer
versions available. If newer versions are available, then this script
will print out the detected versions, as well as exit with a nonzero
status code.

The second, `upstream-sanity-check`, is used to check that
`upstream.yml` has a complete set of known dependencies. It will
iterate over the defined buildpacks and rootfses and collect the
declared dependencies, emitting an error message and exiting with
nonzero status code if any are found.



## Metadata

Metadata about each upstream component is stored in the file `upstream.yml`. Here's an example:

A small example of an `upstream.yml`:

```yaml
buildpack:
  foo-buildpack:
    url: https://github.com/foo-co/foo-buildpack
    branch: develop
    dependencies:
      foo-compiler:
        scm-tag: https://github.com/foo-co/foo-compiler
      foo-fighter:
        scm-tag: https://myinternal/gitserver/foo-fighter.git
```


### Format of `upstream.yml`

Top-level keys are either "buildpack" or "rootfs"

A "buildpack" __must__ contain these keys:

- `url` → a URL to a source code repository

A "buildpack" __may__ contain these keys:

- `branch` → the branch that should be used to check `upstream.yml` metadata (default: `master`)

A "buildpack" __should__ contain these keys:

- `dependencies` → a hash of names to more descriptive information (see below)


#### Describing dependencies' release metadata

Each member of `dependencies` may be described by a set of key-value
pairs which describe both __where__ release information is located, as
well as __how__ it is presented.

* `scm-tag` → URL to a source code repository
  Use of this descriptor indicates that tags on a canonical repository will indicate a release has been made.

* ... more to come



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
sensible-yet-boring name, and have not artifically glamorized it with
something unnecessarily clever like "grizzly bear" (who, you might
object, is probably looking downstream for salmon, but whatever).

Yes, this is notable these days. Take heed.


## License

Copyright (c) 2015 Pivotal Software, Inc. All Rights Reserved.

This product is licensed to you under the Apache License, Version 2.0 (the "License").
You may not use this product except in compliance with the License.

This product may include a number of subcomponents with separate copyright notices
and license terms. Your use of these subcomponents is subject to the terms and
conditions of the subcomponent's license, as noted in the LICENSE file.
