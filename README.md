# docker-base

Running code depends on computer machinery, operating systems, different packages and software etc. Everyone who runs the code has their own local computing environment that they maintain but this environment naturally differs between users and this can make reproducibility difficult.

[Docker](https://www.docker.com/) containers have become a popular tool for addressing this issue. 

This docker image contains all the `ihmeuw-demographics` R packages and their dependencies. The `Dockerfile` contains the directions for building the image and the resulting image is pushed to the [Docker Hub](https://hub.docker.com/repository/docker/ihmeuwdemographics/base/general).

# Automated builds

[Github Actions](https://docs.github.com/en/actions) are used to automatically build the docker image. Each github action runs with [more resources](https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#supported-runners-and-hardware-resources) than is available by default locally which helps to avoid memory errors when building the image.

# Test PR

Every pull request to the master branch is automatically built but not pushed to the docker hub.

# Production builds

There are multiple changes that might motivate a new build of the docker image and push to the docker hub with a versioned tag.

1. Push to the base [rocker](https://github.com/rocker-org/rocker) image.

2. Push to the master branch of any of the demographics R packages.

3. Push to the master branch of this repo.

Currently the workflow is set up to rebuild and push the docker image when a new [github tag](https://git-scm.com/book/en/v2/Git-Basics-Tagging) is pushed to the remote. This manual workflow is used rather than automatic rebuilds because there would likely be too many rebuilds triggered by the above changes and it would be difficult to track.

## Versioning of tags

Docker image tags can be used to differentiate different versions of an image.

The tags for this image will be formatted like `v{gbd_year}.{release_number}.{patch}`.

We need to differentiate the images used for different GBD years and releases within each GBD year. In addition within each release there may be multiple images built with different software included or versions of software.

An example call to create and push a tag:

```
git tag -a v2020.0.0-alpha
git push origin v2020.0.0-alpha
```

# Local builds

Building and running images locally can be useful for testing purposes.

## How to run the container on a local machine

The following command tells docker to pull the `ihmeuwdemographics/base` image from [DockerHub](https://hub.docker.com/repository/docker/ihmeuwdemographics/base) and launches an Rstudio-Server session. The Rstudio-Server session will then be accessible at the specified port `http://localhost:8787`. The default username and password is 'rstudio'.

```
docker run --rm -p 8787:8787 ihmeuwdemographics/base
```

## How to update the image

When building the image with stan, sometimes an error due to running out of memory can occur. Adding the `-m` option to [increase memory](https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory) can address this issue, on a Mac you need to open up the preferences window for docker to adjust memory.

```
docker build -t ihmeuwdemographics/base:{tag} .
docker push ihmeuwdemographics/base
```

## Resources

[Getting Started](https://docs.docker.com/get-started/)

[R Docker Tutorial](http://ropenscilabs.github.io/r-docker-tutorial/)
