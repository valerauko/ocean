FROM alpine AS downloader

RUN apk add curl

RUN curl -vsflO "https://s3.eu-central-1.amazonaws.com/download.seadrive.org/seafile-server_9.0.9_x86-64.tar.gz"
RUN tar xzvf "seafile-server_9.0.9_x86-64.tar.gz"
RUN sed -i 's/CREATE TABLE `/CREATE TABLE IF NOT EXISTS `/g' \
    seafile-server-9.0.9/seahub/sql/mysql.sql
RUN sed -i 's/INSERT INTO/INSERT IGNORE INTO/g' \
    seafile-server-9.0.9/seahub/sql/mysql.sql

FROM ubuntu:22.04

RUN apt-get update -y && \
    apt-get install -y libmemcached-dev python3 python3-setuptools python3-pip libmysqlclient-dev

RUN mkdir -p /opt/seafile
COPY --from=downloader seafile-server-9.0.9 /opt/seafile/seafile-server-9.0.9
WORKDIR /opt/seafile/seafile-server-9.0.9

RUN rm -rf /var/lib/apt/lists/*

RUN pip3 install Pillow pylibmc captcha jinja2 sqlalchemy==1.3.8 mysqlclient \
    django-pylibmc django-simple-captcha python3-ldap

RUN ln -s /shared/seafile/ccnet /opt/seafile/ccnet && \
    ln -s /shared/seafile/conf /opt/seafile/conf && \
    ln -s /shared/seafile/seafile-data /opt/seafile/seafile-data

COPY setup.sh .
COPY entrypoint.sh .

CMD ./entrypoint.sh
