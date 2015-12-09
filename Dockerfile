FROM ubuntu:latest

MAINTAINER Divya Mahajan <divya.mahajan@outlook.com>
LABEL description="Mongo database with a host volume. See http://github.com/cs905s/docker/mongo-with-data-volume."

RUN \
   apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
   echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list && \
   apt-get update && \
   apt-get install -y mongodb-org

VOLUME ["/data/db"]
WORKDIR /data

EXPOSE 27017

CMD ["mongod"]
