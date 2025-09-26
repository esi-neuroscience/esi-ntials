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

# ----------------------------------------------------------------------
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

# ----------------------------------------------------------------------
info "Testing log_msg.sh...."
log="./tmp.log"
rm -f "${log}"

"${shellFolder}/log_msg.sh" > "${tmpout}"

debug "Ensure that the initial debug message was not printed"
grep -qw "This message is not shown" "${tmpout}"
if [ $? -eq 0 ]; then
    warn "Debug message not hidden"
    fail=1
fi
grep -qw "${datename}.*=== An info message" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "First INFO message not shown"
    fail=1
fi
grep -qw "${datename}.*WARNING: A warning message" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "Initial warning message not shown"
    fail=1
fi
grep -qw ">>> A big announcement! <<<" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "Announcement not shown"
    fail=1
fi
grep -qw "${datename}.*DEBUG: This message is shown" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "Debug message not shown despite enabled 'debugflag'"
    fail=1
fi
grep -qw "${datename}.*=== This messages is printed and logged to ./tmp.log" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "Second info message not shown"
    fail=1
fi
grep -qw "${datename}.*ERROR: Crash with an error" "${tmpout}"
if [ $? -ne 0 ]; then
    warn "Final error message not shown"
    fail=1
fi

grep -qf ./tmp.log shell/tmp.txt
if [ $? -ne 0 ]; then
    warn "Log file not populated"
    fail=1
fi

passed "Executed logging example successfully"

exit 0
