# docker-init

Creates a basic Docker with some useful (sane?) defaults, using various "minimum" parent images from Docker Hub: Debian, Alpine or Centos.
For my definition of "useful" of course.

This also includes some scripts inside tools/ and init/

## `init/initialise-docker-image`

Initialises the image by updating the package-index caches, and adding some default packages, e.g. `ca-certificates`, `curl` and `runit`.

## `init/create-app-user`

Creates an `app` user for use when running as a container.

_NOTE:_ It's not usually a good idea to run tools as Root, as privilege-escalations keep getting discovered, and rootless mode is still a little experimental in some contexts.

## `tools/add-*-repo`

Adds a APT or DNF repo to the internal index cache.

## `tools/install-*-packages`

Installs the given package.
It also updates the package-index cache before running, and then empties them out afterwards to conserve space in the image.

Therefore, it's a good idea to try to install all the packages in one command-line, if possible.

## `tools/errors-lib.sh`

A simple error/logging library for the other shell scripts.

# TODO

Convert the scripts to Go, to more-easily support failures, logging, help, etc.
