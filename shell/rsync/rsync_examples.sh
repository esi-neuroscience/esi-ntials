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

# Abort on errors
set -e

# Ensure script is run inside shell/rsync directory
thisFolder=`dirname "$(readlink -f "$0")"`
echo "thisfolder=$thisFolder"
pushd "${thisFolder}"
if [[ "$(pwd)" != "${thisFolder}" ]]; then
    echo "Could not change to working directory ${thisFolder}. Exiting..."
    exit 1
fi

# Cleaning up remains of potential previous runs
echo "_________________________________________________________________________"
echo "Cleaning up potential leftovers from previous runs"
rm -f filelist.txt
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
    echo "${thisFolder}/dir1/sourcedir/file${i}.txt" >> filelist.txt
done

echo "_________________________________________________________________________"
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
echo ""
echo "Checking for differences between dir1/sourcedir dir2/sourcedir (should be none)"
diff dir1/sourcedir dir2/sourcedir
if [ $? -ne 0 ]; then
    echo "ERROR: Sync did not work. Exiting..."
    exit 1
else
    echo "SUCCESS!"
fi

echo "_________________________________________________________________________"
echo "Running EXAMPLE 2..."
# ===========================================================================
# EXAMPLE 2:
#              Copy entries listed in a text file to given target
#
rsync -avhp --progress `cat filelist.txt` dir3/
# ===========================================================================

# Check that only the files listed in filelist.txt were copied
echo ""
echo "Checking for copied files in target directory"
if ((BASH_VERSINFO >= 4)); then
    readarray -t filearr < filelist.txt                # use `readarray` on modern Linux
else
    IFS=$'\n' read -d '' -r -a filearr < filelist.txt  # read `read` in old bash (e.g., macOS)
fi

for fullname in "${filearr[@]}"; do
    filename="$(basename ${fullname})"
    if [ ! -f "dir3/${filename}" ]; then
        echo "ERROR: ${filename} is missing!"
        exit 1
    else
        echo "File ${filename} has been synced"
    fi
done
echo "SUCCESS!"
echo ""

echo "_________________________________________________________________________"
echo "Running EXAMPLE 3..."
# ===========================================================================
# EXAMPLE 3:
#              Show how to modify Example 1 for remote source/target
#
echo ""
echo "To copy from remote to local, use:"
echo ""
echo "rsync -avhp --progress user@remote:/full/path/to/dir1/sourcedir dir2/"
echo ""
echo "To copy from local to remote:"
echo ""
echo "rsync -avhp --progress dir1/sourcedir user@remote:/full/path/to/dir2/"
echo ""
echo "ALL DONE!"
echo ""

# Back to previous working directory
popd

exit 0
