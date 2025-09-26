#!/usr/bin/env bash
#
# Run tests for shell examples
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
#
# SPDX-License-Identifier: MIT
#

# Read parameters from setup file
thisFolder=`dirname "$(readlink -f "$0")"`
source "${thisFolder}/tests.setup"

# Get directory structure and set up tmp file to capture stdout
rootFolder=`dirname ${thisFolder}`
shellFolder="${rootFolder}/shell"
tmpout="${shellFolder}/tmp.txt"

# Clean up remains of potentially failed previous test runs
rm -f "${tmpout}"

# Start testing pipeline
info "Testing load_params.sh...."
"${shellFolder}/load_params.sh" > "${tmpout}"

datename=$(date +"%Y-%m-%d")
debug "Testing correct write of header"
grep -qw "This is load_params.sh version" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "Expected initial header write not found"
    fail=1
fi
debug "Done"
debug "Testing correct write of first line"
grep -qw "${datename}.*We begin here" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "Expected first 'print_input' write not found"
    fail=1
fi
debug "Done"
debug "Testing correct write of second line"
grep -qw "${datename}.*first second third" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "Expected second 'print_input' write not found"
    fail=1
fi
debug "Done"
debug "Testing correct write of third line"
grep -qw "${datename}.*And end there" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "Expected third 'print_input' write not found"
    fail=1
fi
debug "Done"

# If any line has not been printed, the test failed
if [[ -n "${fail-}" ]]; then
    error "Running load_params.sh did not print expected output"
    exit 1
fi

passed "Executed load_params.sh successfully"

exit 0
