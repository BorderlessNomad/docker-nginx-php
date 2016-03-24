# Docker PHP 7 on latest NGINX

* NGINX stable
* PHP 7

## Base for these containers:
* [ahirmayur/phpmyadmin](https://github.com/ahirmayur/docker-phpmyadmin)

## Installation
```
$ docker build -t ahirmayur/nginx-php7 . # If building from source 
$ docker run -d -p 22 -p 80 ahirmayur/nginx-php7
5f1b7a6404c8

$ docker port 5f1b7a6404c8 22
0.0.0.0:32771

$ ssh root@localhost -p 32771 # when promoted for password enter 'root' (without quotes)
```