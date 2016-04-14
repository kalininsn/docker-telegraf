FROM ubuntu:trusty

ENV INFLUXDB_URL http://localhost:8086
ENV INFLUXDB_DB Monitoring
ENV DEBIAN_FRONTEND noninteractive
ENV GOPATH /opt/go

RUN apt-get update && \
    apt-get install -y init-system-helpers curl python-pip wget python-dev git
RUN wget https://storage.googleapis.com/golang/go1.6.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.6.1.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin
RUN pip install envtpl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /opt/go && \
    go get github.com/influxdata/telegraf && \
    cd $GOPATH/src/github.com/influxdata/telegraf && \
    make

COPY telegraf.conf.tpl /etc/telegraf/telegraf.conf.tpl
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD [ "/run.sh" ]
#CMD [ "/opt/go/bin/telegraf -config /etc/telegraf/telegraf.conf" ]
#CMD ["ls /etc/telegraf"]
