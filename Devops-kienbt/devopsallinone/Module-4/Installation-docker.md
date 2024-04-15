## Installation
To get hands-on with our learning, we're going to be looking at Docker, by far one of the most popular container solutions out there. While Docker is available on Windows, Mac, and various Linux distributions

 Were we working on a distro that did, we would want to remove any packages with these names: docker, docker-engine, docker.io, containerd, and runc.

### Using Vagrant
```
vagrant init ubuntu/bionic64
```
Access into vagrant machine

```
vagrant ssh
```

```
 # -*- mode: ruby -*-
 # vi: set ft=ruby :

 Vagrant.configure("2") do |config|
   config.vm.box = "ubuntu/bionic64"
 end
```
 Since we can bypass that step, we'll start with updating our machine.

 ```
 sudo apt update
 ```
 And then install any prerequisite packages.

 ```
 sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
 ```
 We can now add Docker's GPG key.
 ```
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 ```
 And verify its configuration.
 ```
 sudo apt-key fingerprint 0EBFCD88
 ```
 To add the Docker repository, we now just need to run:
 ```
 sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
 ```
 And update our server again.
 ```
 sudo apt update
 ```
 We can now install the necessary packages.
 ```
 sudo apt install docker-ce docker-ce-cli containerd.io
 ```
 To finish up, we want to add our `vagrant` user to the docker group.

```
sudo usermod vagrant -aG docker
```
Log out then log back in to refresh the Bash session before running any docker commands.

`Wrapp up`
```
Wrap-Up
Install Docker by:
Removing any existing version of Docker installed.
Adding the Docker repository.
Be sure to add the fingerprint first!
Installing the following packages:
docker-ce
docker-ce-cli
containerd.io
Run sudoless by adding user to the docker group
```