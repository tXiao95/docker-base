#!/bin/bash

# output the version of R installed
docker run -it ihmeuwdemographics/base R --version >> installed_R_version.txt

# output all R packages installed
docker run -it ihmeuwdemographics/base R -e "
    library(data.table);
    installed <- data.table(installed.packages());
    installed <- installed[, .SD, .SDcols = c('Package', 'Version')];
    readr::write_csv(installed, 'installed_R_packages.csv')"

# output all apt packages manually installed
# perl command to remove colour codes https://superuser.com/questions/380772/removing-ansi-color-codes-from-text-stream
docker run -it ihmeuwdemographics/base bash -c "apt list --manual-installed --verbose | perl -pe 's/\e\[[0-9;]*m//g'" >> installed_apt_packages.txt
