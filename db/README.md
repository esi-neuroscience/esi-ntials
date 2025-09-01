<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society

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
