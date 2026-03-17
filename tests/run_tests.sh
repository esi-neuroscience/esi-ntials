#!/usr/bin/env bash
#
# Helper script to run all/specific tests
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

# Help text
usage="
$(basename "$0") [--help] all|db|python|shell [--debug]

usage:

    $(basename "$0") all [--debug]
    $(basename "$0") db [--debug]
    $(basename "$0") python [--debug]
    $(basename "$0") shell [--debug]

Run test-suite for provided examples.

Arguments:
    all              execute entire test suite
    db               run tests for database examples
    python           run tests for Python examples
    shell            run tests for shell examples
    --debug          OPTIONAL: enable debug output
    --help           OPTIONAL: show this help message and exit

Examples:
    $(basename "$0") all
        Runs entire test-suite
    $(basename "$0") all --debug
        Runs entire test-suite with debug output (very verbose)
    $(basename "$0") shell
        Only run tests for shell examples

For additional support, please open an issue at https://github.com/esi-neuroscience/esi-ntials/issues/new
"

# In case no input was found, print help message and exit
if [ "$1" = "" ]; then
    echo "$usage"
    exit 0
fi

# Parse any provided options
optArray=()
while :; do
    case "$1" in
        "")
            break
            ;;
        all)
	        optArray+=("all")
            ;;
        db)
	        optArray+=("db")
            ;;
        python)
	        optArray+=("python")
            ;;
        shell)
	        optArray+=("shell")
            ;;
        --help)
	        optArray+=("help")
            ;;
        --debug)
	        export testsdebug=1
            ;;
    esac
    shift
done

# Parse mutually exclusive CLI args
if [[ "${#optArray[@]}" -gt 1 ]]; then
    echo "ERROR: Too many options provided"
    exit 1
fi
if [[ "${#optArray[@]}" -lt 1 ]]; then
    echo "ERROR: At least one option required"
    exit 1
fi

# Check if we're in a GitHub action
if [[ ! -z "${GHCI-}" ]]; then
    info "Running inside CI pipeline"
else
    info "Running in interactive mode"
    if [[ -z "${CONDA_PYTHON_EXE-}" ]]; then
        warn "Could not find conda installation!"
    else
        condaroot=`dirname $(dirname "${CONDA_PYTHON_EXE}")`
        source "${condaroot}/etc/profile.d/conda.sh"
        conda activate esi-ntials
    fi
fi

# Execute appropriate testing command
for option in "${optArray[@]}"; do
    if [[ "${option}" == "help" ]]; then
        echo "${usage}"
    elif [[ "${option}" == "all" ]]; then
        "${thisFolder}/test_db.sh"
        "${thisFolder}/test_shell.sh"
        pytest --color=yes --tb=short --verbose "${thisFolder}/test_python.py"
    elif [[ "${option}" == "db" ]]; then
        "${thisFolder}/test_db.sh"
    elif [[ "${option}" == "python" ]]; then
        pytest --color=yes --tb=short --verbose "${thisFolder}/test_python.py"
    elif [[ "${option}" == "shell" ]]; then
        "${thisFolder}/test_shell.sh"
    fi
done

exit 0
