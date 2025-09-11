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

# Read parameters from setup file
thisFolder=`dirname "$(readlink -f "$0")"`
source "${thisFolder}/queries.setup"

echo "We're now asking a simple yes/no question..."

user_yesno "Do you like Pizza?"
if [ $? -eq 1 ]; then
    echo "Obviously..."
else
    echo "Who doesn't like Pizza?!"
fi

user_input

echo "This message is only displayed if the user pressed the RETURN key before"

exit 0
