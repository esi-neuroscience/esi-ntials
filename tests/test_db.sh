#!/usr/bin/env bash
#
# Run tests for database examples
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
# Copyright © 2026 Ernst Strüngmann Institute (ESI) of the Max Planck Society
#
# SPDX-License-Identifier: MIT
#

# Exit right away if a command returns non-zero status.
set -e

# Read parameters from setup file
thisFolder=`dirname "$(readlink -f "$0")"`
source "${thisFolder}/tests.setup"

# Get directory structure
rootFolder=`dirname ${thisFolder}`
dbFolder="${rootFolder}/db"
dbFile="${dbFolder}/dummy.db"

# Clean up remains of potentially failed previous test runs
rm -f "${dbFile}"

# Test SQLite example
info "Testing SQLite database tuning"

debug "Create empty SQLIte database ${dbFile} database and tune it"
sqlite3 "${dbFile}" < "${dbFolder}/sqlite_tuning.sql" > /dev/null
debug "Done"

# Only test persistent PRAGMAs
debug "Testing journal_mode"
jmode=$(echo "PRAGMA journal_mode;" | sqlite3 "${dbFile}")
if [[ "${jmode}" != "wal" ]]; then
    warn "Journal mode not set correctly"
    fail=1
fi
debug "Done"

debug "Testing auto_vacuum setting"
autovac=$(echo "PRAGMA auto_vacuum;" | sqlite3 "${dbFile}")
if [[ "${autovac}" != "2" ]]; then  # 0 | NONE | 1 | FULL | 2 | INCREMENTAL;
    warn "Auto vacuuming mode not set correctly"
    fail=1
fi
debug "Done"

debug "Testing page_size"
psize=$(echo "PRAGMA page_size;" | sqlite3 "${dbFile}")
if [[ "${psize}" != "8192" ]]; then
    warn "Page size not set correctly"
    fail=1
fi
debug "Done"

# If any persistent setting was not applied, the test failed
if [[ -n "${fail-}" ]]; then
    error "Database settings of ${dbFile} not applied correctly"
    exit 1
fi

passed "Database ${dbFile} has been tuned successfully"

# Cleanup
rm -f "${dbFile}"

exit 0
