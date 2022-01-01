FROM mongo
MAINTAINER qiyuan
COPY sources.list /etc/apt/sources.list
RUN apt-get update --fix-missing && apt-get -y install openssl --fix-missing \
	&& mkdir -p /mongodb && cd /mongodb && openssl rand -base64 756 > auth.key \
	&& chown -R mongodb:mongodb /mongodb/auth.key && chmod 600 /mongodb/auth.key
EXPOSE 27017
	