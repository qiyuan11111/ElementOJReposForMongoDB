FROM ubuntu:18.04
MAINTAINER qiyuan
COPY sources.list /etc/apt/sources.list
RUN apt-get update --fix-missing && apt-get -y install gcc g++ sudo openssl libcurl4-openssl-dev wget vim --fix-missing \
	&& cd /usr/local/src && wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-4.4.12-rc0.tgz \
	&& tar -zxvf mongodb-linux-x86_64-ubuntu1604-4.4.12-rc0.tgz \
	&& sudo mv mongodb-linux-x86_64-ubuntu1604-4.4.12-rc0/ /usr/local/mongodb
EXPOSE 27017
	