#!/usr/bin/env python3
#
# Run Python-specific tests
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
# Copyright © 2026 Ernst Strüngmann Institute (ESI) of the Max Planck Society
#
# SPDX-License-Identifier: MIT
#

# System packages
import pytest
import runpy
import sys
from pathlib import Path

# Globally define location of Python examples
pydir = f"{Path(__file__).parent.parent.resolve()}/python"

# Remove potentially existing log-file generated in previous runs
Path("./my_custom.log").unlink(missing_ok=True)

# Local imports
sys.path.insert(0, pydir)
from log_setup import __logfile__


# Test proper functionality of logging example
def test_logger(capfd, caplog):

    # Run script and capture log + stdout
    runpy.run_path(f"{pydir}/log_msg.py", run_name="__main__")
    out, _ = capfd.readouterr()

    # Check captured log
    for lvl in ["DEBUG", "INFO", "ANNOUNCE", "WARNING", "ERROR"]:
        assert lvl in caplog.text
    assert "Set up logging handlers" in caplog.text
    assert "This is log_msg.py!" in caplog.text
    assert "We're doing something with x=2 and y=3" in caplog.text
    assert "Debug flag is turned off!" in caplog.text

    # Check captured stdout
    assert "Showing contents of log-file" in out

    # Compare log-file contents shown in stdout with actual contents
    with open(__logfile__, "rt") as lf:
        filecontents=lf.read().replace("\n", "")
    assert filecontents == "".join(out.split("\n")[3:-2])

    caplog.clear()

    return
