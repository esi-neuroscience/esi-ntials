
-- SQLite performance tweaks, taken from https://briandouglas.ie/sqlite-defaults/

-- Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
-- in Cooperation with Max Planck Society

-- SPDX-License-Identifier: MIT

-- ######################################################################
-- PRAGMA that write directly to the database file; `auto_vacuum` and `page_size`
-- cannot be changed after creation

-- Set the page size to 8KB for balanced memory usage and performance
PRAGMA page_size = 8192;

-- Set the journal mode to Write-Ahead Logging for concurrency
PRAGMA journal_mode = WAL;

-- Enable auto vacuuming and set it to incremental mode for gradual space reclaiming
PRAGMA auto_vacuum = INCREMENTAL;
VACUUM;

-- ######################################################################
-- PRAGMA that only affect current database connections; need to be re-applied
-- whenever the database has been openend

-- Set synchronous mode to NORMAL for performance and data safety balance
PRAGMA synchronous = NORMAL;

-- Set busy timeout to 5 seconds to avoid "database is locked" errors
PRAGMA busy_timeout = 5000;

-- Set cache size to 20MB for faster data access
PRAGMA cache_size = -20000;

-- Enable foreign key constraint enforcement
PRAGMA foreign_keys = ON;

-- Store temporary tables and data in memory for better performance
PRAGMA temp_store = MEMORY;

-- Set the mmap_size to 2GB for faster read/write access using memory-mapped I/O
PRAGMA mmap_size = 2147483648;
