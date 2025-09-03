<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Research Project Directory Layout

The following sketch demonstrates a very simple folder structure to store any 
data associated with a research project. It is intended as a simple and quickly 
to implement starting point for organizing research data. More comprehensive 
layouts are discussed in [1] and [2]. 

## General Structure 

You may start with the following basic layout:

    ├── Project_Name
    │   ├── Admin
    │   ├── Codes
    │   ├── Data
    │   ├── Literature
    │   ├── Notes
    │   ├── Publications
    │   ├── Results
    └── README.md

The `README.md` file in the project root should provide a (short) overview of each 
directory's contents. The intended purpose of the sub-directories are:

- `Admin`: Everything related to the management aspects of the project, including 
  but not necessarily limited to grant applications, meeting notes, data management 
  plans, hardware orders etc. 
- `Codes`: Any piece of software (packages, libraries, scripts) that has been and 
  is actively used to process data associated with the project. This is also a 
  good place to store local copies of any related git repositories. 
- `Data`: All raw data should reside in here. Depending on the nature of the project
  a sub-division by datasets or modality (cell cultures, MRI, field data etc.) 
  might be useful. If appropriate the corresponding acquisition protocols should 
  go in here as well. 
- `Literature`: Papers, books, technical reports, protocol specifications related 
  to the project. 
- `Notes`: Anything that seems to be noteworthy but does not necessarily fit in 
  any other category. 
- `Publications`: Manuscripts, conference contributions (abstracts, posters etc.)
  arising from the project. 
- `Results`: Processed data, charts, summary statistics etc. 
  
Each sub-directory should contain a dedicated `README.md` that briefly explains 
the folder's contents. 

## Example 

To illustrate the above layout, the following listing sketches an exemplary 
project:

    ├── Project_Name
    │   ├── Admin
    │   │   ├── grant_docs
    │   │   ├── meeting_notes
    │   │   ├── dmps
    │   │   └── orders
    │   │   └── README.md
    │   ├── Codes
    │   │   ├── git_repo1
    │   │   ├── git_repo2
    │   │   ├── preproc_scripts
    │   │   ├── sequences
    │   │   └── README.md
    │   ├── Data
    │   │   ├── mri
    │   │   ├── meg
    │   │   ├── cell_samples
    │   │   └── README.md
    │   ├── Literature
    │   │   ├── topic1
    │   │   ├── topic2
    │   │   ├── lab_of_john_smith
    │   │   └── README.md
    │   ├── Notes
    │   │   ├── mri_building_approach
    │   │   ├── how_to_apply_for_meg_key
    │   │   └── README.md
    │   ├── Publications
    │   │   ├── conferences
    │   │   ├── manuscripts
    │   │   └── README.md
    │   ├── Results
    │   │   ├── mri
    │   │   ├── meg
    │   │   ├── cell_samples
    │   │   └── README.md
    └── README.md

## References

[1] Spreckelsen, F.; Rüchardt, B.; Lebert, J.; Luther, S.; Parlitz, U.; Schlemmer, A. Guidelines for a Standardized Filesystem Layout for Scientific Data. Data 2020, 5, 43. <https://doi.org/10.3390/data5020043>

[2] Colomb, J.; Thorsten, A.; Sehara, K., and The Gin-Tonic team. Towards a Standardized Research Folder Structure. Generation Research, 2021. <https://doi.org/10.25815/WCY6-M233>.


