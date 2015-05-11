# docker-base-images
Docker base images used with Leitwarte

## Usage
You need a MongoDB to connect to. If you do not have one, you can start a Docker container for it:

```
docker run --name leitwarte-mongo -d mongo
```

Then run the project using

```
docker run -d \
-e ROOT_URL=http://leitwarte.local \
-e MONGO_URL=mongodb://leitwarte-mongo:27017 \
-p 80:3000 \
--link leitwarte-mongo:mongo \
--name leitwarte-web \
leitwarte/leitwarte
```

## Procedure for Dockerfile development
Build the Leitwarte image

```
docker build -t leitwarte-web .
```

Run a MongoDB container which we will name `leitwarte-mongo`

```
docker run --name leitwarte-mongo -d mongo
```

Run the Leitwarte web app

```
docker run -d \
-e ROOT_URL=http://leitwarte.local \
-e MONGO_URL=mongodb://leitwarte-mongo:27017 \
-p 80:3000 \
--link leitwarte-mongo:mongo \
--name leitwarte-web \
leitwarte-web
```
