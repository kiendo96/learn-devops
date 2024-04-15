## Building a Docker Image via Dockerfile

When creating Docker images for websites, applications, and any service that may require any code change in the future, it's best to build in a way that can be quickly and easily rebuilt when any changes occur. Dockerfiles provide an in-platform way to do just that. In this lab, we'll be building a Dockerfile that can generate an image of our website that will make sure that when changes happen with the website code, we won't have to change the Dockerfile itself!

Solution


Log in to the lab server using vagrant that you created

```
vargant ssh 
```
Clone this repository from Azure Git Repo
```
git clone https://TOOA01@dev.azure.com/TOOA01/DevOps%20Basic%20Online/_git/DevOps-online-class 
```

Create the Dockerfile
List out the information in our repository that you just clone:

ls
Change directory to containerhub:

cd /Module-4/containerhub
List out the information in containerhub:

ls
List out the information in from the files document:

ls files/
We will see our default.conf file.

See where our information is stored:

cat files/default.conf
We will find it is in /var/www/html/.

Create the Dockerfile:
```
vim Dockerfile
```
Build the file based on the alpine image:
```
FROM alpine:latest
RUN apk upgrade
RUN apk add nginx
COPY files/default.conf /etc/nginx/httpd.d/default.conf
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
COPY --chown=nginx:nginx /files/html/ .
EXPOSE 80
CMD [ "nginx", "-g", "pid /tmp/nginx.pid; daemon off;" ]
```
Save and exit the document by pressing Escape followed by `:wq`.

Build and Test the Image
Build the image:
```
docker build . -t web
```
Check that we have the web image:
```
docker image ls
```
Launch Docker based on the web image:
```
docker run -dt -p 80:80 --name web01 web
```
Once it is finished running, check that the website has been launched:
```
curl localhost
```
We will get the HTML for the website.

Copy the public IP address provided on the lab page, and paste it into a new browser tab. We'll know it worked correctly when the Container Hub website appears.

Conclusion

Congratulations! You've completed the lab!