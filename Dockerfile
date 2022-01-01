FROM mongo
MAINTAINER qiyuan
COPY sources.list /etc/apt/sources.list
COPY start.sh /mongodb/start.sh
RUN apt-get update --fix-missing && apt-get -y install openssl --fix-missing \
	&& cd /mongodb && openssl rand -base64 756 > auth.key && chmod 777 /mongodb/start.sh\
	&& chown -R mongodb:mongodb /mongodb/auth.key && chmod 600 /mongodb/auth.key
EXPOSE 27017
CMD ["/bin/sh", "/mongodb/start.sh"]
	