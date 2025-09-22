#!/usr/bin/env python3
#
# Exemplary script illustrating usage of customized logging
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
#
# SPDX-License-Identifier: MIT
#

# System packages
import sys
import logging
from pathlib import Path

# Local imports
sys.path.insert(0, {Path(__file__).parent.resolve()})
from log_setup import log, __logfile__


# Helper to set up logger with correct log-level
def prepare_log(
        verbose : bool) -> None:
    """
    Set up logging system
    """

    # Set logging verbosity based on `verbose` flag
    if verbose is True:
        loglvl = logging.DEBUG
    else:
        loglvl = logging.INFO
    log.setLevel(loglvl)
    for h in log.handlers:
        h.setLevel(loglvl)
    log.debug("Set up logging handlers")

    return

# Dummy function for illustration
def my_func(x, y):
    log.debug("We're here")
    log.info("We're doing something with x=%s and y=%s", str(x), str(y))
    z = x + y
    log.debug("We're returning")
    return z


# Now actually do something
if __name__ == "__main__":

    prepare_log(True)
    log.announce("This is %s!", Path(__file__).name)
    log.debug("Preparing to call function...")
    my_func(2, 3)
    log.info("Done!")
    prepare_log(False)
    log.warning("Debug flag is turned off!")
    my_func(2, 3)
    log.error("Something bad happened")

    print(f"\nShowing contents of log-file {__logfile__}\n")
    with open(__logfile__, "rt") as lf:
        print(lf.read())
