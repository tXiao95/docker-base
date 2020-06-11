# docker-base

Running code depends on computer machinery, operating systems, different packages and software etc. Everyone who runs the code has their own local computing environment that they maintain but this environment naturally differs between users and this can make reproducibility difficult.

[Docker](https://www.docker.com/) containers have become a popular tool for addressing this issue. 

This docker image contains all the `ihmeuw-demographics` R packages and their dependencies.

## How to run the container on a local machine

The following command tells docker to pull the `ihmeuwdemographics/base` image from [DockerHub](https://hub.docker.com/repository/docker/ihmeuwdemographics/base) and launches an Rstudio-Server session. The Rstudio-Server session will then be accessible at the specified port `http://localhost:8787`. The default username and password is 'rstudio'.

```
docker run --rm -p 8787:8787 ihmeuwdemographics/base
```

## How to update the image

```
docker build -t ihmeuwdemographics/base:{tag} .
docker push ihmeuwdemographics/base
```

## Resources

[Getting Started](https://docs.docker.com/get-started/)

[R Docker Tutorial](http://ropenscilabs.github.io/r-docker-tutorial/)
