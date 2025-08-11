#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras enable php8.0
sudo yum install -y httpd php php-cli
