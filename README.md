# docker-base

Running code depends on computer machinery, operating systems, different packages and software etc. Everyone who runs the code has their own local computing environment that they maintain but this environment naturally differs between users and this can make reproducibility difficult.

[Docker](https://www.docker.com/) containers have become a popular tool for addressing this issue. 

This docker image contains all the `ihmeuw-demographics` R packages and their dependencies.

# Automated builds

A github action to build the docker image and push to the docker hub is triggered with new pull requests to the master branch and new commits to the master branch. Each github action runs with [more resources](https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#supported-runners-and-hardware-resources) than is available by default locally which helps to avoid memory errors when building the image.

They are automatically tagged with `latest` but versioning will be introduced later.

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
