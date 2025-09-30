<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Shell Tools and Helpers

The following is a collection of helpers and code snippets for working with the 
Unix shell. All codes have been tested with modern versions of Bash (5.x), most 
things should work out of the box on zsh as well. 

## Use a Setup File

Use a dedicated script to set up and collect variables and functions that you 
use in all your codes. The script [load_params.sh](./load_params.sh) loads 
variables and functions defined in [params.setup](./params.setup). Thus, everything 
collected in [params.setup](./params.setup) can be re-used in any other script 
as well. 

## Use Color-Coded Debug/Info/Warn/Error Messages 

Loading [log.setup](./log.setup) in your scripts, allows you to use "log-levels"
in shell scripts. See [log_msg.sh](./log_msg.sh) for a minimal usage example. 

## Interactive User Queries

The [queries.setup](./queries.setup) file contains function prototypes for 
blocking and non-blocking user-queries (a simple yes/no question as well as a 
"press return to continue" prompt). The usage (and evaluation of return values)
is illustrated in [queries_run.sh](./queries_run.sh). 

## Handling Strings and Arrays in Bash/Zsh

The script [pass_vars.sh](./pass_vars.sh) uses functions defined in 
[pass.setup](./pass.setup) to illustrate how to (safely) pass arbitrary 
strings to functions and how to make use of arrays for string handling. 

## Perform File Operations With `rsync`

The script [rsync_examples.sh](./rsync/rsync_examples.sh) illustrates common 
`rsync` use cases by means of some impromptu local file-copy operations. Just run 
the script and see what happens!

