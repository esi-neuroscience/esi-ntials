#!/usr/bin/env bash
#
# Illustration how to robustly pass strings/arrays to functions
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
#
# SPDX-License-Identifier: MIT
#

# Load externally defined functions
thisFolder=`dirname "$(readlink -f "$0")"`
source "${thisFolder}/pass.setup"

# Name of text file used later
txtfile="dummy.txt"

# Cleaning up remains of potential previous runs
rm -f "${txtfile}"

# First, define a variable containing an (almost) arbitrarily convoluted string
mymsg="This is a very long string with     spaces and !@#$%^&*() symbols"

# Define a bash array
myarray=("this" "array" "contains" "lots" "of" "words")

# Pass the string to our external function
process_all "${mymsg}"

# Pass our array to our external function
# NOTE: the array is converted to a string in `process_all`
process_all "${myarray[@]}"

# Pass only the second element to the function
process_all "${myarray[1]}"

# Now pass only second to last elements to the function
process_all "${myarray[@]:1}"

# Next, we use a function that has been written to process arrays
# NOTE: any input is converted to an array by `process_arrays`
process_arrays "${myarray[@]}"

# Pass only the second element to the function
process_arrays "${myarray[1]}"

# Now pass only second to last elements to the function
process_arrays "${myarray[@]:1}"

# Create a temporary text file
echo "Creating temporary text file ${txtfile}"
touch "${txtfile}"
echo "Writing ten lines to it"
for i in $(seq 1 10); do
    echo "Number ${i}" >> "${txtfile}"
done

# Read lines from the file to a bash array
echo "Store each line as element of an array"
readarray -t newarray < "${txtfile}"

# Use external function to evaluate the array
process_arrays "${newarray[@]}"

# Loop over array manually
echo "Looping over the array: "
for word in "${newarray[@]}"; do
    echo ">>> ${word}"
done

exit 0
