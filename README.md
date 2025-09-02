<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# esi-ntials

A collection of tools, configs and code snippets that proved to be useful in various situations. 

The repository is organized (roughly) by tech stack: 

- [Shell](./shell/): Helpers for working with the Unix shell
  - [use a settings file](./shell/load_params.sh) collect often used variables and functions in a dedicated file
  - [colored messages/log levels](./shell/log_msg.sh) enable color-coded debug/info/warn/error messages in shell scripts
  - [user queries](./shell/queries_run.sh) use interactive prompts in scripts
  - [string handling](./shell/pass_vars.sh) use arrays to safely process and parse strings

- [Databases](./db/): Configuration and initialization of common database systems
  - [SQLite tuning](./db/sqlite_tuning.sql) use [sensible defaults](https://briandouglas.ie/sqlite-defaults/) to speed up SQLite

- [Documentation](./doc/): Templates for project documentation and organization
  - [README](./doc/readme/README.md) Exemplary README for a project repository
  - [CHANGELOG](./doc/CHANGELOG.md) Exemplary CHANGELOG for a project repository
  - [Git Style Guide](./doc/git_style.md) A suggestion for formatting git commits

Todo:

- Python logging setup + custom log-levels (ANNOUNCE)
- Include reuse badge
- RDM setup von Joscha
- rsync gymnastics from cheats.pdf
- how to set up ssh config files (PS script + bash/zsh)

## Getting Started

Either use the above index or simply browse the repository. If you find anything 
interesting feel free to copy-paste the respective parts (please include the 
license note at the top of the corresponding file). 

## Description

This repository is a collection of code snippets, common configuration stubs and 
templates that have been collected over the years by the ESI IT Software Support Group. 
The objective of this project is to save time and/or reduce mental load trying 
to answer the ever-recurring question: 

**"I need to do x here. I remember I have done something similar before, but where was that again..?"**

Thus, everything in this repository is general enough that it has been used at least 
twice in the past, but still specific enough that cooking it up from scratch is 
not effortless. 

## Installation

The polytopical nature of this repository doesn't really lend itself to provide 
general purpose installation instructions. If you need to [tune your SQLite database](./db/sqlite_tuning.sql), 
you probably already have SQLite set up and running on your system. If you're 
looking for a way to [better structure status messages in Bash](./shell/log_msg.sh), 
you're probably already working in Bash. Thus, no single "installation" is 
required to use the things collected in here, however, almost all bits and pieces
require some kind of base technology (e.g., SQLite, Bash) to be available on your 
system. Please refer to the respective official documentation to set up the corresponding 
components. 

The notable exception to this rule is the provided [Python](./python/) section, 
which comes with a conda environment file to quickly set up all required packages 
(including other tools like `sqlite` used in the repository). 

## Usage

Find what you need by browsing the repository or skimming the index at the top. 
Then simply copy-paste the parts that seem useful to you (please include the 
license note at the top of the corresponding file). 

## Support

If you have questions or find bugs/inconsistencies, please 
[open an issue](https://github.com/esi-neuroscience/esi-ntials/issues/new). 

## Roadmap

Due to the nature of this project, we are not using releases or milestones. 
However, we plan to extend this repository everytime we find ourselves asking the 
above mentioned *"Where was that again?..."* question. 

## Contributing

Contributions are always welcome! Feel free to 
[open an issue](https://github.com/esi-neuroscience/esi-ntials/issues/new) 
to propose changes/additions. Alternatively, you can also 
[fork this repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo), 
and open a [pull request](https://github.com/esi-neuroscience/esi-ntials/pulls). 

## Authors and Acknowledgment

Initial version put together by [Stefan Fürtinger](https://github.com/pantaray). 

## Project Status

This project is actively maintained and on occasion updated.
