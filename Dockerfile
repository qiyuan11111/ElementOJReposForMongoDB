FROM ubuntu:18.04
MAINTAINER qiyuan
RUN apt-get update --fix-missing && apt-get -y install sudo gcc g++ openssl libcurl4-openssl-dev --fix-missing
	