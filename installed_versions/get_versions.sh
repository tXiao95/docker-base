#!/bin/bash

# get pull-request number used in docker image tag as described https://github.com/docker/build-push-action#tag_with_ref
TAG_WITH_REF=$GITHUB_REF
TAG_WITH_REF=${TAG_WITH_REF/refs\/pull\/}
TAG_WITH_REF=${TAG_WITH_REF/\/merge}

# output the version of R installed
docker run ihmeuwdemographics/base:pr-$TAG_WITH_REF-merge R --version >> installed_versions/R_version.txt

# output all R packages installed
docker run -v ${PWD}/installed_versions:/tmp ihmeuwdemographics/base:pr-$TAG_WITH_REF-merge Rscript /tmp/get_R_packages.R

# output all apt packages manually installed
# perl command to remove colour codes https://superuser.com/questions/380772/removing-ansi-color-codes-from-text-stream
docker run ihmeuwdemographics/base:pr-$TAG_WITH_REF-merge bash -c "apt list --manual-installed --verbose | perl -pe 's/\e\[[0-9;]*m//g'" >> installed_versions/apt_packages.txt
