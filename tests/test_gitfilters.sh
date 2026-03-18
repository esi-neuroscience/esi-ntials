#!/usr/bin/env bash
#
# Run tests for git-filter example
#
# Copyright © 2026 Ernst Strüngmann Institute (ESI) of the Max Planck Society
#
# SPDX-License-Identifier: MIT

# Exit right away if a command returns non-zero status.
set -e

# Read parameters from setup file
thisFolder=`dirname "$(readlink -f "$0")"`
source "${thisFolder}/tests.setup"

# Get repo directory structure
rootFolder=`dirname ${thisFolder}`
gitexamplefolder="${rootFolder}/config/git_filters"

# Target location for dummy repo
testdir="${HOME}/test-repo"

# Create and populate dummy repo
mkdir "${testdir}"
cp -r "${gitexamplefolder}/." "${testdir}/"

# Initialize empty git repo and apply + test filter
pushd "${testdir}" 1>/dev/null
git init
git config user.name "Luke Skywalker"
git config user.email luke.skywalker@rebels.org
git add .gitattributes .gitconfig
git commit -m "initial commit"
git config --local include.path ../.gitconfig
git add settings.json
git commit -m "test commit"
git cat-file -p HEAD:settings.json | grep -Fq "api-key" || error "Key has not been filtered!" | exit 1
cat settings.json  | grep -Fq "my_super_secret_key" || error "Key was removed from original file!" | exit 1
popd 1>/dev/null

passed "Git filter has been applied successfully"

# Cleanup
rm -rf "${testdir}"
exit 0
