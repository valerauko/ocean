FROM alpine AS downloader

RUN apk add curl

RUN curl -sflO "https://s3.eu-central-1.amazonaws.com/download.seadrive.org/seafile-server_7.1.5_x86-64.tar.gz"
RUN tar xzvf "seafile-server_7.1.5_x86-64.tar.gz"
RUN sed -i 's/CREATE TABLE `/CREATE TABLE IF NOT EXISTS `/g' \
    seafile-server-7.1.5/seahub/sql/mysql.sql
RUN sed -i 's/INSERT INTO/INSERT IGNORE INTO/g' \
    seafile-server-7.1.5/seahub/sql/mysql.sql

FROM ubuntu:20.04

RUN mkdir -p /opt/seafile

COPY --from=downloader seafile-server-7.1.5 /opt/seafile/seafile-server-7.1.5

WORKDIR /opt/seafile/seafile-server-7.1.5

RUN apt-get update -y && \
    apt-get install -y libmemcached-dev python3 python3-setuptools python3-pip

RUN rm -rf /var/lib/apt/lists/*

RUN pip3 install Pillow pylibmc captcha jinja2 sqlalchemy \
      django-pylibmc django-simple-captcha python3-ldap

RUN mkdir -p /shared/seafile/seafile-data

RUN ln -s /shared/seafile/ccnet /opt/seafile/ccnet && \
    ln -s /shared/seafile/conf /opt/seafile/conf && \
    ln -s /shared/seafile/seafile-data /opt/seafile/seafile-data

COPY setup.sh .
COPY entrypoint.sh .

CMD ./entrypoint.sh
