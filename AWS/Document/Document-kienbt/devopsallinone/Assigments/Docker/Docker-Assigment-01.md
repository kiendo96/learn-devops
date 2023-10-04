## 1. Lab: Creating a Basic Dockerfile

Instructions:
1. Create a new directory for your project.
2. Create a file called `Dockerfile` in the project directory.
3. Add the following lines to the `Dockerfile`:
```
FROM ubuntu:latest
RUN apt-get update && apt-get install -y nginx
CMD ["nginx", "-g", "daemon off;"]
```
4. Build the Docker image using the `docker build` command.
5. Run the Docker container using the `docker run` command.

## 2. Lab: Copying Files to a Docker Image

Instructions:
1. Create a file called `index.html` in your project directory.
2. Update the `Dockerfile` to copy the `index.html` file to the Docker image.
3. Build the Docker image using the `docker build` command.
4. Run the Docker container using the `docker run` command and access the `index.html` file in a web browser.

## 3. Lab: Using Environment Variables in a Dockerfile

Instructions:
1. Update the `Dockerfile` to use an environment variable for the nginx server name.
2. Build the Docker image using the `docker build` command.
3. Run the Docker container using the `docker run` command and pass in a value for the environment variable.

## 4. Lab: Exposing Ports in a Docker Container

Instructions:
1. Update the `Dockerfile` to expose port 80 on the Docker container.
2. Build the Docker image using the `docker build` command.
3. Run the Docker container using the `docker run` command and map port 80 on the container to port 8080 on the host.

## 5. Lab: Specifying Working Directory in a Dockerfile

Instructions:
1. Update the `Dockerfile` to specify the working directory as `/app`.
2. Copy the `index.html` file to the `/app` directory.
3. Build the Docker image using the `docker build` command.
4. Run the Docker container using the `docker run` command and verify that the `index.html` file is in the `/app` directory.

## 6. Lab: Installing Dependencies in a Dockerfile

Instructions:
1. Update the `Dockerfile` to install Node.js and the `npm` package manager.
2. Copy the `package.json` and `index.js` files to the Docker image.
3. Install the dependencies using `npm install`.
4. Build the Docker image using the `docker build` command.
5. Run the Docker container using the `docker run` command and verify that the Node.js application is running.

## 7. Lab: Using Multi-Stage Builds in a Dockerfile

Instructions:
1. Update the `Dockerfile` to use multi-stage builds to reduce the size of the Docker image.
2. Build the Docker image using the `docker build` command.
3. Run the Docker container using the `docker run` command.

## 8. Lab: Using ARG in a Dockerfile

Instructions:
1. Update the `Dockerfile` to use an `ARG` instruction to pass in a build argument.
2. Build the Docker image using the `docker build` command and pass in a value for the build argument.
3. Run the Docker container using the `docker run` command.

## 9. Lab: Running Multiple Services in a Docker Compose File

Instructions:
1. Create a `docker-compose.yaml` file for running multiple services.
2. Define two services in the `docker-compose.yaml` file: one for the Node.js application and one for the nginx reverse proxy.
3. Build the Docker images using the `docker-compose build` command.
4. Run the Docker containers using the `docker-compose up` command.