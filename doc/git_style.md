<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society
Copyright © 2026 Ernst Strüngmann Institute (ESI) of the Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Git Style Guide 

A suggestion for keeping Git Commit Message organized is to follow the style guide 
provided here. We use a three-letter tag at the start of a commit message that 
classifies the commit, 

- **FIX**: Bugfix commits
- **CHG**: Changes in functionality
- **NEW**: A new feature/addition
- **REM**: Features/functionality is removed
- **WIP**: For work in progress commits, the code is not functional or in prototype stage
- **DOC**: Additions/changes to documentation

The tag is followed by a subject line and a message "body" which is a bullet list 
of items. 

Each commit should ideally only use a single tag, specifically, you should not 
mix feature additions (**NEW**) and bugfixes (**FIX**). To improve reproducibility 
when working with git's CLI you may want to un-comment the auto-generated 
*Changes to be committed* section. To further help others retrace our steps, we 
usually refer to GitHub/GitLab/Codeberg issues by their number prepended with 
the “#” symbol. Here’s an example:

```
FIX: Addresses bug in this_function
  
- the problem was fixed by doing something clever
- closes #4
  
Changes to be committed:
    modified:   path/to/file1
    modified:   path/to/file2
```
