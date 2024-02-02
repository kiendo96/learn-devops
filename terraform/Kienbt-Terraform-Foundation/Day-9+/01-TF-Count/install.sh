#!/bin/bash

sudo yum update -you
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start

sudo echo '<h1> Welcome to my terraform class </h1>' | sudo tee /var/www/html/index.html
