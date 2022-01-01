FROM mongo
MAINTAINER qiyuan
RUN sed -i 's#http://archive.ubuntu.com/#http://mirrors.tuna.tsinghua.edu.cn/#' /etc/apt/sources.list \
	&& apt-get update --fix-missing && apt-get install openssl gcc g++ --fix-missing \
	&& mkdir -p /mongodb && cd /mongodb && openssl rand -base64 756 > auth.key \
	&& chown -R mongodb:mongodb /mongodb/auth.key && chmod 600 /mongodb/auth.key