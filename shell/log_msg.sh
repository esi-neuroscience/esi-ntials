#!/usr/bin/env bash
#
# Exemplary use of custom bash logging
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
# Copyright © 2009-present, Homebrew contributors
#
# SPDX-License-Identifier: MIT
#

# Read parameters from settings file
thisFolder=`dirname "$(readlink -f "$0")"`
source "${thisFolder}/log.setup"

debug "This message is not shown"

info "An info message"

warn "A warning message"

announce "A big announcement!"

# Enable debug logging
debugflag=1

debug "This message is shown"

# Set up log file
log="./tmp.log"

info "This messages is printed and logged to ${log}"

error "Crash with an error"
