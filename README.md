Docker for Shiny Server
=======================

This is a Dockerfile for Shiny Server on Debian "testing". It is based on the r-base image.

The image is available from [Docker Hub](https://registry.hub.docker.com/u/rocker/shiny/).

## Usage:

To run a temporary container with Shiny Server:

```sh
docker run --rm -p 3838:3838 rocker/shiny
```


To expose a directory on the host to the container use `-v <host_dir>:<container_dir>`. The following command will use one `/srv/shinyapps` as the Shiny app directory and `/srv/shinylog` as the directory for logs. Note that if the directories on the host don't already exist, they will be created automatically.:

```sh
docker run --rm -p 3838:3838 \
    -v /srv/shinyapps/:/srv/shiny-server/ \
    -v /srv/shinylog/:/var/log/ \
    rocker/shiny
```

If you have an app in /srv/shinyapps/appdir, you can run the app by visiting http://localhost:3838/appdir/. (If using boot2docker, visit http://192.168.59.103:3838/appdir/)


In a real deployment scenario, you will probably want to run the container in detached mode (`-d`) and listening on the host's port 80 (`-p 80:3838`):

```sh
docker run -d -p 80:3838 \
    -v /srv/shinyapps/:/srv/shiny-server/ \
    -v /srv/shinylog/:/var/log/ \
    rocker/shiny
```

If you need to run some code before ShinyServer (e.g. install packages) and don't want to build your own image, you can put it in a directory mounted at `/docker-entrpoint-init.d`. R and sh files will be executed in lexical order. For example, to set up `dplyr`:

### 01-libmysqlclient.sh:

	#!/usr/bin/env bash
	sudo apt-get install -y libmysqlclient-dev

### 02-install\_packages.R
    install.packages(c("ggplot2","ggmap","RMySQL","dplyr"))

These scripts are run each time the container starts, before ShinyServer is run.

## Trademarks

Shiny and Shiny Server are registered trademarks of RStudio, Inc. The use of the trademarked terms Shiny and Shiny Server and the distribution of the Shiny Server through the images hosted on hub.docker.com has been granted by explicit permission of RStudio. Please review RStudio's trademark use policy and address inquiries about further distribution or other questions to permissions@rstudio.com.
