<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society
Copyright © 2026 Ernst Strüngmann Institute (ESI) of the Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Documentation, Organization and Styleguides

This directory contains documentation templates and suggestions for style guides 
that have proven their usefulness in day-to-day development work. 

## Exemplary README

The README file of a project is the first thing people see on most
popular code sharing platforms (GitHub, GitLab, Codeberg etc.). The file 
[README.md](./readme/README.md) is a template for a typical project 
README that contains a reference structure and also links to separate installation 
and contributing guides. 

To use it in your own project, simply copy the corresponding file(s) to your 
project root:

``` shell
cp readme/README.md /path/to/your/repo/
cp readme/CONTRIBUTING.md /path/to/your/repo/
cp readme/INSTALL.md /path/to/your/repo/
```

## Exemplary CHANGELOG

Once a project hits a certain size and/or age, it becomes tedious to track changes 
browsing its (potentially very long) git log. Instead, it can be quite beneficial 
to explicitly track all notable changes in a dedicated file, usually called 
`CHANGELOG.md`. The included template [CHANGELOG.md](./CHANGELOG.md) is based on 
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and illustrates an 
exemplary layout: 

- each release is summarized in a dedicated section with sub-sections following 
  the blueprint:
  
  ```
  ### NEW
  ### CHANGED
  ### REMOVED
  ### DEPRECATED
  ### FIXED
  ```
  
  Every notable change is included under one of these five sub-sections. 
  
- notable changes introduced in a not yet released staging version of the project
  are similarly noted in an `## [Unreleased]` section

To use the CHANGELOG template in your own project, simply copy it to your project root:

``` shell
cp CHANGELOG.md /path/to/your/repo/
```

## Git Commit Message Style

Over the years the ESI IT Software Support Group has converged on a quick and 
simple yet functional format for writing git commit messages. The included 
[Style Guide](./git_style.md) is a verbatim copy of the corresponding section in 
our internal documentation. 

## Standardized Research Project Directory Layout

A basic but central component of Research Data Management is the organization of 
data on disk. The layout illustrated in [dir_layout.md](./dir_layout.md) 
demonstrates a simple directory structure to get started. 
