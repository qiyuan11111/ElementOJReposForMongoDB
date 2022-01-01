FROM ubuntu:18.04
MAINTAINER qiyuan
COPY sources.list /etc/apt/sources.list
COPY start.sh /mongodb/start.sh
RUN apt-get update --fix-missing && apt-get -y install gcc g++ sudo openssl wget vim libssl1.0.0 libgconf-2-4 libcurl3 --fix-missing \
	&& cd /usr/local/src && wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-4.4.12-rc0.tgz \
	&& tar -zxvf mongodb-linux-x86_64-ubuntu1604-4.4.12-rc0.tgz && chmod 777 /mongodb/start.sh \
	&& sudo mv mongodb-linux-x86_64-ubuntu1604-4.4.12-rc0/ /usr/local/mongodb && chmod -R 777 /usr/local/mongodb
EXPOSE 27017
CMD ["/bin/sh", "/mongodb/start.sh"] 
	