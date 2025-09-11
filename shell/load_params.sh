#!/usr/bin/env bash
#
# Illustration how to robustly load parameters from a setup file
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
#
# SPDX-License-Identifier: MIT
#

# Read parameters from setup file
# NOTE: use readlink to resolve absolute paths and follow symlinks
thisFolder=`dirname "$(readlink -f "$0")"`
source "${thisFolder}/params.setup"

# Access externally defined variable
echo "This is $(basename $0) version ${semver} (${calver})"

# Invoke externally defined function
print_input "We begin here"

# Invoke externally defined function with external variable
print_input "${myarray[@]}"

# Invoke externally defined function
print_input "And and there"

exit 0
