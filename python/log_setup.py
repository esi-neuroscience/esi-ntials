#
# Module for setting up logging facilities
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
# Copyright © 2026 Ernst Strüngmann Institute (ESI) of the Max Planck Society
#
# SPDX-License-Identifier: MIT
#

# System packages
import logging
from pathlib import Path
from typing import Any

# Globals used to set up logger
__logname__ = "mycustomlogger"
__logfile__ = Path("./my_custom.log").resolve()


def announce(
        self,
        msg: str,
        *args: Any,
        **kwargs: Any | None) -> None:
    """
    Log 'msg % args' with severity 'ANNOUNCE'.

    To pass exception information, use the keyword argument exc_info with
    a true value, e.g.

    logger.announce("Houston, we have a %s", "thorny problem", exc_info=1)
    """
    if self.isEnabledFor(announceLvl):
        self._log(announceLvl, msg, args, **kwargs)
    return


class CustomLogFormatter(logging.Formatter):
    """
    Adapted from ACME logger: https://github.com/esi-neuroscience/acme/blob/main/acme/logger.py


    Parameters
    ----------
    fmt : str
        Format string to pass to Python's `logging.Formatter`
    datefmt : str or None
        Format string for date/time portion of the logged output passed to Python's
        `logging.formatter`. Default is to use current data and hour-minute-second.
    color : bool or None
        If `True`, use colorized logging output (default).

    Returns
    -------
    log : logging.Formater subclass
        Instance of customized logging.Formatter

    Notes
    -----
    Code adapted from ACME logger: https://github.com/esi-neuroscience/acme/blob/main/acme/logger.py
    """

    def __init__(
            self,
            fmt: str,
            datefmt : str = "%Y-%m-%d %H:%M:%S",
            color: bool = True):

        super().__init__()

        if color:
            green = "\x1b[92m"
            gray = "\x1b[90m"
            blue = "\x1b[38;5;39m"
            magenta = "\x1b[35m"
            red = "\x1b[38;5;196m"
            bold = "\x1b[1m"
            reset = "\x1b[0m"
        else:
            green = ""
            gray = ""
            blue = ""
            magenta = ""
            red = ""
            bold = ""
            reset = ""

        fmtName = fmt.partition("%(name)s")
        fmtName = fmtName[0] + bold + fmtName[1] + reset + fmtName[2]   # type: ignore
        fmt = "".join(fmtName)

        fmtLvl = fmt.partition("%(levelname)s")
        fmtDebug = fmtLvl[0] + bold + green + \
            "# " + fmtLvl[1] + " #" + reset + gray + fmtLvl[2] + reset
        fmtInfo = fmtLvl[0] + bold + blue + \
            "- " + fmtLvl[1] + " -" + reset + fmtLvl[2]
        fmtAnnounce = fmtLvl[0] + bold + blue + \
            "> " + fmtLvl[1] + " <" + reset + bold + fmtLvl[2] + reset
        fmtWarn = fmtLvl[0] + bold + magenta + \
            "! " + fmtLvl[1] + " !" + reset + fmtLvl[2]
        fmtError = fmtLvl[0] + bold + red + \
            "| " + fmtLvl[1] + " |" + reset + red + fmtLvl[2] + reset

        fmtAnnounce = "".join(fmtAnnounce).replace("<%(funcName)s>", "")
        fmtInfo = "".join(fmtInfo).replace("<%(funcName)s>", "")

        self.FORMATS = {
            logging.DEBUG: "".join(fmtDebug),
            logging.INFO: "".join(fmtInfo),
            logging.ANNOUNCE: "".join(fmtAnnounce),
            logging.WARNING: "".join(fmtWarn),
            logging.ERROR: "".join(fmtError),
            logging.CRITICAL: "".join(fmtError),
        }
        self.datefmt = datefmt

    def format(
            self,
            record: logging.LogRecord):
        logFmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(logFmt, datefmt=self.datefmt)
        return formatter.format(record)


# Add custom "announce" level to logger class
announceLvl = logging.INFO + 5
logging.addLevelName(announceLvl, "ANNOUNCE")
logging.ANNOUNCE = announceLvl
logging.getLoggerClass().announce = announce
logging.announce = announce

# Fetch/set up our custom logger
log = logging.getLogger(__logname__)

# Create logging formatters:
# use colored log messages only when printing to stdout,
# disable colors when writing to log file
customFmt = "%(asctime)s %(name)s %(levelname)s <%(funcName)s> %(message)s"
streamFrmt = CustomLogFormatter(customFmt, color=True)
fileFrmt = CustomLogFormatter(customFmt, color=False)

# Upon first invocation set up logging handlers
if len(log.handlers) == 0:
    stdoutHandler = logging.StreamHandler()
    stdoutHandler.setFormatter(streamFrmt)
    log.addHandler(stdoutHandler)
    fileHandler = logging.FileHandler(__logfile__)
    fileHandler.setFormatter(fileFrmt)
    log.addHandler(fileHandler)
