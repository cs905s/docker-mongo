# DockerHub - docker.io/dmahajan/mongo-with-data-volume
#
This is an example from https://devops.profitbricks.com/tutorials/creating-a-mongodb-docker-container-with-an-attached-storage-volume/

It creates a MongoDB cluster with a data volume that can be mapped to a host volume.

One of the great things about Docker is with little effort you can spin up a container and begin to work with a new technology. In this case, we'll be spinning up MongoDB within a container using an external path on the host for data storage.

We will introduce you to two Docker concepts: mapping volumes between containers and using a Dockerfile to automate the build.

## Running and testing Mongo
Install the Mongo client on your computer by following the documentation at the mongodb website. [Installation instructions](https://docs.mongodb.org/manual/installation/).
```
mkdir -p ./data/mongo
docker run --name mongo-dev -d -v `pwd`/data/mongo:/data/db -p 27017 dmahajan/mongo-with-data-volume
```
The -v switch indicates your our mapping your local host /opt/mongodb directory with the /data/db directory within the container. The --name switch names the running instance.

Run docker ps to validate the container is running and mapping 27017 to a local port. You should also make note of the local port on the host system to which it is mapped. We'll need this value in the next step.

Let's go ahead and ensure we can connect to the server and create a new db with a record. You will need the mongo client tools installed to issue the next commands. Be sure to install the shell and tools match the version of mongo installed in your container:
```
mongo localhost:49155
```
Replace 49155 with the local port shown in your docker ps output.
You should now be at a Mongo prompt.
Create your new database:
```
use mynewdb
```
Next, let's use MongoDB's sample data script to populate a testData collection:
```
for (var i=1;i<25;i++) {
  db.testData.insert( {x:i})
}
```
Query the data:
```
db.testData.find()
```
Finally, exit the MongoDB shell:
```
quit()
```
Now, let's just be sure that the instance of Mongo is actually keeping the db files outside of the container by doing a ls on ./data/mongo.

Stop the running container
```
docker stop mongo-dev
```

## Building the docker image from source
If you want to build your own image to get the latest Ubuntu and Mongo fixes, use the following instructions instead.
```
git clone https://github.com/cs905s/docker/mongo-with-data-volume
cd mongo-with-data-volume
docker build mongo-with-data-volume
mkdir -p ./data/mongo
docker run --name mongo-dev -d -v `pwd`/data/mongo:/data/db -p 27017 mongo-with-data-volume
```

