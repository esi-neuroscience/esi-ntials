<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Shell Tools and Helpers

The following is a collection of helpers and code snippets for working with the 
Unix shell. All codes have been tested with modern versions of Bash (5.x), most 
things should work out of the box on zsh as well. 

## Collect Functions and Settings In File

Use a dedicated script to set up and collect variables and functions that you 
use in all your codes, see [load_params.sh](./load_params.sh) for details. 

## Use Color-Coded Debug/Info/Warn/Error Messages 

Loading [log.setup](./log.setup) in your scripts, allows you to use "log-levels"
in shell scripts. See [log_msg.sh](./log_msg.sh) for a minimal usage example. 

## Interactive User Queries

The [queries.setup](./queries.setup) script contains function prototypes for 
blocking and non-blocking user-queries (a simple yes/no question as well as a 
"press return to continue" prompt). The usage (and evaluation of return values)
is illustrated in [queries_run.sh](./queries_run.sh). 

## Interactive User Queries

The [queries.setup](./queries.setup) script contains function prototypes for 
blocking and non-blocking user-queries (a simple yes/no question as well as a 
"press return to continue" prompt). The usage (and evaluation of return values)
is illustrated in [queries_run.sh](./queries_run.sh). 

## Handling Strings and Arrays in Bash/Zsh

The script [pass_vars.sh](./pass_vars.sh) uses functions defined in 
[pass.setup](./pass.setup) to illustrate how to (safely) pass arbitrary 
strings to functions and how to make use of arrays for string handling. 

