<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society
Copyright © 2026 Ernst Strüngmann Institute (ESI) of the Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Database Configuration and Setup

Things to help set up and run a database (and avoid some common pitfalls while doing so). 

## SQLite Tuning

Use [this SQL script](./sqlite_tuning.sql) to speed up your SQLite database:

``` shell
sqlite3 /path/to/you/database.db < sqlite_tuning.sql
```

The script is based on a [blog post](https://briandouglas.ie/sqlite-defaults/) by Brian Douglas. 
Note that most `PRAGMA` statements only affect the current database connection and 
need to be re-applied whenever the database has been opened. Conversely, some 
`PRAGMA`s cannot be changed after database creation, so they need to be executed 
*before* the first actual write to the database (see the comments in 
[sqlite_tuning.sql](./sqlite_tuning.sql) for more details). 
