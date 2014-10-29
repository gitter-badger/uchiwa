FROM centos:centos6

RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum --enablerepo centosplus install -y npm git go

ADD . /src
ENV GOPATH /src 
RUN go get github.com/sensu/uchiwa
RUN cd /src && npm install --production --unsafe-perm && mkdir /config && cp /src/docker/config.json /config && mv /src/docker/start /start && chmod 755 /start

EXPOSE 3000
CMD ["/start"]

