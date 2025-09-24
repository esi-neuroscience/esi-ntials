#!/usr/bin/env bash
#
# Run tests for database examples
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
#
# SPDX-License-Identifier: MIT
#

# Read parameters from setup file
thisFolder=`dirname "$(readlink -f "$0")"`
source "${thisFolder}/tests.setup"

# Get directory structure
rootFolder=`dirname ${thisFolder}`
dbFolder="${rootFolder}/db"
dbFile="${dbFolder}/dummy.db"

# Clean up remains of previous test runs
rm -f "${dbFile}"

# Test SQLite example
info "Testing SQLite database tuning"

debug "Create empty SQLIte database ${dbFile} database and tune it"
sqlite3 "${dbFile}" < "${dbFolder}/sqlite_tuning.sql"
debug "Done"

# Only test persistent PRAGMAs
jmode=$(echo "PRAGMA journal_mode;" | sqlite3 "${dbFile}")
if [[ "${jmode}" != "wal" ]]; then
    error "Journal mode not set correctly"
fi

# 0 | OFF | 1 | NORMAL | 2 | FULL | 3 | EXTRA;
syncmode=$(echo "PRAGMA synchronous;" | sqlite3 "${dbFile}")
echo "syncmode=$syncmode"
if [[ "${syncmode}" != "2" ]]; then
    warn "Synchronous mode not set correctly"
    fail=1
fi
busyto=$(echo "PRAGMA busy_timeout;" | sqlite3 "${dbFile}")
echo "busyto=$busyto"
if [[ "${busyto}" != "5000" ]]; then
    warn "DB lock timeout not set correctly"
fi
csize=$(echo "PRAGMA cache_size;" | sqlite3 "${dbFile}")
if [[ "${csize}" != "-20000" ]]; then
    warn "Cache size not set correctly"
fi
fkeys=$(echo "PRAGMA foreign_keys;" | sqlite3 "${dbFile}")
if [[ "${fkeys}" != "ON" ]]; then
    warn "Foreign keys not enabled"
fi
autovac=$(echo "PRAGMA auto_vacuum;" | sqlite3 "${dbFile}")
if [[ "${autovac}" != "INCREMENTAL" ]]; then
    warn "Auto vacuuming mode not set correctly"
fi
tstore=$(echo "PRAGMA temp_store;" | sqlite3 "${dbFile}")
if [[ "${tstore}" != "MEMORY" ]]; then
    warn "Temporary storage location not set correctly"
fi
msize=$(echo "PRAGMA mmap_size;" | sqlite3 "${dbFile}")
if [[ "${msize}" != "2147483648" ]]; then
    warn "Memory-mapping size not set correctly"
fi
psize=$(echo "PRAGMA page_size;" | sqlite3 "${dbFile}")
if [[ "${psize}" != "8192" ]]; then
    warn "Page size not set correctly"
fi

if [[ -n "${fail-}" ]]; then
    error "asdf"
    exit 1
fi

passed "Database ${dbFile} has been tuned successfully"

exit 0
