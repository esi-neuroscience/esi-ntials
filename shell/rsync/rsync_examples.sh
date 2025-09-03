#!/usr/bin/env bash
#
# Common rsync usage patterns
#
# Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience
# in Cooperation with Max Planck Society
# Copyright © 2009-present, Homebrew contributors
#
# SPDX-License-Identifier: MIT
#

# Cleaning up remains of potential previous runs
rm filelist.txt
rm -rf dir1/
rm -rf dir2/
rm -rf dir3/

# Start by creating dummy directories so that we have something to copy
echo "Creating local dummy directoriy tree"
mkdir -p dir1/sourcedir
mkdir -p dir2
mkdir -p dir3

# Create files in `sourcedir` that will be copied
echo "Filling it with stub files"
for i in $(seq 1 20); do
    touch "dir1/sourcedir/file${i}.txt"
done

# Create a text-file with paths to all odd-numbered files in `sourcedir`
echo "Creating file-list to be copied"
touch filelist.txt
for i in $(seq 1 2 20); do
    echo "$(realpath $(dirname $0))/dir1/sourcedir/file${i}.txt" >> filelist.txt
done

echo "Running EXAMPLE 1..."
# ===========================================================================
# EXAMPLE 1:
#              Copy `sourcedir` into `dir2`
#
# NOTE: No traliing slash after `sourcedir1` means: copy folder + contents,
#       otherwise rsync copies only its contents!
#
rsync -avhp --progress dir1/sourcedir dir2/
# ===========================================================================

# Check that rsync did what we wanted it to do
echo "Checking for differences between dir1/sourcedir dir2/sourcedir (should be none)"
diff dir1/sourcedir dir2/sourcedir

echo "Running EXAMPLE 2..."
# ===========================================================================
# EXAMPLE 2:
#              Copy entries listed in a text file to given target
#
rsync -avhp --progress "$(cat filelist.txt)" dir3/
# ===========================================================================



