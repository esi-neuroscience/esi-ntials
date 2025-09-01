<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Shell Tools and Helpers

The following is a collection of helpers and code snippets for working with the 
Unix shell. All codes have been tested with modern versions of Bash (5.x). 

## Collect Functions and Settings In File

Use a dedicated script to set up and collect variables and functions that you 
use in all your codes, see [load_params.sh](./load_params.sh) for details. 

## Use Color-Coded Debug/Info/Warn/Error Messages 

Loading [log.setup](./log.setup) in your scripts, allows you to use "log-levels"
in shell scripts. See [log_msg.sh](./log_msg.sh) for a minimal usage example. 
