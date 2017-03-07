FROM postgres:latest
MAINTAINER siggame

ADD init.sql /docker-entrypoint-initdb.d/