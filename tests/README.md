<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Testing Pipeline for Enclosed Examples

The scripts collected in this directory are intended to test all exemplary codes
provided in this repository to ensure all examples can be executed without errors. 

## Running Tests 

The helper script [run_tests.sh](./run_tests.sh) can be used to run the entire test 
suite or only a subset of tests. Executing `run_tests.sh` without arguments prints 
its help text that explains its usage. For instance, running

``` shell
run_tests.sh shell --debug
```

only tests exemplary scripts in the `shell` sub-directory and prints debug output. 
Alternatively, the respective shell-testing script can be launched directly as 
well 

``` shell
test_shell.sh
```

Testing Python examples requires `pytest` (included in the corresponding conda 
environment file [conda_env.yml](../python/conda_env.yml)). 
