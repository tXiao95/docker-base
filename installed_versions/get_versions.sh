#!/bin/bash

# output the version of R installed
docker run ihmeuwdemographics/base R --version >> installed_versions/R_version.txt

# output all R packages installed
docker run -v ${PWD}/installed_versions:/tmp ihmeuwdemographics/base Rscript /tmp/get_R_packages.R

# output all apt packages manually installed
# perl command to remove colour codes https://superuser.com/questions/380772/removing-ansi-color-codes-from-text-stream
docker run ihmeuwdemographics/base bash -c "apt list --manual-installed --verbose | perl -pe 's/\e\[[0-9;]*m//g'" >> installed_versions/apt_packages.txt
